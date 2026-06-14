<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Video, java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Channel - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #fafafa; }
        .navbar { background-color: #fff; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; }
        .navbar .logo { font-size: 24px; font-weight: bold; color: #ff0000; text-decoration: none; }
        .navbar a { text-decoration: none; color: #333; margin-left: 15px; }

        .channel-banner {
            background: linear-gradient(135deg, #0066cc 0%, #003d7a 100%);
            padding: 40px 30px 30px;
        }
        .channel-info {
            max-width: 960px; margin: 0 auto;
            display: flex; align-items: center; gap: 24px;
        }
        .channel-avatar {
            width: 90px; height: 90px; border-radius: 50%;
            background-color: #fff; border: 3px solid rgba(255,255,255,0.7);
            display: flex; align-items: center; justify-content: center;
            font-size: 38px; font-weight: bold; color: #0066cc;
            overflow: hidden; flex-shrink: 0;
        }
        .channel-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .channel-text { color: #fff; }
        .channel-name { font-size: 28px; font-weight: bold; margin-bottom: 6px; }
        .channel-bio { font-size: 14px; opacity: 0.85; margin-bottom: 6px; max-width: 500px; }
        .channel-joined { font-size: 13px; opacity: 0.7; }

        .container { max-width: 960px; margin: 30px auto; padding: 0 20px; }
        .section-title { font-size: 18px; font-weight: bold; margin-bottom: 16px; color: #333; border-bottom: 2px solid #0066cc; padding-bottom: 8px; display: inline-block; }
        .video-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(210px, 1fr)); gap: 20px; }
        .video-card { background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 4px rgba(0,0,0,0.08); transition: transform 0.15s; text-decoration: none; color: inherit; display: block; }
        .video-card:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.13); }
        .video-thumbnail { width: 100%; aspect-ratio: 16/9; object-fit: cover; background-color: #ddd; display: block; }
        .thumbnail-placeholder { width: 100%; aspect-ratio: 16/9; background-color: #ddd; display: flex; align-items: center; justify-content: center; color: #aaa; font-size: 28px; }
        .video-info { padding: 10px 12px 14px; }
        .video-title-text { font-size: 14px; font-weight: bold; color: #333; margin-bottom: 5px; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        .video-views { font-size: 12px; color: #888; }
        .no-videos { text-align: center; color: #888; margin-top: 50px; font-size: 15px; }
        .subscribe-btn {
            padding: 10px 24px; border: none; border-radius: 20px;
            background-color: #cc0000; color: #fff;
            cursor: pointer; font-size: 15px; font-weight: bold;
        }
        .subscribe-btn.subscribed { background-color: #aaa; }
        .subscriber-count { color: rgba(255,255,255,0.8); font-size: 14px; margin-top: 6px; }
    </style>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
        User channelUser = (User) request.getAttribute("channelUser");
        List<Video> channelVideos = (List<Video>) request.getAttribute("channelVideos");
    %>

    <div class="navbar">
        <a href="HomeServlet" class="logo">VTube</a>
        <div>
            <a href="HomeServlet">Beranda</a>
            <% if (currentUser != null) { %>
                <a href="ProfileServlet">Profil</a>
                <a href="LogoutServlet">Logout</a>
            <% } else { %>
                <a href="login.jsp">Login</a>
            <% } %>
        </div>
    </div>

    <% if (channelUser != null) { %>

    <div class="channel-banner">
        <div class="channel-info">
            <div class="channel-avatar">
                <% if (channelUser.getProfilePicture() != null && !channelUser.getProfilePicture().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/<%= channelUser.getProfilePicture() %>" alt="Foto Profil">
                <% } else { %>
                    <%= String.valueOf(channelUser.getUsername().charAt(0)).toUpperCase() %>
                <% } %>
            </div>
            <div class="channel-text">
                <div class="channel-name"><%= channelUser.getUsername() %></div>
                <% if (channelUser.getBio() != null && !channelUser.getBio().isEmpty()) { %>
                    <div class="channel-bio"><%= channelUser.getBio() %></div>
                <% } %>
                <div class="channel-joined">Bergabung sejak: <%= new SimpleDateFormat("dd MMM yyyy").format(channelUser.getCreatedAt()) %></div>
                <%
                    Boolean isSubscribed = (Boolean) request.getAttribute("isSubscribed");
                    Boolean isOwnChannel = (Boolean) request.getAttribute("isOwnChannel");
                    Integer subscriberCount = (Integer) request.getAttribute("subscriberCount");
                %>
                <div class="subscriber-count"><%= subscriberCount != null ? subscriberCount : 0 %> subscriber</div>
                <% if (currentUser != null && !Boolean.TRUE.equals(isOwnChannel)) { %>
                    <form action="SubscribeServlet" method="post" style="margin-top:12px;">
                        <input type="hidden" name="creatorId" value="<%= channelUser.getUserId() %>">
                        <input type="hidden" name="redirectTo" value="ChannelServlet?userId=<%= channelUser.getUserId() %>">
                        <button type="submit" class="subscribe-btn <%= Boolean.TRUE.equals(isSubscribed) ? "subscribed" : "" %>">
                            <%= Boolean.TRUE.equals(isSubscribed) ? "Berlangganan ✓" : "Berlangganan" %>
                        </button>
                    </form>
                <% } %>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="section-title">Video dari <%= channelUser.getUsername() %></div>

        <% if (channelVideos != null && !channelVideos.isEmpty()) { %>
            <div class="video-grid">
                <% for (Video v : channelVideos) { %>
                    <a href="WatchServlet?id=<%= v.getVideoId() %>" class="video-card">
                        <% if (v.getThumbnailPath() != null && !v.getThumbnailPath().isEmpty()) { %>
                            <img class="video-thumbnail" src="${pageContext.request.contextPath}/<%= v.getThumbnailPath() %>" alt="<%= v.getTitle() %>">
                        <% } else { %>
                            <div class="thumbnail-placeholder">▶</div>
                        <% } %>
                        <div class="video-info">
                            <div class="video-title-text"><%= v.getTitle() %></div>
                            <div class="video-views"><%= v.getViews() %> x ditonton</div>
                        </div>
                    </a>
                <% } %>
            </div>
        <% } else { %>
            <div class="no-videos">Belum ada video yang diunggah.</div>
        <% } %>
    </div>

    <% } else { %>
        <div style="text-align:center; margin-top:60px; color:#888;">Channel tidak ditemukan.</div>
    <% } %>
</body>
</html>