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

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private VideoDAO videoDAO;

    @Override
    public void init() throws ServletException {
        videoDAO = new VideoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String filter = request.getParameter("filter");
        if (filter == null) filter = "newest";
        List<Video> videoList = videoDAO.getAllVideos(filter);
        request.setAttribute("videoList", videoList);
        request.setAttribute("currentFilter", filter);
        request.setAttribute("videos", videoList);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}