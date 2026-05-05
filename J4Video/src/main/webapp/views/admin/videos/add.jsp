<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Video Mới</title>
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
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <h4 class="fw-bold m-0 text-primary"><i class="fas fa-plus-circle"></i> Thêm Video Mới</h4>
                        </div>
                        <div class="card-body p-4">
                            
                            <c:if test="${not empty message}">
                                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${message}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
                            </c:if>

                            <form action="/J4Video/admin/videos/add" method="post">
                                <div class="mb-3">
                                    <label for="title" class="form-label fw-bold">Tiêu Đề Video</label>
                                    <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tên video..." required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="youtube_id" class="form-label fw-bold">Youtube ID</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light"><i class="fab fa-youtube text-danger"></i></span>
                                            <input type="text" class="form-control" id="youtube_id" name="youtube_id" placeholder="Ví dụ: dQw4w9WgXcQ" required>
                                        </div>
                                        <div class="form-text">Mã ID phía sau 'v=' trên đường dẫn Youtube.</div>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="poster" class="form-label fw-bold">Link Poster (Ảnh bìa)</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light"><i class="fas fa-image text-primary"></i></span>
                                            <input type="text" class="form-control" id="poster" name="poster" placeholder="https://..." required>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label fw-bold">Mô Tả Nội Dung</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" placeholder="Tóm tắt nội dung phim..."></textarea>
                                </div>
                                
                                <div class="mb-3">
								    <label class="form-label fw-bold">Lịch Chiếu (Thứ mấy?)</label>
								    <select class="form-select" name="schedule">
								        <option value="">-- Không đặt lịch --</option>
								        <option value="T2">Thứ 2</option>
								        <option value="T3">Thứ 3</option>
								        <option value="T4">Thứ 4</option>
								        <option value="T5">Thứ 5</option>
								        <option value="T6">Thứ 6</option>
								        <option value="T7">Thứ 7</option>
								        <option value="CN">Chủ Nhật</option>
								    </select>
								    <div class="form-text">Chọn ngày phim ra tập mới để hiển thị trên trang Lịch Chiếu.</div>
								</div>
                                
                                <div class="mb-3">
								    <label class="form-label fw-bold">Thể Loại</label>
								    <select class="form-select" name="categoryId">
								        <c:forEach items="${categories}" var="item">
								            <option value="${item.id}">${item.name}</option>
								        </c:forEach>
								    </select>
								</div>

                                <div class="mb-4 form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="active" name="active" checked>
                                    <label class="form-check-label fw-bold" for="active">Kích hoạt (Hiển thị ngay)</label>
                                </div>
                                
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/J4Video/admin/videos" class="btn btn-light px-4">Hủy Bỏ</a>
                                    <button class="btn btn-primary px-4 fw-bold">Thêm Mới</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>