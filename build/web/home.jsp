<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Video, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #fafafa; }
        .navbar { background-color: #fff; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; }
        .navbar .logo { font-size: 24px; font-weight: bold; color: #ff0000; text-decoration: none; }
        .search-bar form { display: flex; }
        .search-bar input { padding: 8px; width: 300px; border: 1px solid #ddd; border-radius: 4px 0 0 4px; }
        .search-bar button { padding: 8px 15px; background-color: #f8f8f8; border: 1px solid #ddd; border-left: none; border-radius: 0 4px 4px 0; cursor: pointer; }
        .nav-links a { margin-left: 15px; text-decoration: none; color: #333; }
        .container { padding: 20px; max-width: 1200px; margin: 0 auto; }
        .video-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; margin-top: 20px; }
        .video-card { background: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #eee; text-decoration: none; color: #333; display: flex; flex-direction: column; }
        .video-card img { width: 100%; height: 150px; object-fit: cover; }
        .video-info { padding: 10px; }
        .video-title { font-weight: bold; font-size: 16px; margin-bottom: 5px; height: 40px; overflow: hidden; }
        .video-views { color: #606060; font-size: 14px; }
        .filter-bar { margin-bottom: 16px; display: flex; gap: 10px; }
        .filter-btn { padding: 7px 16px; border: 1px solid #ddd; border-radius: 20px; background: #f1f1f1; cursor: pointer; text-decoration: none; color: #333; font-size: 14px; }
        .filter-btn.active { background: #0066cc; color: #fff; border-color: #0066cc; }
    </style>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
    %>
    <div class="navbar">
        <a href="HomeServlet" class="logo">VTube</a>
        <a href="SavedVideosServlet">Video Tersimpan</a>
        <div class="search-bar">
            <form action="SearchServlet" method="get">
                <input type="text" name="query" placeholder="Cari video..." value="${searchQuery != null ? searchQuery : ''}">
                <button type="submit">Cari</button>
            </form>
        </div>
        <div class="nav-links">
            <% if (currentUser != null) { %>
                <a href="ProfileServlet" style="text-decoration:none; color:#333; font-weight:bold;">Halo, <%= currentUser.getUsername() %></a>
                <a href="upload.jsp">Upload</a>
                <a href="LogoutServlet">Logout</a>
            <% } else { %>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            <% } %>
        </div>
    </div>

    <div class="container">
        <h2>Rekomendasi Video</h2>
        <%
            String currentFilter = (String) request.getAttribute("currentFilter");
            if (currentFilter == null) currentFilter = "newest";
        %>
        <div class="filter-bar">
            <a href="HomeServlet?filter=newest" class="filter-btn <%= "newest".equals(currentFilter) ? "active" : "" %>">Terbaru</a>
            <a href="HomeServlet?filter=most_viewed" class="filter-btn <%= "most_viewed".equals(currentFilter) ? "active" : "" %>">Paling Banyak Ditonton</a>
        </div>
        <div class="video-grid">
            <%
                List<Video> videos = (List<Video>) request.getAttribute("videos");
                if (videos != null && !videos.isEmpty()) {
                    for (Video v : videos) {
            %>
                <a href="WatchServlet?id=<%= v.getVideoId() %>" class="video-card">
                    <img src="<%= v.getThumbnailPath() %>" alt="Thumbnail">
                    <div class="video-info">
                        <div class="video-title"><%= v.getTitle() %></div>
                        <div class="video-views"><%= v.getViews() %> kali ditonton</div>
                    </div>
                </a>
            <%
                    }
                } else {
            %>
                <p>Tidak ada video yang ditemukan.</p>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>