package servlet;

import dao.UserDAO;
import model.User;
import model.Video;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.SubscribeDAO;
import javax.servlet.http.HttpSession;

@WebServlet("/ChannelServlet")
public class ChannelServlet extends HttpServlet {
    private UserDAO userDAO;
    private SubscribeDAO subscribeDAO;

    @Override
    public void init() throws ServletException { 
        userDAO = new UserDAO();
        subscribeDAO = new SubscribeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        if (userIdParam == null) { response.sendRedirect("HomeServlet"); return; }
        try {
            int userId = Integer.parseInt(userIdParam);
            User channelUser = userDAO.getUserById(userId);
            if (channelUser == null) { response.sendRedirect("HomeServlet"); return; }
            List<Video> videos = userDAO.getVideosByUserId(userId);
            request.setAttribute("channelUser", channelUser);
            request.setAttribute("channelVideos", videos);
            int subCount = subscribeDAO.getSubscriberCount(userId);
            request.setAttribute("subscriberCount", subCount);

            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("currentUser") != null) {
                User currentUser = (User) session.getAttribute("currentUser");
                request.setAttribute("isSubscribed", subscribeDAO.isSubscribed(currentUser.getUserId(), userId));
                request.setAttribute("isOwnChannel", currentUser.getUserId() == userId);
            } else {
                request.setAttribute("isSubscribed", false);
                request.setAttribute("isOwnChannel", false);
            }
            request.getRequestDispatcher("channel.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("HomeServlet");
        }
    }
}