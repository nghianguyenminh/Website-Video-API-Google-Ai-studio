<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - Vân Lộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    
    <div class="auth-container">
        <div class="auth-overlay"></div>

        <div class="auth-card">
            <a href="${pageContext.request.contextPath}/login" class="btn-close-auth" title="Quay lại đăng nhập">
                <i class="fas fa-arrow-left"></i>
            </a>

            <div class="auth-header">
                <div class="auth-icon" style="background: linear-gradient(135deg, #e74c3c, #c0392b);">
                    <i class="fas fa-unlock-alt"></i>
                </div>
                <h3 class="auth-title">Khôi Phục Mật Khẩu</h3>
                <p class="text-white-50">Nhập email đạo hữu đã dùng để tu luyện</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger p-2 text-center mb-3 border-0 bg-danger text-white" style="--bs-bg-opacity: .2;">
                    <small><i class="fas fa-exclamation-triangle"></i> ${error}</small>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgotpassword" method="post">
                <input type="hidden" name="action" value="sendOTP">
                
                <div class="form-group-custom">
                    <label class="form-label-custom">Email Đăng Ký</label>
                    <div class="position-relative">
                        <input type="email" name="email" class="input-custom" placeholder="nhap_email@example.com" required>
                        <i class="fas fa-envelope position-absolute text-secondary" style="right: 15px; top: 12px;"></i>
                    </div>
                </div>

                <button class="btn-auth-submit mt-2">
                    Gửi Mã OTP <i class="fas fa-paper-plane ms-2"></i>
                </button>
            </form>

            <div class="auth-footer mt-4">
                <a href="${pageContext.request.contextPath}/login" class="text-white-50 text-decoration-none">
                    <small>Đã nhớ ra mật khẩu? Đăng nhập lại</small>
                </a>
            </div>
        </div>
    </div>
</body>
</html>