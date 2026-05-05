<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Đạo Hữu - Vân Lộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        /* CSS riêng cho trang Profile để căn chỉnh */
        .profile-wrapper {
            padding: 50px 0;
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .profile-avatar-container {
            position: relative;
            width: 120px;
            height: 120px;
            margin: -60px auto 20px; /* Đẩy avatar lên trên card một chút */
        }
        
        .profile-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 4px solid var(--card-bg); /* Viền tiệp màu nền */
            box-shadow: 0 0 20px rgba(243, 156, 18, 0.5); /* Phát sáng vàng */
            object-fit: cover;
        }
        
        /* Chỉnh lại auth-card để dùng trong layout này */
        .profile-card {
            background: rgba(30, 30, 30, 0.6);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 15px;
            padding: 20px 40px 40px;
            color: #fff;
            width: 100%;
            max-width: 600px;
            margin-top: 30px;
        }
        
        .readonly-field {
            background: rgba(0,0,0,0.3) !important;
            border-color: #444 !important;
            color: #aaa !important;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

    <jsp:include page="../common/header.jsp"></jsp:include>

    <div class="container profile-wrapper">
        <div class="profile-card">
            
            <div class="profile-avatar-container">
                <img src="https://ui-avatars.com/api/?name=${sessionScope.user.fullName}&background=f39c12&color=fff&size=128" 
                     class="profile-avatar" alt="Avatar">
            </div>
            
            <h3 class="text-center mb-1" style="font-family: 'Montserrat', sans-serif; color: var(--accent-color);">
                ${sessionScope.user.fullName}
            </h3>
            <p class="text-center text-muted mb-4">
                <i class="fas fa-crown text-warning"></i> 
                ${sessionScope.user.admin ? 'Quản Trị Viên (Admin)' : 'Đạo Hữu (Thành Viên)'}
            </p>

            <c:if test="${not empty message}">
                <div class="alert alert-success text-center py-2"><i class="fas fa-check-circle"></i> ${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center py-2"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
            </c:if>

            <form action="/J4Video/profile" method="post">
                
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label class="form-label-custom">Email Đăng Nhập</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-secondary"><i class="fas fa-envelope"></i></span>
                            <input type="text" name="email" class="input-custom readonly-field" value="${sessionScope.user.email}" readonly>
                        </div>
                        <small class="text-muted fst-italic ms-1">* Email không thể thay đổi để đảm bảo an toàn.</small>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label-custom">Đạo Hiệu (Họ Tên)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-white"><i class="fas fa-user-edit"></i></span>
                            <input type="text" name="fullName" class="input-custom" value="${sessionScope.user.fullName}" required>
                        </div>
                    </div>
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button class="btn btn-vanlo shadow-sm">
                        <i class="fas fa-save me-2"></i> Lưu Hồ Sơ
                    </button>
                    
                    <a href="/J4Video/changepassword" class="btn btn-outline-light" style="border-color: #555;">
                        <i class="fas fa-key me-2"></i> Đổi Mật Khẩu
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>