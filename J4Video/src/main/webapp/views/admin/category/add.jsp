<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Thể Loại Mới</title>
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

        <div class="container-fluid p-0">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <h4 class="fw-bold m-0 text-primary"><i class="fas fa-folder-plus"></i> Thêm Thể Loại</h4>
                        </div>
                        <div class="card-body p-4">
                            
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
                            </c:if>

                            <form action="/J4Video/admin/categories/add" method="post">
                                <div class="mb-3">
                                    <label for="name" class="form-label fw-bold">Tên Thể Loại</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Ví dụ: Tiên Hiệp" required>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="code" class="form-label fw-bold">Mã Code (Slug)</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="fas fa-code"></i></span>
                                        <input type="text" class="form-control" id="code" name="code" placeholder="Ví dụ: tien-hiep" required>
                                    </div>
                                    <div class="form-text">Mã code nên viết liền không dấu, dùng gạch nối.</div>
                                </div>
                                
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/J4Video/admin/categories" class="btn btn-light px-4">Hủy Bỏ</a>
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
</html>