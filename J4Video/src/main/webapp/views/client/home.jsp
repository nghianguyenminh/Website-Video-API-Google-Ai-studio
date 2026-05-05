<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vân Lộ - Thế Giới Tiên Hiệp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    
    <jsp:include page="../common/header.jsp"></jsp:include>

    <div class="container mt-5">
        <div class="alert alert-dark text-center" style="background: #222; border: 1px solid #444; color: #f39c12;">
            <i class="fas fa-bullhorn"></i> Chào mừng đến với Vân Lộ! - Nơi bạn đắm chìm vào thế giới tiên hiệp
        </div>
        
        <div class="trending-section mt-5">
            <div class="trending-header">
                <h3 class="trending-title"><i class="fas fa-fire-alt"></i> Đang Thịnh Hành</h3>
            </div>

            <div class="trending-scroll-container" id="trendingSlider">
                <c:forEach items="${list}" var="video" varStatus="status" end="9">
                    <div class="trending-card">
                        <div class="poster-container" style="border-radius: 12px;">
                            <img src="${video.poster}" class="movie-poster" alt="${video.title}" draggable="false"> 
                            <span class="episode-badge" style="background: #f39c12;">Top ${status.count}</span>
                            <a href="/J4Video/favorites/add?id=${video.id}" class="position-absolute top-0 end-0 p-2 text-white" style="z-index: 10;">
                                <i class="fas fa-heart"></i>
                            </a>
                        </div>
                        
                        <div class="position-relative">
                            <span class="rank-number rank-${status.count}">${status.count}</span>
                            
                            <div class="trending-info ms-2">
                                <h6 class="movie-title">${video.title}</h6>
                                <small class="text-white-50">${video.description.length() > 20 ? video.description.substring(0, 20) : video.description}...</small>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <h3 class="mb-4" style="border-left: 5px solid #f39c12; padding-left: 10px; color: #fff;">
            Mới Cập Nhật
        </h3>

        <div class="row">
            <c:forEach items="${list}" var="video">
                <div class="col-6 col-md-4 col-lg-2"> 
                    <div class="movie-card" onclick="window.location.href='/J4Video/video?id=${video.id}'"> <!-- Lấy youtube ID để chiếu vd -->
                        <div class="poster-container">
                            <span class="episode-badge">Tập Mới</span>
                            <img src="${video.poster}" class="movie-poster" alt="${video.title}">
                            
                            <a href="/J4Video/favorites/add?id=${video.id}" class="position-absolute top-0 end-0 p-2 text-white" 
                               style="z-index: 10; text-shadow: 0 0 5px black;" title="Thêm vào yêu thích">
                                <i class="fas fa-heart fa-lg text-danger"></i>
                            </a>

                            <div class="play-overlay">
                                <i class="far fa-play-circle play-btn"></i>
                            </div>
                        </div>

                        <div class="movie-info">
                            <h5 class="movie-title">${video.title}</h5>
                            <small class="text-muted"><i class="fas fa-eye"></i> ${video.view_count} lượt xem</small>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        const slider = document.getElementById('trendingSlider');
        let isDown = false;
        let startX;
        let scrollLeft;

        slider.addEventListener('mousedown', (e) => {
            isDown = true;
            slider.classList.add('active'); 
            startX = e.pageX - slider.offsetLeft;
            scrollLeft = slider.scrollLeft;
        });

        slider.addEventListener('mouseleave', () => {
            isDown = false;
            slider.classList.remove('active');
        });

        slider.addEventListener('mouseup', () => {
            isDown = false;
            slider.classList.remove('active');
        });

        slider.addEventListener('mousemove', (e) => {
            if (!isDown) return; 
            e.preventDefault(); 
            const x = e.pageX - slider.offsetLeft;
            const walk = (x - startX) * 2; 
            slider.scrollLeft = scrollLeft - walk;
        });
    </script>
