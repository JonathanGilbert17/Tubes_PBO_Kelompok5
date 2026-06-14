package servlet;

import dao.SaveDAO;
import model.User;
import model.Video;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SavedVideosServlet")
public class SavedVideoServlet extends HttpServlet {
    private SaveDAO saveDAO;

    @Override
    public void init() throws ServletException {
        saveDAO = new SaveDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        List<Video> savedList = saveDAO.getSavedVideos(currentUser.getUserId());
        request.setAttribute("savedList", savedList);
        request.getRequestDispatcher("saved.jsp").forward(request, response);
    }
}