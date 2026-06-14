<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Video - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .upload-container { width: 500px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .upload-container h2 { margin-bottom: 20px; text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; }
        .form-group input[type="text"], .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .form-group textarea { height: 100px; resize: none; }
        .btn-submit { width: 100%; padding: 10px; background-color: #ff0000; border: none; color: white; font-size: 16px; border-radius: 4px; cursor: pointer; }
        .btn-submit:hover { background-color: #cc0000; }
        .error-msg { color: red; text-align: center; margin-bottom: 15px; }
        .back-link { display: block; text-align: center; margin-top: 15px; color: #333; text-decoration: none; }
    </style>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <div class="upload-container">
        <h2>Upload Video Baru</h2>
        <% if ("failed".equals(request.getParameter("status"))) { %>
            <div class="error-msg">Gagal mengunggah video. Silakan coba lagi.</div>
        <% } %>
        <form action="UploadServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Judul Video</label>
                <input type="text" name="title" required>
            </div>
            <div class="form-group">
                <label>Deskripsi</label>
                <textarea name="description"></textarea>
            </div>
            <div class="form-group">
                <label>File Video (MP4)</label>
                <input type="file" name="video" accept="video/mp4" required>
            </div>
            <div class="form-group">
                <label>File Thumbnail (JPG/PNG)</label>
                <input type="file" name="thumbnail" accept="image/*" required>
            </div>
            <button type="submit" class="btn-submit">Publikasikan Video</button>
        </form>
        <a href="HomeServlet" class="back-link">Kembali ke Beranda</a>
    </div>
</body>
</html>