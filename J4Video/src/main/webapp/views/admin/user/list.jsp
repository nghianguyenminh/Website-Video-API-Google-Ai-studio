<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Người Dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/AdminStyle.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="../common/sidebar.jsp">
        <jsp:param name="active" value="users"/>
    </jsp:include>

    <div class="admin-content">
        <jsp:include page="../common/header.jsp"></jsp:include>

        <div class="custom-table-container">
            <div class="table-header-custom">
                <h4 class="fw-bold m-0">Danh Sách Người Dùng</h4>
                </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th>Họ và Tên</th>
                        <th>Email</th>
                        <th>Vai Trò</th>
                        <th>Trạng Thái</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="u">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="https://ui-avatars.com/api/?name=${u.fullName}&background=random" class="rounded-circle me-3" width="40">
                                    <span class="fw-bold">${u.fullName}</span>
                                </div>
                            </td>
                            <td>${u.email}</td>
                            <td>
                                <c:if test="${u.admin}"><span class="badge bg-primary">Admin</span></c:if>
                                <c:if test="${!u.admin}"><span class="badge bg-secondary">User</span></c:if>
                            </td>
                            <td>
                                <c:if test="${u.active}">
                                    <span class="status-badge status-active">Hoạt Động</span>
                                </c:if>
                                <c:if test="${!u.active}">
                                    <span class="status-badge status-inactive">Đã Khóa</span>
                                </c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.admin}">
                                        <span class="text-muted small"><i class="fas fa-shield-alt"></i> Đã Được Bảo Vệ</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/admin/users/edit?id=${u.id}" class="btn btn-light btn-sm text-warning" title="Khóa / Mở khóa">
                                            <i class="fas fa-user-lock"></i>
                                        </a>
                                        <%-- <a href="${pageContext.request.contextPath}/admin/users/delete?id=${u.id}" class="btn btn-light btn-sm text-danger" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa vĩnh viễn user này?')" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </a> --%>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>