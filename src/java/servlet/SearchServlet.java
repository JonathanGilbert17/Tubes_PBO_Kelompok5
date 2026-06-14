package servlet;

import dao.VideoDAO;
import model.Video;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private VideoDAO videoDAO;

    @Override
    public void init() throws ServletException {
        videoDAO = new VideoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String query = request.getParameter("query");
        List<Video> searchResults;

        if (query != null && !query.trim().isEmpty()) {
            searchResults = videoDAO.searchVideos(query);
        } else {
            searchResults = videoDAO.getAllVideos("newest");
        }

        request.setAttribute("videos", searchResults);
        request.setAttribute("searchQuery", query);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}