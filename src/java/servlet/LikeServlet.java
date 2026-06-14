package servlet;

import dao.LikeDAO;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
    private LikeDAO likeDAO;

    @Override
    public void init() throws ServletException {
        likeDAO = new LikeDAO();
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

        if (videoIdParam != null) {
            int videoId = Integer.parseInt(videoIdParam);
            likeDAO.toggleLike(videoId, user.getUserId());
            response.sendRedirect("WatchServlet?id=" + videoId);
        } else {
            response.sendRedirect("HomeServlet");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}