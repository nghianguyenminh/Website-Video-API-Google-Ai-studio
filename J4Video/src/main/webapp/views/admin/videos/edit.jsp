<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/AdminStyle.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="../common/sidebar.jsp">
        <jsp:param name="active" value="videos"/>
    </jsp:include>

    <div class="admin-content">
        <jsp:include page="../common/header.jsp"></jsp:include>

        <div class="container-fluid p-0">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4 d-flex justify-content-between align-items-center">
                            <h4 class="fw-bold m-0 text-warning"><i class="fas fa-edit"></i> Cập Nhật Video</h4>
                            <span class="badge bg-light text-dark border">ID: ${video.id}</span>
                        </div>
                        
                        <div class="card-body p-4">
                            
                            <c:if test="${not empty message}">
                                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${message}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
                            </c:if>

                            <form action="/J4Video/admin/videos/edit" method="post">
                                <input type="hidden" name="id" value="${video.id}">
                                
                                <div class="row">
                                    <div class="col-md-7">
                                        <div class="mb-3">
                                            <label for="title" class="form-label fw-bold">Tiêu Đề Video</label>
                                            <input type="text" class="form-control" id="title" name="title" value="${video.title}" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="youtube_id" class="form-label fw-bold">Youtube ID</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"><i class="fab fa-youtube text-danger"></i></span>
                                                <input type="text" class="form-control" id="youtube_id" name="youtube_id" value="${video.youtube_id}" required>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="poster" class="form-label fw-bold">Link Poster</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"><i class="fas fa-image text-primary"></i></span>
                                                <input type="text" class="form-control" id="poster" name="poster" value="${video.poster}" required>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="description" class="form-label fw-bold">Mô Tả</label>
                                            <textarea class="form-control" id="description" name="description" rows="5">${video.description}</textarea>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Thể Loại</label>
                                            <select class="form-select" name="categoryId">
                                                <c:forEach items="${categories}" var="item">
                                                    <option value="${item.id}" ${video.category.id == item.id ? 'selected' : ''}>
                                                        ${item.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Lịch Chiếu (Thứ mấy?)</label>
                                            <select class="form-select" name="schedule">
                                                <option value="">-- Không đặt lịch --</option>
                                                <option value="T2" ${video.schedule == 'T2' ? 'selected' : ''}>Thứ 2</option>
                                                <option value="T3" ${video.schedule == 'T3' ? 'selected' : ''}>Thứ 3</option>
                                                <option value="T4" ${video.schedule == 'T4' ? 'selected' : ''}>Thứ 4</option>
                                                <option value="T5" ${video.schedule == 'T5' ? 'selected' : ''}>Thứ 5</option>
                                                <option value="T6" ${video.schedule == 'T6' ? 'selected' : ''}>Thứ 6</option>
                                                <option value="T7" ${video.schedule == 'T7' ? 'selected' : ''}>Thứ 7</option>
                                                <option value="CN" ${video.schedule == 'CN' ? 'selected' : ''}>Chủ Nhật</option>
                                            </select>
                                        </div>
                                        
                                        <div class="mb-4 form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="active" name="active" ${video.active ? 'checked' : ''}>
                                            <label class="form-check-label fw-bold" for="active">Đang hoạt động (Active)</label>
                                        </div>
                                    </div>

                                    <%-- <div class="col-md-5">
                                        <div class="card bg-light border-0 h-100">
                                            <div class="card-body text-center">
                                                <h6 class="text-muted mb-3">Ảnh Poster Hiện Tại</h6>
                                                
                                                <div class="ratio ratio-2x3 mb-3 shadow-sm rounded overflow-hidden mx-auto" style="max-width: 200px;">
                                                    <img id="imgPreview" src="${video.poster}" alt="Preview" class="img-fluid" style="object-fit: cover;">
                                                </div>
                                                
                                                <h6 class="text-muted mb-2">Thông Số</h6>
                                                <ul class="list-group list-group-flush bg-transparent text-start d-inline-block">
                                                    <li class="list-group-item bg-transparent"><i class="fas fa-eye me-2"></i> Lượt xem: <strong>${video.view_count}</strong></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div> --%>
                                    
                                    <div class="col-md-5">
    <div class="card bg-light border-0 h-100">
        <div class="card-body text-center">
            <h6 class="text-muted mb-3">Ảnh Poster Hiện Tại</h6>
            
            <div class="mx-auto shadow-sm rounded overflow-hidden mb-3" 
                 style="width: 200px; height: 300px; background-color: #e9ecef; border: 1px solid #dee2e6;">
                
                <img id="imgPreview" src="${video.poster}" alt="Preview" 
                     style="width: 100%; height: 100%; object-fit: cover; display: block;">
            </div>
            
            <h6 class="text-muted mb-2">Thông Số</h6>
            <ul class="list-group list-group-flush bg-transparent text-start d-inline-block">
                <li class="list-group-item bg-transparent">
                    <i class="fas fa-eye me-2"></i> Lượt xem: <strong>${video.view_count}</strong>
                </li>
            </ul>
        </div>
    </div>
</div> 
                                    
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-3 border-top pt-3">
                                    <a href="/J4Video/admin/videos" class="btn btn-light px-4">Quay Lại</a>
                                    <button class="btn btn-warning px-4 fw-bold text-white">Cập Nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Lấy thẻ input nhập link
        const posterInput = document.getElementById('poster');
        // Lấy thẻ img hiển thị
        const posterImg = document.getElementById('imgPreview');

        // Lắng nghe sự kiện khi người dùng gõ hoặc dán link (input)
        posterInput.addEventListener('input', function() {
            const newUrl = this.value;
            if (newUrl) {
                // Gán link mới cho ảnh
                posterImg.src = newUrl;
            } else {
                // Nếu xóa trắng thì hiện ảnh mặc định hoặc giữ nguyên (tùy chọn)
                posterImg.src = 'https://via.placeholder.com/200x300?text=No+Image';
            }
        });

        // Xử lý lỗi nếu link ảnh chết (không load được)
        posterImg.onerror = function() {
            this.src = 'https://via.placeholder.com/200x300?text=Lỗi+Link+Ảnh';
        };
    </script>

</body>
</html>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/AdminStyle.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="../common/sidebar.jsp">
        <jsp:param name="active" value="videos"/>
    </jsp:include>

    <div class="admin-content">
        <jsp:include page="../common/header.jsp"></jsp:include>

        <div class="container-fluid p-0">
            <div class="row justify-content-center">
                <div class="col-lg-10"> <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4 d-flex justify-content-between align-items-center">
                            <h4 class="fw-bold m-0 text-warning"><i class="fas fa-edit"></i> Cập Nhật Video</h4>
                            <span class="badge bg-light text-dark border">ID: ${video.id}</span>
                        </div>
                        
                        <div class="card-body p-4">
                            
                            <c:if test="${not empty message}">
                                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${message}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
                            </c:if>

                            <form action="/J4Video/admin/videos/edit" method="post">
                                <input type="hidden" name="id" value="${video.id}">
                                
                                <div class="row">
                                    <div class="col-md-7">
                                        <div class="mb-3">
                                            <label for="title" class="form-label fw-bold">Tiêu Đề Video</label>
                                            <input type="text" class="form-control" id="title" name="title" value="${video.title}" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="youtube_id" class="form-label fw-bold">Youtube ID</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"><i class="fab fa-youtube text-danger"></i></span>
                                                <input type="text" class="form-control" id="youtube_id" name="youtube_id" value="${video.youtube_id}" required>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="poster" class="form-label fw-bold">Link Poster</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"><i class="fas fa-image text-primary"></i></span>
                                                <input type="text" class="form-control" id="poster" name="poster" value="${video.poster}" required>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="description" class="form-label fw-bold">Mô Tả</label>
                                            <textarea class="form-control" id="description" name="description" rows="5">${video.description}</textarea>
                                        </div>
                                        
                                        <div class="mb-3">
										    <label class="form-label fw-bold">Thể Loại</label>
										    <select class="form-select" name="categoryId">
										        <c:forEach items="${categories}" var="item">
										            <option value="${item.id}" ${video.category.id == item.id ? 'selected' : ''}>
										                ${item.name}
										            </option>
										        </c:forEach>
										    </select>
										</div>
										
										<div class="mb-3">
										    <label class="form-label fw-bold">Lịch Chiếu (Thứ mấy?)</label>
										    <select class="form-select" name="schedule">
										        <option value="">-- Không đặt lịch --</option>
										        
										        <option value="T2" ${video.schedule == 'T2' ? 'selected' : ''}>Thứ 2</option>
										        <option value="T3" ${video.schedule == 'T3' ? 'selected' : ''}>Thứ 3</option>
										        <option value="T4" ${video.schedule == 'T4' ? 'selected' : ''}>Thứ 4</option>
										        <option value="T5" ${video.schedule == 'T5' ? 'selected' : ''}>Thứ 5</option>
										        <option value="T6" ${video.schedule == 'T6' ? 'selected' : ''}>Thứ 6</option>
										        <option value="T7" ${video.schedule == 'T7' ? 'selected' : ''}>Thứ 7</option>
										        <option value="CN" ${video.schedule == 'CN' ? 'selected' : ''}>Chủ Nhật</option>
										    </select>
										</div>
                                        
                                        <div class="mb-4 form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="active" name="active" ${video.active ? 'checked' : ''}>
                                            <label class="form-check-label fw-bold" for="active">Đang hoạt động (Active)</label>
                                        </div>
                                    </div>

                                    <div class="col-md-5">
                                        <div class="card bg-light border-0 h-100">
                                            <div class="card-body text-center">
                                                <h6 class="text-muted mb-3">Ảnh Poster Hiện Tại</h6>
                                                <div class="ratio ratio-2x3 mb-3 shadow-sm rounded overflow-hidden mx-auto" style="max-width: 200px;">
                                                    <img src="${video.poster}" alt="Preview" class="img-fluid" style="object-fit: cover;">
                                                </div>
                                                
                                                <h6 class="text-muted mb-2">Thông Số</h6>
                                                <ul class="list-group list-group-flush bg-transparent text-start d-inline-block">
                                                    <li class="list-group-item bg-transparent"><i class="fas fa-eye me-2"></i> Lượt xem: <strong>${video.view_count}</strong></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-3 border-top pt-3">
                                    <a href="/J4Video/admin/videos" class="btn btn-light px-4">Quay Lại</a>
                                    <button class="btn btn-warning px-4 fw-bold text-white">Cập Nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html> --%>