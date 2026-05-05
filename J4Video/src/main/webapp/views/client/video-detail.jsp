<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${video.title} - Vân Lộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        /* CSS riêng cho trang chi tiết */
        .video-container {
            position: relative;
            padding-bottom: 56.25%; /* Tỷ lệ 16:9 */
            height: 0;
            overflow: hidden;
            border-radius: 12px;
            border: 1px solid #333;
            box-shadow: 0 0 20px rgba(0,0,0,0.5);
        }
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .server-btn {
            background: #222;
            color: #ccc;
            border: 1px solid #444;
            margin-right: 10px;
            transition: all 0.3s;
        }
        .server-btn:hover, .server-btn.active {
            background: var(--accent-color);
            color: #000;
            border-color: var(--accent-color);
        }
        .related-card {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
            background: rgba(255,255,255,0.05);
            padding: 8px;
            border-radius: 8px;
            transition: all 0.2s;
            text-decoration: none;
            color: #ddd;
        }
        .related-card:hover {
            background: rgba(255,255,255,0.1);
            color: var(--accent-color);
        }
        .related-poster {
            width: 80px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        /* CSS MODAL */
        .modal-overlay {
            display: none; /* Quan trọng: Mặc định ẩn */
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.85);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(5px);
            animation: fadeIn 0.3s;
        }

        .share-card {
            background: #1a1a1a;
            width: 90%;
            max-width: 400px;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #444;
            box-shadow: 0 0 30px rgba(243, 156, 18, 0.3);
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 10px; right: 15px;
            color: white; font-size: 1.5rem; cursor: pointer; z-index: 10;
            text-shadow: 0 0 5px black;
        }

        .share-header {
            height: 180px;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .share-overlay {
            background: linear-gradient(to top, #1a1a1a, rgba(0,0,0,0.3));
            position: absolute;
            bottom: 0; left: 0; width: 100%;
            padding: 15px;
        }

        .share-label {
            color: var(--accent-color);
            font-size: 0.75rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 5px;
            text-shadow: 0 0 5px black;
        }

        .share-title {
            color: white;
            margin: 0;
            font-size: 1.2rem;
            font-weight: bold;
            text-shadow: 0 0 5px black;
            font-family: 'Montserrat', sans-serif;
        }
        
        .share-desc {
            color: #ccc; font-size: 0.8rem; margin: 0;
        }

        .share-body {
            padding: 20px;
        }
        
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>
    
    <jsp:include page="../common/header.jsp"></jsp:include>
    
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show container mt-3" role="alert">
            <i class="fas fa-check-circle"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show container mt-3" role="alert">
            <i class="fas fa-exclamation-triangle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="container mt-4">
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/J4Video/home" class="text-warning text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="#" class="text-warning text-decoration-none">${video.category.name}</a></li>
                <li class="breadcrumb-item active text-white-50" aria-current="page">${video.title}</li>
            </ol>
        </nav>

        <div class="row">
            <div class="col-lg-8">
                <div class="video-container mb-4">
                    <iframe src="https://www.youtube.com/embed/${video.youtube_id}?autoplay=1&rel=0" 
                            title="YouTube video player" frameborder="0" 
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                            allowfullscreen></iframe>
                </div>

                <div class="card bg-dark border-secondary mb-4 text-white">
                    <div class="card-header border-secondary">
                        <i class="fas fa-list-ol text-warning"></i> Danh Sách Tập
                    </div>
                    <div class="card-body">
                        <span class="text-muted small mb-2 d-block">Server Vip:</span> 
                        <a href="#" class="btn btn-sm server-btn active">Tập Full</a>
                    </div>
                </div>

                <div class="mb-4">
                    <h2 class="fw-bold" style="font-family: 'Montserrat', sans-serif; color: var(--accent-color);">${video.title}</h2>

                    <div class="d-flex align-items-center mb-3 text-white-50 small">
                        <span class="me-3"><i class="fas fa-eye text-warning"></i> ${video.view_count} lượt xem</span> 
                        <span class="me-3"><i class="fas fa-clock text-warning"></i> Cập nhật mới nhất</span>
                    </div>

                    <div class="d-flex gap-2 mb-4">
                        <a href="/J4Video/favorites/add?id=${video.id}" class="btn btn-danger btn-sm rounded-pill px-3"> 
                            <i class="fas fa-heart"></i> Yêu Thích
                        </a>
                        <button class="btn btn-primary btn-sm rounded-pill px-3" onclick="openShareModal()">
                            <i class="fas fa-share"></i> Chia Sẻ
                        </button>
                        <c:if test="${sessionScope.user != null && sessionScope.user.admin}">
                            <a href="/J4Video/admin/videos/edit?id=${video.id}" class="btn btn-warning btn-sm rounded-pill px-3"> 
                                <i class="fas fa-edit"></i> Sửa Video
                            </a>
                        </c:if>
                    </div>

                    <div class="card bg-transparent border border-secondary text-white">
                        <div class="card-body">
                            <h5 class="card-title text-warning">Nội dung cốt truyện</h5>
                            <p class="card-text text-white-50" style="line-height: 1.6;">${video.description}</p>
                        </div>
                    </div>
                </div>

                <div class="card bg-dark text-white border-secondary mb-5">
                    <div class="card-header border-secondary">
                        <i class="fas fa-comments text-warning"></i> Bình Luận
                    </div>
                    
                    <div class="card-body">
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <form action="${pageContext.request.contextPath}/comment" method="post" class="d-flex gap-3 mb-4">
                <input type="hidden" name="videoId" value="${video.id}">
                
                <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center flex-shrink-0" style="width: 40px; height: 40px;">
                    <i class="fas fa-user text-white"></i>
                </div>
                
                <div class="input-group">
                    <input type="text" name="content" class="form-control bg-black text-white border-secondary" 
                           placeholder="Viết bình luận của bạn..." required autocomplete="off">
                    <button class="btn btn-warning" type="submit">
                        <i class="fas fa-paper-plane"></i> Gửi
                    </button>
                </div>
            </form>
        </c:when>
        <c:otherwise>
            <div class="alert alert-dark border-secondary text-center mb-4">
                Vui lòng <a href="${pageContext.request.contextPath}/login" class="text-warning fw-bold text-decoration-none">Đăng nhập</a> để tham gia bình luận.
            </div>
        </c:otherwise>
    </c:choose>

    <div class="comment-list">
        <c:if test="${empty comments}">
            <p class="text-white-50 small text-center fst-italic">Chưa có bình luận nào. Hãy là người đầu tiên!</p>
        </c:if>

        <c:forEach items="${comments}" var="cmt">
            <div class="d-flex gap-3 mb-3 pb-3 border-bottom border-secondary" style="border-color: #333 !important;">
                <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center flex-shrink-0" style="width: 40px; height: 40px;">
                    <i class="fas fa-user text-white"></i>
                </div>
                
                <div>
                    <div class="d-flex align-items-end gap-2">
                        <h6 class="mb-0 text-warning fw-bold" style="font-size: 0.95rem;">
                            ${cmt.user.fullName}
                            <c:if test="${cmt.user.admin}">
                                <i class="fas fa-check-circle small text-primary" title="Quản trị viên"></i>
                            </c:if>
                        </h6>
                        <small class="text-muted" style="font-size: 0.75rem;">
                            <i class="far fa-clock"></i> ${cmt.commentDate}
                        </small>
                    </div>
                    <p class="mb-0 text-white-50 mt-1" style="font-size: 0.95rem;">${cmt.content}</p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
                    
                </div>
            </div>

            <div class="col-lg-4">
                <h5 class="text-warning mb-3" style="font-family: 'Montserrat', sans-serif; border-left: 3px solid var(--accent-color); padding-left: 10px;">
                    CÓ THỂ BẠN MUỐN XEM
                </h5>

                <div class="d-flex flex-column">
                    <c:forEach items="${relatedVideos}" var="item">
                        <a href="/J4Video/video?id=${item.id}" class="related-card">
                            <div class="flex-shrink-0">
                                <img src="${item.poster}" alt="${item.title}" class="related-poster">
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1 text-truncate" style="font-size: 0.95rem; font-weight: bold;">${item.title}</h6>
                                <small class="text-white-50"><i class="fas fa-eye"></i> ${item.view_count} views</small>
                            </div>
                        </a>
                    </c:forEach>
                </div>

               <!--  <div class="mt-4 rounded overflow-hidden shadow-sm">
                    <img src="https://wallpapers.com/images/high/dark-anime-scenery-1920-x-1080-wallpaper-z6o18j08y5k25w7n.webp" class="w-100" style="opacity: 0.7;">
                </div> -->
                
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <div id="shareModal" class="modal-overlay">
        <div class="share-card">
            <span class="close-modal" onclick="closeShareModal()">&times;</span>
            
            <div class="share-header" style="background-image: url('${video.poster}');">
                <div class="share-overlay">
                    <h5 class="share-label">CHIA SẺ THỨC HẢI</h5>
                    <h3 class="share-title text-truncate">${video.title}</h3>
                    <p class="share-desc text-truncate">${video.description}</p>
                </div>
            </div>

            <div class="share-body">
                <form action="/J4Video/share" method="post" id="shareForm">
                    <input type="hidden" name="videoId" value="${video.id}">
                    <input type="hidden" name="videoTitle" value="${video.title}">
                    
                    <div class="mb-3">
                        <label class="form-label text-warning small fw-bold">QUÝ DANH (EMAIL):</label>
                        <input type="email" name="email" class="form-control bg-dark text-white border-secondary" 
                               placeholder="nhap_email_ban_be@example.com" required>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-warning fw-bold text-dark py-2">
                            <i class="fas fa-paper-plane me-2"></i> GỬI THƯ NGAY
                        </button>
                    </div>
                </form>
                <div class="text-center mt-3">
                    <a href="#" class="text-muted small text-decoration-none" onclick="closeShareModal()">Hủy bỏ</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openShareModal() {
            var modal = document.getElementById('shareModal');
            if(modal) {
                modal.style.display = 'flex'; // Hiện modal
            }
        }

        function closeShareModal() {
            var modal = document.getElementById('shareModal');
            if(modal) {
                modal.style.display = 'none'; // Ẩn modal
            }
        }
        
        // Đóng khi click ra vùng đen bên ngoài
        window.onclick = function(event) {
            var modal = document.getElementById('shareModal');
            if (event.target == modal) {
                closeShareModal();
            }
        }
    </script>
</body>
</html>