<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .register-container { width: 350px; margin: 100px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .register-container h2 { margin-bottom: 20px; text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn-register { width: 100%; padding: 10px; background-color: #333; border: none; color: white; font-size: 16px; border-radius: 4px; cursor: pointer; }
        .btn-register:hover { background-color: #555; }
        .error-msg { color: red; text-align: center; margin-bottom: 15px; font-size: 14px; }
        .login-link { text-align: center; margin-top: 15px; font-size: 14px; }
        .login-link a { color: #ff0000; text-decoration: none; }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Daftar Akun VTube</h2>
        <% 
            String status = request.getParameter("status");
            if ("failed".equals(status)) { 
        %>
            <div class="error-msg">Registrasi gagal! Username atau Email mungkin sudah digunakan.</div>
        <% 
            } 
        %>
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn-register">Daftar</button>
        </form>
        <div class="login-link">
            Sudah punya akun? <a href="login.jsp">Login di sini</a>
        </div>
    </div>
</body>
</html>