</body>
</html> --%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vân Lộ - Thế Giới Tiên Hiệp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    
    <jsp:include page="../common/header.jsp"></jsp:include>

    <div class="container mt-5">
        <div class="alert alert-dark text-center" style="background: #222; border: 1px solid #444; color: #f39c12;">
            <i class="fas fa-bullhorn"></i> Chào mừng đến với Vân Lộ! - Nơi bạn đắm chìm vào thế giới tiên hiệp
        </div>
        
        <div class="trending-section mt-5">
            <div class="trending-header">
                <h3 class="trending-title"><i class="fas fa-fire-alt"></i> Đang Thịnh Hành</h3>
            </div>

            <div class="trending-scroll-container" id="trendingSlider">
                <c:forEach items="${trendingList}" var="video" varStatus="status">
                    <div class="trending-card">
                        <div class="poster-container" style="border-radius: 12px;">
                            <img src="${video.poster}" class="movie-poster" alt="${video.title}" draggable="false"> 
                            <span class="episode-badge" style="background: #f39c12;">Top ${status.count}</span>
                            
                            <a href="/J4Video/favorites/add?id=${video.id}" class="position-absolute top-0 end-0 p-2 text-white" style="z-index: 10;">
                                <i class="fas fa-heart"></i>
                            </a>
                            
                            <div class="play-overlay" onclick="window.location.href='/J4Video/video?id=${video.id}'">
                                <i class="far fa-play-circle play-btn"></i>
                            </div>
                        </div>
                        
                        <div class="position-relative">
                            <span class="rank-number rank-${status.count}">${status.count}</span>
                            
                            <div class="trending-info ms-2">
                                <h6 class="movie-title">${video.title}</h6>
                                 <small class="text-white-50">${video.description.length() > 20 ? video.description.substring(0, 20) : video.description}...</small>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <h3 class="mb-4" style="border-left: 5px solid #f39c12; padding-left: 10px; color: #fff;">
            <c:choose>
                <c:when test="${not empty keyword}">Kết quả tìm kiếm: "${keyword}"</c:when>
                <c:otherwise>Mới Cập Nhật</c:otherwise>
            </c:choose>
        </h3>

        <div class="row">
            <c:forEach items="${list}" var="video">
                <div class="col-6 col-md-4 col-lg-2"> 
                    <div class="movie-card" onclick="window.location.href='/J4Video/video?id=${video.id}'">
                        <div class="poster-container">
                            <span class="episode-badge">Tập Mới</span>
                            <img src="${video.poster}" class="movie-poster" alt="${video.title}">
                            
                            <a href="/J4Video/favorites/add?id=${video.id}" class="position-absolute top-0 end-0 p-2 text-white" 
                               style="z-index: 10; text-shadow: 0 0 5px black;" title="Thêm vào yêu thích"
                               onclick="event.stopPropagation();">
                                <i class="fas fa-heart fa-lg text-danger"></i>
                            </a>

                            <div class="play-overlay">
                                <i class="far fa-play-circle play-btn"></i>
                            </div>
                        </div>

                        <div class="movie-info">
                            <h5 class="movie-title">${video.title}</h5>
                            <small class="text-muted"><i class="fas fa-eye"></i> ${video.view_count} lượt xem</small>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty list}">
                <div class="col-12 text-center text-white-50">
                    <p>Không tìm thấy bộ công pháp nào.</p>
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Script kéo thả Slider (Giữ nguyên như cũ)
        const slider = document.getElementById('trendingSlider');
        let isDown = false;
        let startX;
        let scrollLeft;

        if(slider) { // Kiểm tra null để tránh lỗi console
            slider.addEventListener('mousedown', (e) => {
                isDown = true;
                slider.classList.add('active'); 
                startX = e.pageX - slider.offsetLeft;
                scrollLeft = slider.scrollLeft;
            });
            slider.addEventListener('mouseleave', () => {
                isDown = false;
                slider.classList.remove('active');
            });
            slider.addEventListener('mouseup', () => {
                isDown = false;
                slider.classList.remove('active');
            });
            slider.addEventListener('mousemove', (e) => {
                if (!isDown) return; 
                e.preventDefault(); 
                const x = e.pageX - slider.offsetLeft;
                const walk = (x - startX) * 2; 
                slider.scrollLeft = scrollLeft - walk;
            });
        }
    </script>
</body>
</html>
