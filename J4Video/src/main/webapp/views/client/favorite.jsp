<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tàng Kinh Các - Yêu Thích</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="../common/header.jsp"></jsp:include>

    <div class="container mt-5">
        <h3 class="mb-4 text-warning"><i class="fas fa-heart"></i> Tàng Kinh Các (Yêu Thích)</h3>
        
        <c:if test="${empty list}">
             <div class="alert alert-secondary text-center">
                Đạo hữu chưa lưu bộ công pháp nào vào Tàng Kinh Các. <a href="/J4Video/home" class="fw-bold">Đi tìm ngay!</a>
             </div>
        </c:if>

        <div class="row">
            <c:forEach items="${list}" var="favorite">
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="movie-card">
                        <div class="poster-container">
                            <img src="${favorite.video.poster}" class="movie-poster" alt="${favorite.video.title}">
                            
                            <a href="/J4Video/favorites/remove?id=${favorite.id}" 
                               class="position-absolute top-0 end-0 p-2 btn btn-sm btn-danger m-2" 
                               style="z-index: 10; border-radius: 50%; width: 30px; height: 30px; padding: 0; display: flex; align-items: center; justify-content: center;" 
                               title="Bỏ yêu thích" onclick="return confirm('Đạo hữu muốn quên bộ công pháp này sao?')">
                                <i class="fas fa-times"></i>
                            </a>

                            <div class="play-overlay">
                                <i class="far fa-play-circle play-btn"></i>
                            </div>
                        </div>
                        <div class="movie-info">
                            <h5 class="movie-title">${favorite.video.title}</h5>
                            <small class="text-muted">Ngày lưu: <fmt:formatDate value="${favorite.likeDate}" pattern="dd/MM/yyyy"/></small>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>