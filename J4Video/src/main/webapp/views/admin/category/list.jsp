<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Thể Loại</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/AdminStyle.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="../common/sidebar.jsp">
        <jsp:param name="active" value="categories"/>
    </jsp:include>

    <div class="admin-content">
        <jsp:include page="../common/header.jsp"></jsp:include>

        <div class="custom-table-container">
            <div class="table-header-custom">
                <h4 class="fw-bold m-0">Danh Sách Thể Loại</h4>
                <a href="/J4Video/admin/categories/add" class="btn btn-primary rounded-pill px-4">
                    <i class="fas fa-plus"></i> Thêm Mới
                </a>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Thể Loại</th>
                        <th>Mã Code (Slug)</th>
                        <th>Số Video</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="item">
                        <tr>
                            <td>#${item.id}</td>
                            <td>
                                <span class="fw-bold text-primary">${item.name}</span>
                            </td>
                            <td>
                                <span class="badge bg-light text-secondary border">${item.code}</span>
                            </td>
                            <td>${item.videos.size()} video</td>
                            <td>
                                <a href="/J4Video/admin/categories/edit?id=${item.id}" class="btn btn-light btn-sm text-primary" title="Chỉnh sửa">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="/J4Video/admin/categories/delete?id=${item.id}" class="btn btn-light btn-sm text-danger" 
                                   title="Xóa" onclick="return confirm('Cảnh báo: Xóa thể loại này có thể ảnh hưởng đến các video thuộc về nó. Bạn có chắc chắn?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="5" class="text-center text-muted py-4">Chưa có thể loại nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>