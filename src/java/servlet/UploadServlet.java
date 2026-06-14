package servlet;

import dao.VideoDAO;
import model.User;
import model.Video;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 50,
    maxRequestSize = 1024 * 1024 * 100
)
public class UploadServlet extends HttpServlet {
    private VideoDAO videoDAO;

    @Override
    public void init() throws ServletException {
        videoDAO = new VideoDAO();
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
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        Part videoPart = request.getPart("video");
        Part thumbPart = request.getPart("thumbnail");

        String uploadPath = "C:" + File.separator + "vtube_uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String videoFileName = System.currentTimeMillis() + "_" + getFileName(videoPart);
        String thumbFileName = System.currentTimeMillis() + "_" + getFileName(thumbPart);

        videoPart.write(uploadPath + File.separator + videoFileName);
        thumbPart.write(uploadPath + File.separator + thumbFileName);

        Video video = new Video();
        video.setUserId(user.getUserId());
        video.setTitle(title);
        video.setDescription(description);
        video.setVideoPath("uploads/" + videoFileName);
        video.setThumbnailPath("uploads/" + thumbFileName);

        boolean success = videoDAO.uploadVideo(video);

        if (success) {
            response.sendRedirect("HomeServlet");
        } else {
            response.sendRedirect("upload.jsp?status=failed");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}