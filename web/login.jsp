<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - VTube</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .login-container { width: 350px; margin: 100px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .login-container h2 { margin-bottom: 20px; text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn-login { width: 100%; padding: 10px; background-color: #ff0000; border: none; color: white; font-size: 16px; border-radius: 4px; cursor: pointer; }
        .btn-login:hover { background-color: #cc0000; }
        .error-msg { color: red; text-align: center; margin-bottom: 15px; font-size: 14px; }
        .success-msg { color: green; text-align: center; margin-bottom: 15px; font-size: 14px; }
        .register-link { text-align: center; margin-top: 15px; font-size: 14px; }
        .register-link a { color: #0066cc; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login VTube</h2>
        <% 
            String status = request.getParameter("status");
            if ("invalid".equals(status)) { 
        %>
            <div class="error-msg">Username/Email atau Password salah!</div>
        <% 
            } else if ("success".equals(status)) { 
        %>
            <div class="success-msg">Registrasi berhasil! Silakan login.</div>
        <% 
            } 
        %>
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label>Username atau Email</label>
                <input type="text" name="usernameOrEmail" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn-login">Login</button>
        </form>
        <div class="register-link">
            Belum punya akun? <a href="register.jsp">Daftar sekarang</a>
        </div>
    </div>
</body>
</html>