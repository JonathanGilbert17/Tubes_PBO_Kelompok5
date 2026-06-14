package servlet;

import dao.SubscribeDAO;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SubscribeServlet")
public class SubscribeServlet extends HttpServlet {
    private SubscribeDAO subscribeDAO;

    @Override
    public void init() throws ServletException {
        subscribeDAO = new SubscribeDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        int subscriberId = currentUser.getUserId();
        int creatorId = Integer.parseInt(request.getParameter("creatorId"));
        String redirectTo = request.getParameter("redirectTo");

        // Tidak bisa subscribe diri sendiri
        if (subscriberId == creatorId) {
            response.sendRedirect(redirectTo != null ? redirectTo : "HomeServlet");
            return;
        }

        boolean alreadySubscribed = subscribeDAO.isSubscribed(subscriberId, creatorId);
        if (alreadySubscribed) {
            subscribeDAO.unsubscribe(subscriberId, creatorId);
        } else {
            subscribeDAO.subscribe(subscriberId, creatorId);
        }

        response.sendRedirect(redirectTo != null ? redirectTo : "HomeServlet");
    }
}