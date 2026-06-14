package servlet;

import dao.CommentDAO;
import model.Comment;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
    private CommentDAO commentDAO;

    @Override
    public void init() throws ServletException {
        commentDAO = new CommentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");
        String videoIdParam = request.getParameter("videoId");
        String commentText = request.getParameter("comment");

        if (videoIdParam != null && commentText != null && !commentText.trim().isEmpty()) {
            int videoId = Integer.parseInt(videoIdParam);

            Comment comment = new Comment();
            comment.setVideoId(videoId);
            comment.setUserId(user.getUserId());
            comment.setComment(commentText);

            commentDAO.addComment(comment);
            response.sendRedirect("WatchServlet?id=" + videoId);
        } else {
            response.sendRedirect("HomeServlet");
        }
    }
}