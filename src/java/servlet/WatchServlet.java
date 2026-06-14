package servlet;

import dao.CommentDAO;
import dao.VideoDAO;
import model.Comment;
import model.Video;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.LikeDAO;
import model.User;
import javax.servlet.http.HttpSession;
import dao.SubscribeDAO;
import dao.SaveDAO;


@WebServlet("/WatchServlet")
public class WatchServlet extends HttpServlet {
    private VideoDAO videoDAO;
    private CommentDAO commentDAO;
    private LikeDAO likeDAO;
    private SubscribeDAO subscribeDAO;
    private SaveDAO saveDAO;

    @Override
    public void init() throws ServletException {
        videoDAO = new VideoDAO();
        commentDAO = new CommentDAO();
        likeDAO = new LikeDAO();
        subscribeDAO = new SubscribeDAO();
        saveDAO = new SaveDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("HomeServlet");
            return;
        }

        int videoId = Integer.parseInt(idParam);
        Video video = videoDAO.getVideoById(videoId);

        if (video != null) {
            videoDAO.incrementViews(videoId);
            video.setViews(video.getViews() + 1);
            video.setLikeCount(likeDAO.getLikeCount(videoId));
            HttpSession session = request.getSession(false);
            User currentUser = null;
            if (session != null && session.getAttribute("currentUser") != null) {
                currentUser = (User) session.getAttribute("currentUser");
            }

            int uploaderUserId = video.getUploaderUserId();
            request.setAttribute("uploaderUserId", uploaderUserId);
            request.setAttribute("subscriberCount", subscribeDAO.getSubscriberCount(uploaderUserId));

            if (currentUser != null) {
                video.setLikedByCurrentUser(likeDAO.isLikedByUser(videoId, currentUser.getUserId()));
                request.setAttribute("isSubscribed", subscribeDAO.isSubscribed(currentUser.getUserId(), uploaderUserId));
                request.setAttribute("isSaved", saveDAO.isSaved(currentUser.getUserId(), videoId));
            } else {
                request.setAttribute("isSubscribed", false);
                request.setAttribute("isSaved", false);
            }
            List<Comment> commentList = commentDAO.getCommentsByVideoId(videoId);
            request.setAttribute("video", video);
            request.setAttribute("comments", commentList);
            request.getRequestDispatcher("watch.jsp").forward(request, response);
        } else {
            response.sendRedirect("HomeServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}