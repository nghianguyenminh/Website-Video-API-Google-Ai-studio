<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Video</title>
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

        <div class="custom-table-container">
            <div class="table-header-custom">
                <h4 class="fw-bold m-0">Danh Sách Video</h4>
                <a href="/J4Video/admin/videos/add" class="btn btn-primary rounded-pill px-4">
                    <i class="fas fa-plus"></i> Thêm Mới
                </a>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th>Video</th>
                        <th>Thể Loại</th>
                        <th>Youtube ID</th>
                        <th>Lượt Xem</th>
                        <th>Trạng Thái</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="video">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${video.poster}" class="rounded" width="60" height="40" style="object-fit: cover; margin-right: 15px;">
                                    <div>
                                        <h6 class="mb-0 fw-bold" style="font-size: 0.9rem;">${video.title}</h6>
                                        <small class="text-muted">ID: ${video.id}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
							    <span class="badge bg-info text-dark">${video.category.name}</span>
							</td>
                            <td><span class="text-muted">${video.youtube_id}</span></td>
                            <td>${video.view_count}</td>
                            <td>
                                <span class="status-badge ${video.active ? 'status-active' : 'status-inactive'}">
                                    ${video.active ? 'Công Khai' : 'Ẩn'}
                                </span>
                            </td>
                            <td>
                                <a href="/J4Video/admin/videos/edit?id=${video.id}" class="btn btn-light btn-sm text-primary">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="/J4Video/admin/videos/delete?id=${video.id}" class="btn btn-light btn-sm text-danger" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa video này?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>