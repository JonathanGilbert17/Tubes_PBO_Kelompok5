package servlet;

import dao.SaveDAO;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SaveServlet")
public class SaveServlet extends HttpServlet {
    private SaveDAO saveDAO;

    @Override
    public void init() throws ServletException {
        saveDAO = new SaveDAO();
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
        int videoId = Integer.parseInt(request.getParameter("videoId"));
        String redirectTo = request.getParameter("redirectTo");

        if (saveDAO.isSaved(currentUser.getUserId(), videoId)) {
            saveDAO.unsaveVideo(currentUser.getUserId(), videoId);
        } else {
            saveDAO.saveVideo(currentUser.getUserId(), videoId);
        }

        response.sendRedirect(redirectTo != null ? redirectTo : "HomeServlet");
    }
}