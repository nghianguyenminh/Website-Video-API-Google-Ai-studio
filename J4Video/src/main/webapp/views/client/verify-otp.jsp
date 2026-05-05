<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP - Vân Lộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    
    <div class="auth-container">
        <div class="auth-overlay"></div>

        <div class="auth-card">
            <div class="auth-header">
                <div class="auth-icon" style="background: linear-gradient(135deg, #2ecc71, #27ae60);">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3 class="auth-title">Xác Thực & Đổi Mới</h3>
                <p class="text-white-50">
                    Mã OTP đã được gửi đến: <br>
                    <span class="text-warning fw-bold">${sessionScope.resetEmail}</span>
                </p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger p-2 text-center mb-3 border-0 bg-danger text-white" style="--bs-bg-opacity: .2;">
                    <small><i class="fas fa-exclamation-triangle"></i> ${error}</small>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgotpassword" method="post">
                <input type="hidden" name="action" value="verifyOTP">
                
                <div class="form-group-custom mb-4">
                    <label class="form-label-custom text-center w-100 text-warning">NHẬP MÃ OTP (6 SỐ)</label>
                    <input type="text" name="otp" class="input-custom text-center fw-bold text-warning" 
                           style="font-size: 1.5rem; letter-spacing: 5px; border-color: var(--accent-color);"
                           required maxlength="6" placeholder="------" autocomplete="off">
                </div>
                
                <hr class="border-secondary my-4">

                <div class="form-group-custom">
                    <label class="form-label-custom">Mật Khẩu Mới</label>
                    <input type="password" name="newPassword" class="input-custom" placeholder="Nhập mật khẩu mới..." required>
                </div>
                
                <div class="form-group-custom">
                    <label class="form-label-custom">Xác Nhận Mật Khẩu</label>
                    <input type="password" name="confirmPassword" class="input-custom" placeholder="Nhập lại lần nữa..." required>
                </div>

                <button class="btn-auth-submit bg-success mt-2">
                    Xác Nhận Đổi Mật Khẩu
                </button>
            </form>
        </div>
    </div>
</body>
</html>