<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch Chiếu Phim - Vân Lộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        /* CSS riêng cho trang Lịch */
        .schedule-nav {
            background: #1a1a1a;
            border-radius: 50px;
            padding: 5px;
            border: 1px solid #444;
            display: inline-flex;
            justify-content: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .schedule-nav .nav-link {
            color: #aaa;
            border-radius: 40px;
            padding: 10px 25px;
            font-weight: bold;
            transition: all 0.3s;
            border: none;
        }
        .schedule-nav .nav-link:hover {
            color: #fff;
            background: rgba(255,255,255,0.1);
        }
        .schedule-nav .nav-link.active {
		    background: var(--accent-color); /* Màu nền cam */
		    
		    /* --- SỬA Ở ĐÂY --- */
		    color: #ffffff !important; /* Đổi thành màu Trắng và dùng !important để ép màu */
		    text-shadow: 0 1px 3px rgba(0,0,0,0.5); /* Thêm bóng đen nhẹ cho chữ để dễ đọc hơn */
		    font-weight: 800; /* Tăng độ đậm của chữ */
		    /* ---------------- */
		    
		    box-shadow: 0 0 15px rgba(243, 156, 18, 0.5); /* Hiệu ứng phát sáng */
		    transform: scale(1.05); /* Phóng to nhẹ nút đang chọn cho đẹp */
		}
        .empty-day {
            text-align: center;
            padding: 50px;
            color: #555;
            font-style: italic;
        }
    </style>
</head>
<body>
    
    <jsp:include page="../common/header.jsp"></jsp:include>

    <div class="container mt-5 text-center">
        <h2 class="fw-bold mb-4" style="color: var(--accent-color); font-family: 'Montserrat', sans-serif;">
            <i class="far fa-calendar-alt"></i> LỊCH CẬP NHẬT PHIM
        </h2>

        <ul class="nav nav-pills schedule-nav mb-3" id="pills-tab" role="tablist">
            <li class="nav-item"><button class="nav-link active" id="t2-tab" data-bs-toggle="pill" data-bs-target="#day-T2">Thứ 2</button></li>
            <li class="nav-item"><button class="nav-link" id="t3-tab" data-bs-toggle="pill" data-bs-target="#day-T3">Thứ 3</button></li>
            <li class="nav-item"><button class="nav-link" id="t4-tab" data-bs-toggle="pill" data-bs-target="#day-T4">Thứ 4</button></li>
            <li class="nav-item"><button class="nav-link" id="t5-tab" data-bs-toggle="pill" data-bs-target="#day-T5">Thứ 5</button></li>
            <li class="nav-item"><button class="nav-link" id="t6-tab" data-bs-toggle="pill" data-bs-target="#day-T6">Thứ 6</button></li>
            <li class="nav-item"><button class="nav-link" id="t7-tab" data-bs-toggle="pill" data-bs-target="#day-T7">Thứ 7</button></li>
            <li class="nav-item"><button class="nav-link" id="cn-tab" data-bs-toggle="pill" data-bs-target="#day-CN">Chủ Nhật</button></li>
        </ul>

        <div class="tab-content text-start" id="pills-tabContent">
            
           <c:set var="days" value="${fn:split('T2,T3,T4,T5,T6,T7,CN', ',')}"/>
            
            <c:forEach items="${days}" var="day" varStatus="loop">
                <div class="tab-pane fade ${loop.first ? 'show active' : ''}" id="day-${day}" role="tabpanel">
                    <div class="row">
                        <c:set var="hasMovie" value="false"/>
                        
                        <c:forEach items="${list}" var="video">
                            <c:if test="${video.schedule == day}">
                                <c:set var="hasMovie" value="true"/>
                                <div class="col-6 col-md-4 col-lg-2 mb-4">
                                    <div class="movie-card" onclick="window.location.href='/J4Video/video?id=${video.id}'">
                                        <div class="poster-container">
                                            <span class="episode-badge">Hôm nay</span>
                                            <img src="${video.poster}" class="movie-poster" alt="${video.title}">
                                            <div class="play-overlay"><i class="far fa-play-circle play-btn"></i></div>
                                        </div>
                                        <div class="movie-info text-center mt-2">
                                            <h6 class="movie-title text-truncate">${video.title}</h6>
                                            <small class="text-muted"><i class="fas fa-eye"></i> ${video.view_count}</small>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                        <c:if test="${!hasMovie}">
                            <div class="col-12 empty-day">
                                <h3><i class="fas fa-coffee"></i></h3>
                                <p>Hôm nay các đạo hữu nghỉ ngơi, không có lịch chiếu.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
          
            const date = new Date();
            const dayIndex = date.getDay(); 
            
            
            const dayMap = {
                1: 't2-tab', 2: 't3-tab', 3: 't4-tab', 
                4: 't5-tab', 5: 't6-tab', 6: 't7-tab', 0: 'cn-tab'
            };
            
            const tabId = dayMap[dayIndex];
            
           
            if(tabId) {
                const triggerEl = document.querySelector('#' + tabId);
                const tab = new bootstrap.Tab(triggerEl);
                tab.show();
            }
        });
    </script>
</body>
</html>