<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký - Vân Lộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    
    <div class="auth-container">
        <div class="auth-overlay"></div>

        <div class="auth-card">
            <a href="/J4Video/home" class="btn-close-auth"><i class="fas fa-times"></i></a>

            <div class="auth-header">
                <div class="auth-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h3 class="auth-title">Đăng Ký</h3>
                <p class="text-white-50">Gia nhập giới tu chân ngay hôm nay</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger p-2 text-center mb-3">
                    <small><i class="fas fa-exclamation-circle"></i> ${error}</small>
                </div>
            </c:if>

            <form action="/J4Video/register" method="post">
                <div class="form-group-custom">
                    <label for="fullName" class="form-label-custom">Đạo Hiệu (Họ Tên)</label>
                    <input type="text" id="fullName" name="fullName" class="input-custom" placeholder="Nhập tên hiển thị..." required>
                </div>

                <div class="form-group-custom">
                    <label for="email" class="form-label-custom">Email Liên Lạc</label>
                    <input type="email" id="email" name="email" class="input-custom" placeholder="nhap_email@example.com" required>
                </div>

                <div class="form-group-custom">
                    <label for="password" class="form-label-custom">Mật Khẩu</label>
                    <input type="password" id="password" name="password" class="input-custom" placeholder="Tạo mật khẩu..." required>
                    <i class="fas fa-eye-slash password-toggle" onclick="togglePassword('password', this)"></i>
                </div>

                <div class="form-group-custom">
                    <label for="repeatPassword" class="form-label-custom">Xác Nhận Mật Khẩu</label>
                    <input type="password" id="repeatPassword" name="repeatPassword" class="input-custom" placeholder="Nhập lại mật khẩu..." required>
                </div>

                <button class="btn-auth-submit">Khởi Tạo Tài Khoản</button>
            </form>

            <div class="auth-footer">
                Đã có tài khoản? <a href="/J4Video/login">Đăng nhập</a>
            </div>
        </div>
    </div>

    <script>
        function togglePassword(inputId, icon) {
            const input = document.getElementById(inputId);
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            }
        }
    </script>
</body>
</html>