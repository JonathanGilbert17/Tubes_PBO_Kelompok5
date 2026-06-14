<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Video, model.Comment, java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tonton Video - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #fafafa; }
        .navbar { background-color: #fff; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; }
        .navbar .logo { font-size: 24px; font-weight: bold; color: #ff0000; text-decoration: none; }
        .container { max-width: 900px; margin: 20px auto; padding: 0 20px; }
        video { width: 100%; background-color: #000; border-radius: 8px; }
        .video-details { background: #fff; padding: 20px; margin-top: 15px; border-radius: 8px; border: 1px solid #eee; }
        .video-title { font-size: 20px; font-weight: bold; margin-bottom: 10px; }
        .video-meta { color: #606060; font-size: 14px; margin-bottom: 15px; }
        .video-description { font-size: 15px; line-height: 1.5; color: #333; border-top: 1px solid #eee; padding-top: 15px; }
        .comment-section { background: #fff; padding: 20px; margin-top: 20px; border-radius: 8px; border: 1px solid #eee; }
        .comment-section h3 { margin-top: 0; }
        .comment-form textarea { width: 100%; height: 70px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; resize: none; box-sizing: border-box; }
        .comment-form button { margin-top: 10px; padding: 8px 15px; background-color: #0066cc; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .comment-list { margin-top: 20px; }
        .comment-item { border-bottom: 1px solid #eee; padding: 12px 0; }
        .comment-author { 
            font-weight: bold; 
            font-size: 14px; 
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .comment-text { font-size: 14px; color: #333; }
        .video-actions { margin-top: 15px; }
        .like-btn { padding: 8px 18px; border: 1px solid #ddd; border-radius: 20px; background-color: #f1f1f1; cursor: pointer; font-size: 14px; font-weight: bold; color: #333; }
        .like-btn.liked { background-color: #0066cc; color: #fff; border-color: #0066cc; }
        .uploader-info { display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit; }
        .uploader-info:hover .uploader-name { text-decoration: underline; }
        .uploader-avatar {
            width: 36px; height: 36px; border-radius: 50%;
            overflow: hidden; flex-shrink: 0;
        }
        .uploader-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .uploader-avatar.initials {
            background-color: #0066cc; display: flex;
            align-items: center; justify-content: center;
            font-weight: bold; font-size: 15px; color: #fff;
        }
        .uploader-name { font-weight: bold; color: #333; }
        .subscribe-btn {
            padding: 8px 18px; border: none; border-radius: 20px;
            background-color: #cc0000; color: #fff;
            cursor: pointer; font-size: 14px; font-weight: bold;
        }
        .subscribe-btn.subscribed {
            background-color: #aaa; color: #fff;
        }
        .video-meta {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }
        .uploader-info {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            color: inherit;
        }
        .subscriber-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-left: 4px;
        }
    </style>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("currentUser");
        Video video = (Video) request.getAttribute("video");
        List<Comment> comments = (List<Comment>) request.getAttribute("comments");
    %>
    <div class="navbar">
        <a href="HomeServlet" class="logo">VTube</a>
        <a href="SavedVideosServlet">Video Tersimpan</a>
        <div>
            <% if (currentUser != null) { %>
                <a href="HomeServlet" style="text-decoration:none; color:#333;">Kembali ke Beranda</a>
            <% } %>
        </div>
    </div>

    <div class="container">
        <% if (video != null) { %>
        <video width="100%" height="auto" controls autoplay>
            <source src="${pageContext.request.contextPath}/<%= video.getVideoPath() %>" type="video/mp4">
            Browser Anda tidak mendukung pemutar video ini.
        </video>

            <div class="video-details">
                <div class="video-title"><%= video.getTitle() %></div>
                <div class="video-meta">
                        <a href="ChannelServlet?userId=<%= video.getUploaderUserId() %>" class="uploader-info">
                            <% if (video.getUploaderProfilePicture() != null && !video.getUploaderProfilePicture().isEmpty()) { %>
                                <div class="uploader-avatar">
                                    <img src="${pageContext.request.contextPath}/<%= video.getUploaderProfilePicture() %>" alt="Foto profil">
                                </div>
                            <% } else { %>
                                <div class="uploader-avatar initials">
                                    <%= String.valueOf(video.getUploaderUsername().charAt(0)).toUpperCase() %>
                                </div>
                            <% } %>
                            <span class="uploader-name"><%= video.getUploaderUsername() %></span>
                        </a>
                        <%
                            Boolean isSubscribed = (Boolean) request.getAttribute("isSubscribed");
                            Integer subscriberCount = (Integer) request.getAttribute("subscriberCount");
                            Integer uploaderUserId = (Integer) request.getAttribute("uploaderUserId");
                            boolean isSelf = (currentUser != null && currentUser.getUserId() == video.getUploaderUserId());
                        %>
                        <% if (currentUser != null && !isSelf) { %>
                            <form action="SubscribeServlet" method="post" style="display:inline;">
                                <input type="hidden" name="creatorId" value="<%= video.getUploaderUserId() %>">
                                <input type="hidden" name="redirectTo" value="WatchServlet?id=<%= video.getVideoId() %>">
                                <button type="submit" class="subscribe-btn <%= Boolean.TRUE.equals(isSubscribed) ? "subscribed" : "" %>">
                                    <%= Boolean.TRUE.equals(isSubscribed) ? "Berlangganan ✓" : "Berlangganan" %>
                                </button>
                            </form>
                        <% } %>
                        <span style="font-size:13px; color:#888; margin-left:6px;">
                            <%= subscriberCount != null ? subscriberCount : 0 %> subscriber
                        </span>
                    </div>
                    <%= video.getViews() %> x ditonton • Uploaded: <%= new SimpleDateFormat("dd MMM yyyy").format(video.getUploadDate()) %>
                </div>
                <div class="video-description"><%= video.getDescription() != null ? video.getDescription() : "Tidak ada deskripsi." %></div>
                <div class="video-actions">
                    <% if (currentUser != null) { %>
                        <form action="LikeServlet" method="post" style="display:inline;">
                            <input type="hidden" name="videoId" value="<%= video.getVideoId() %>">
                            <button type="submit" class="like-btn<%= video.isLikedByCurrentUser() ? " liked" : "" %>">
                                <%= video.isLikedByCurrentUser() ? "Disukai" : "Suka" %> (<%= video.getLikeCount() %>)
                            </button>
                        </form>
                    <% } else { %>
                        <span class="like-btn"><%= video.getLikeCount() %> Suka</span>
                    <% } %>
                    
                   <%
                        Boolean isSaved = (Boolean) request.getAttribute("isSaved");
                    %>
                    <% if (currentUser != null) { %>
                        <form action="SaveServlet" method="post" style="display:inline;">
                            <input type="hidden" name="videoId" value="<%= video.getVideoId() %>">
                            <input type="hidden" name="redirectTo" value="WatchServlet?id=<%= video.getVideoId() %>">
                            <button type="submit" class="like-btn <%= Boolean.TRUE.equals(isSaved) ? "liked" : "" %>">
                                <%= Boolean.TRUE.equals(isSaved) ? "✓ Disimpan" : "Simpan" %>
                            </button>
                        </form>
                    <% } %>
                </div>
            </div>

            <div class="comment-section">
                <h3>Komentar</h3>
                <% if (currentUser != null) { %>
                    <form action="CommentServlet" method="post" class="comment-form">
                        <input type="hidden" name="videoId" value="<%= video.getVideoId() %>">
                        <textarea name="comment" placeholder="Tulis komentar publik..." required></textarea>
                        <button type="submit">Kirim Komentar</button>
                    </form>
                <% } else { %>
                    <p><a href="login.jsp">Login</a> untuk memberikan komentar.</p>
                <% } %>

                <div class="comment-list">
                    <% 
                        if (comments != null && !comments.isEmpty()) { 
                            for (Comment c : comments) {
                    %>
                        <div class="comment-item">
                            <div class="comment-author">
                                <%= c.getUsername() %> 
                                <span style="font-weight:normal; font-size:12px; color:#606060;">
                                    <%= new SimpleDateFormat("dd MMM yyyy").format(c.getCreatedAt()) %>
                                </span>
                            </div>
                            <div class="comment-text"><%= c.getComment() %></div>
                        </div>
                    <% 
                            }
                        } else { 
                    %>
                        <p>Belum ada komentar.</p>
                    <% } %>
                </div>
            </div>
        <% } else { %>
            <p>Video tidak ditemukan.</p>
        <% } %>
    </div>
</body>
</html>