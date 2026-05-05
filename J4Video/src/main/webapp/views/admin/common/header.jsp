<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<div class="admin-header">
    <form action="" method="get" class="search-bar">
	    <i class="fas fa-search text-muted"></i>
	    <input type="text" name="keyword" 
	           value="${param.keyword}" 
	           placeholder="Tìm kiếm quản trị...">
	</form>
    <div class="user-profile d-flex align-items-center">
        <div class="me-3 text-end">
            <h6 class="mb-0 fw-bold">${sessionScope.user.fullName}</h6>
            <small class="text-muted">Admin</small>
        </div>
        <img src="https://ui-avatars.com/api/?name=${sessionScope.user.fullName}&background=4880FF&color=fff" 
             class="rounded-circle" width="45" height="45">
    </div>
</div>