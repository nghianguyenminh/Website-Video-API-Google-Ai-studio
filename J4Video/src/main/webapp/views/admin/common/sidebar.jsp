<%@ page pageEncoding="UTF-8"%>
<div class="admin-sidebar">
    <div class="sidebar-brand">
        <i class="fas fa-dragon"></i> J4 Admin
    </div>
    <ul class="sidebar-menu">
        <li>
            <a href="/J4Video/admin" class="sidebar-link ${param.active == 'dashboard' ? 'active' : ''}">
                <i class="fas fa-th-large"></i> <span>Dashboard</span>
            </a>
        </li>
        <li>
		    <a href="/J4Video/admin/categories" class="sidebar-link ${param.active == 'categories' ? 'active' : ''}">
		        <i class="fas fa-list-alt"></i> <span>Quản Lý Thể Loại</span>
		    </a>
		</li>
        <li>
            <a href="/J4Video/admin/videos" class="sidebar-link ${param.active == 'videos' ? 'active' : ''}">
                <i class="fas fa-video"></i> <span>Quản Lý Video</span>
            </a>
        </li>
        <li>
            <a href="/J4Video/admin/users" class="sidebar-link ${param.active == 'users' ? 'active' : ''}">
                <i class="fas fa-users"></i> <span>Quản Lý User</span>
            </a>
        </li>
         <li>
            <a href="/J4Video/home" class="sidebar-link">
                <i class="fas fa-home"></i> <span>Về Trang Chủ</span>
            </a>
        </li>
    </ul>
</div>