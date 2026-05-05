<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đổi Mật Khẩu - Vân Lộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        /* Tận dụng background style của Profile */
        .profile-wrapper {
            padding: 50px 0;
            min-height: 85vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>

    <jsp:include page="../common/header.jsp"></jsp:include>

    <div class="container profile-wrapper">
        <div class="auth-card shadow-lg" style="max-width: 500px; border: 1px solid rgba(255,255,255,0.15);">
            
            <div class="text-center mb-4">
                <h3 class="fw-bold text-warning text-uppercase" style="font-family: 'Montserrat', sans-serif;">
                    <i class="fas fa-key me-2"></i> Bảo Mật
                </h3>
                <p class="text-muted small">Thay đổi mật khẩu thường xuyên để bảo vệ tài khoản</p>
            </div>

            <c:if test="${not empty message}">
                 <div class="alert alert-success border-0 bg-success text-white" style="--bs-bg-opacity: .2;">
                    <i class="fas fa-check-circle"></i> ${message}
                 </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 bg-danger text-white" style="--bs-bg-opacity: .2;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/changepassword" method="post">
                
                <div class="form-group-custom">
                    <label class="form-label-custom">Mật khẩu hiện tại</label>
                    <input type="password" name="currentPass" class="input-custom" placeholder="Nhập mật khẩu cũ..." required>
                </div>
                
                <div class="form-group-custom">
                    <label class="form-label-custom">Mật khẩu mới</label>
                    <input type="password" name="newPass" class="input-custom" placeholder="Nhập mật khẩu mới..." required>
                </div>
                
                <div class="form-group-custom">
                    <label class="form-label-custom">Xác nhận mật khẩu mới</label>
                    <input type="password" name="confirmPass" class="input-custom" placeholder="Nhập lại mật khẩu mới..." required>
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button class="btn-auth-submit">
                        <i class="fas fa-save me-2"></i> Cập Nhật Mật Khẩu
                    </button>
                    
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-light" style="border-radius: 10px; padding: 10px;">
                        <i class="fas fa-arrow-left me-2"></i> Quay Lại Hồ Sơ
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>