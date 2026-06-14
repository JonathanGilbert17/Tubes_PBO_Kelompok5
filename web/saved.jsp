<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Video, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Video Tersimpan - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #fafafa; }
        .navbar { background-color: #fff; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; }
        .navbar .logo { font-size: 24px; font-weight: bold; color: #ff0000; text-decoration: none; }
        .navbar a { text-decoration: none; color: #333; margin-left: 15px; }
        .container { max-width: 960px; margin: 30px auto; padding: 0 20px; }
        .page-title { font-size: 22px; font-weight: bold; margin-bottom: 20px; color: #333; }
        .video-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(210px, 1fr)); gap: 20px; }
        .video-card { background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 4px rgba(0,0,0,0.08); transition: transform 0.15s; text-decoration: none; color: inherit; display: block; }
        .video-card:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.13); }
        .video-thumbnail { width: 100%; aspect-ratio: 16/9; object-fit: cover; background-color: #ddd; display: block; }
        .thumbnail-placeholder { width: 100%; aspect-ratio: 16/9; background-color: #ddd; display: flex; align-items: center; justify-content: center; color: #aaa; font-size: 28px; }
        .video-info { padding: 10px 12px 14px; }
        .video-title-text { font-size: 14px; font-weight: bold; color: #333; margin-bottom: 4px; line-height: 1.4; }
        .video-uploader { font-size: 12px; color: #606060; margin-bottom: 3px; }
        .video-views { font-size: 12px; color: #888; }
        .empty-msg { text-align: center; color: #888; margin-top: 60px; font-size: 15px; }
    </style>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) { response.sendRedirect("login.jsp"); return; }
        List<Video> savedList = (List<Video>) request.getAttribute("savedList");
    %>
    <div class="navbar">
        <a href="HomeServlet" class="logo">VTube</a>
        <div>
            <a href="HomeServlet">Beranda</a>
            <a href="SavedVideosServlet">Video Tersimpan</a>
            <a href="ProfileServlet">Profil</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="page-title">📋 Video Tersimpan</div>
        <% if (savedList != null && !savedList.isEmpty()) { %>
            <div class="video-grid">
                <% for (Video v : savedList) { %>
                    <a href="WatchServlet?id=<%= v.getVideoId() %>" class="video-card">
                        <% if (v.getThumbnailPath() != null && !v.getThumbnailPath().isEmpty()) { %>
                            <img class="video-thumbnail" src="${pageContext.request.contextPath}/<%= v.getThumbnailPath() %>" alt="<%= v.getTitle() %>">
                        <% } else { %>
                            <div class="thumbnail-placeholder">▶</div>
                        <% } %>
                        <div class="video-info">
                            <div class="video-title-text"><%= v.getTitle() %></div>
                            <div class="video-uploader"><%= v.getUploaderUsername() %></div>
                            <div class="video-views"><%= v.getViews() %> x ditonton</div>
                        </div>
                    </a>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-msg">Belum ada video yang disimpan.</div>
        <% } %>
    </div>
</body>
</html>