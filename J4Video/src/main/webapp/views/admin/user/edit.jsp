<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Trạng Thái User</title>
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
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4 d-flex justify-content-between align-items-center">
                            <h4 class="fw-bold m-0 text-warning"><i class="fas fa-user-lock"></i> Quản Lý Trạng Thái</h4>
                            <span class="badge bg-light text-dark border">ID: ${user.id}</span>
                        </div>
                        
                        <div class="card-body p-4">
                            <form action="${pageContext.request.contextPath}/admin/users/edit" method="post">
                                <input type="hidden" name="id" value="${user.id}">
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-muted">Email (Không thể sửa)</label>
                                    <input type="email" class="form-control bg-light" value="${user.email}" disabled readonly>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold text-muted">Họ và Tên (Không thể sửa)</label>
                                    <input type="text" class="form-control bg-light" value="${user.fullName}" disabled readonly>
                                </div>
                                
                                <div class="mb-4">
                                    <label class="form-label fw-bold text-muted">Vai Trò</label>
                                    <div>
                                        <c:if test="${user.admin}">
                                            <span class="badge bg-primary p-2">Quản Trị Viên (Admin)</span>
                                        </c:if>
                                        <c:if test="${!user.admin}">
                                            <span class="badge bg-secondary p-2">Người Dùng (User)</span>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <div class="card bg-light border-0 p-3 mb-4">
                                    <h6 class="fw-bold mb-3">Cài Đặt Trạng Thái</h6>
                                    
                                    <c:choose>
                                        <%-- Nếu là ADMIN -> Không cho phép thao tác --%>
                                        <c:when test="${user.admin}">
                                            <div class="alert alert-warning m-0">
                                                <i class="fas fa-shield-alt"></i> Tài khoản này là <strong>Admin</strong>. Không thể khóa hoặc xóa.
                                            </div>
                                        </c:when>
                                        
                                        <%-- Nếu là USER thường -> Hiện nút bật tắt --%>
                                        <c:otherwise>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" name="active" id="activeCheck" ${user.active ? 'checked' : ''} style="transform: scale(1.3);">
                                                <label class="form-check-label fw-bold ms-2" for="activeCheck">
                                                    <span class="text-success" id="activeLabel">Đang Hoạt Động</span> 
                                                    <small class="text-muted">(Gạt tắt để khóa)</small>
                                                </label>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-light px-4">Quay Lại</a>
                                    
                                    <%-- Chỉ hiện nút Lưu nếu không phải Admin (hoặc Admin tối cao muốn sửa thì tùy logic sau này) --%>
                                    <c:if test="${!user.admin}">
                                        <button class="btn btn-warning px-4 fw-bold text-white">Lưu Thay Đổi</button>
                                    </c:if>
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