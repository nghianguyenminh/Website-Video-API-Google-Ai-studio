<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm User Mới</title>
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

        <div class="container-fluid p-0">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <h4 class="fw-bold m-0 text-primary"><i class="fas fa-user-plus"></i> Thêm Người Dùng</h4>
                        </div>
                        <div class="card-body p-4">
                            
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <form action="/J4Video/admin/users/add" method="post">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Họ và Tên</label>
                                    <input type="text" class="form-control" name="fullName" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Email</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Mật Khẩu</label>
                                    <input type="password" class="form-control" name="password" required>
                                </div>
                                
                                <div class="row mb-4">
                                    <div class="col-6">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" name="admin" id="adminCheck">
                                            <label class="form-check-label" for="adminCheck">Vai trò Admin</label>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" name="active" id="activeCheck" checked>
                                            <label class="form-check-label" for="activeCheck">Kích hoạt (Không khóa)</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/J4Video/admin/users" class="btn btn-light px-4">Hủy</a>
                                    <button class="btn btn-primary px-4 fw-bold">Lưu Lại</button>
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