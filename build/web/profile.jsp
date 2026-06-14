<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profil Saya - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #fafafa; }
        .navbar { background-color: #fff; padding: 10px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; }
        .navbar .logo { font-size: 24px; font-weight: bold; color: #ff0000; text-decoration: none; }
        .nav-links a { margin-left: 15px; text-decoration: none; color: #333; }
        .profile-container { width: 450px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .profile-container h2 { margin-bottom: 20px; text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; }
        .form-group input[type="text"], .form-group input[type="email"], .form-group textarea {
            width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box;
        }
        .form-group textarea { height: 100px; resize: none; }
        .btn-save { width: 100%; padding: 10px; background-color: #0066cc; border: none; color: white; font-size: 16px; border-radius: 4px; cursor: pointer; }
        .btn-save:hover { background-color: #0052a3; }
        .success-msg { color: green; text-align: center; margin-bottom: 15px; font-size: 14px; }
        .error-msg { color: red; text-align: center; margin-bottom: 15px; font-size: 14px; }
        .back-link { display: block; text-align: center; margin-top: 15px; color: #333; text-decoration: none; }
        .profile-meta { text-align: center; color: #888; font-size: 13px; margin-bottom: 20px; }
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
    <div class="navbar">
        <a href="HomeServlet" class="logo">VTube</a>
        <div class="nav-links">
            <a href="upload.jsp">Upload</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="profile-container">
        <h2>Profil Saya</h2>
        <div class="profile-meta">Bergabung sejak: <%= new SimpleDateFormat("dd MMM yyyy").format(currentUser.getCreatedAt()) %></div>

        <% if ("profileUpdated".equals(request.getParameter("status"))) { %>
            <div class="success-msg">Profil berhasil diperbarui!</div>
        <% } else if ("profileUpdateFailed".equals(request.getParameter("status"))) { %>
            <div class="error-msg">Gagal memperbarui profil. Username atau email mungkin sudah digunakan.</div>
        <% } %>

        <form action="ProfileServlet" method="post" enctype="multipart/form-data">
            <div style="display:flex; flex-direction:column; align-items:center; margin-bottom:20px;">
    <div id="avatarPreview" style="width:80px; height:80px; border-radius:50%; overflow:hidden; background-color:#0066cc; display:flex; align-items:center; justify-content:center; font-size:32px; font-weight:bold; color:#fff; margin-bottom:10px;">
            <% if (currentUser.getProfilePicture() != null && !currentUser.getProfilePicture().isEmpty()) { %>
                <img id="avatarImg" src="${pageContext.request.contextPath}/<%= currentUser.getProfilePicture() %>" style="width:100%;height:100%;object-fit:cover;">
            <% } else { %>
                <span id="avatarInitial"><%= String.valueOf(currentUser.getUsername().charAt(0)).toUpperCase() %></span>
            <% } %>
        </div>
        <label style="cursor:pointer; padding:6px 14px; background:#f1f1f1; border:1px solid #ddd; border-radius:4px; font-size:14px;" for="profilePicture">Ganti Foto Profil</label>
        <input type="file" id="profilePicture" name="profilePicture" accept="image/*" style="display:none;" onchange="previewImage(this)">
    </div>

    <script>
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var preview = document.getElementById('avatarPreview');
                var initial = document.getElementById('avatarInitial');
                if (initial) initial.remove();
                var img = document.getElementById('avatarImg');
                if (!img) { img = document.createElement('img'); img.id='avatarImg'; img.style='width:100%;height:100%;object-fit:cover;'; preview.appendChild(img); }
                img.src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    </script>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" value="<%= currentUser.getUsername() %>" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="<%= currentUser.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label>Bio</label>
                <textarea name="bio" placeholder="Ceritakan sedikit tentang dirimu..."><%= currentUser.getBio() != null ? currentUser.getBio() : "" %></textarea>
            </div>
            <button type="submit" class="btn-save">Simpan Perubahan</button>
        </form>
        <a href="HomeServlet" class="back-link">Kembali ke Beranda</a>
    </div>
</body>
</html>