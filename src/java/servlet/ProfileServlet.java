package servlet;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@WebServlet("/ProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
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
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String bio = request.getParameter("bio");

        currentUser.setUsername(username);
        currentUser.setEmail(email);
        currentUser.setBio(bio);
        
        Part picturePart = request.getPart("profilePicture");
        if (picturePart != null && picturePart.getSize() > 0) {
            String uploadPath = "C:" + File.separator + "vtube_uploads";
            new File(uploadPath).mkdirs();
            String fileName = System.currentTimeMillis() + "_" + getFileName(picturePart);
            picturePart.write(uploadPath + File.separator + fileName);
            currentUser.setProfilePicture("uploads/" + fileName);
        }

        boolean success = userDAO.updateProfile(currentUser);

        if (success) {
            session.setAttribute("currentUser", currentUser);
            response.sendRedirect("HomeServlet?status=profileUpdated");
        } else {
            response.sendRedirect("HomeServlet?status=profileUpdateFailed");
        }
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "profile_pic.jpg";
    }
}