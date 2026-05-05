
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - J4Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/AdminStyle.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

    <jsp:include page="./common/sidebar.jsp">
        <jsp:param name="active" value="dashboard"/>
    </jsp:include>

    <div class="admin-content">
        <jsp:include page="./common/header.jsp"></jsp:include>

        <h3 class="fw-bold mb-4">Tổng Quan</h3>
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-info">
                        <h6>Tổng Người Dùng</h6>
                        <h3>${totalUsers}</h3>
                    </div>
                    <div class="stats-icon bg-primary bg-opacity-10 text-primary">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-info">
                        <h6>Tổng Video</h6>
                        <h3>${totalVideos}</h3>
                    </div>
                    <div class="stats-icon bg-warning bg-opacity-10 text-warning">
                        <i class="fas fa-video"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-info">
                        <h6>Tổng Lượt Xem</h6>
                        <h3>${totalViews}</h3>
                    </div>
                    <div class="stats-icon bg-success bg-opacity-10 text-success">
                        <i class="fas fa-eye"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <div class="chart-container">
                    <h5 class="fw-bold mb-4">Thống Kê Lượt Xem (Wave Chart)</h5>
                    <canvas id="waveChart"></canvas>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="chart-container">
                    <h5 class="fw-bold mb-4">Tỷ Lệ Thể Loại</h5>
                    <canvas id="pieChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script>
        const ctxWave = document.getElementById('waveChart').getContext('2d');
        new Chart(ctxWave, {
            type: 'line',
            data: {
                labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
                datasets: [{
                    label: 'Lượt Truy Cập Giả Lập',
                    data: [120, 190, 300, 500, 200, 300, 450],
                    borderColor: '#4880FF',
                    backgroundColor: 'rgba(72, 128, 255, 0.2)',
                    borderWidth: 2,
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true } }
            }
        });

        // --- 2. PIE CHART (DỮ LIỆU ĐỘNG TỪ SERVLET) ---
        
        // Lấy dữ liệu từ Servlet truyền sang (Dạng chuỗi JS array: ['A','B'] và [10,5])
        const cateLabels = ${cateNames}; 
        const cateData = ${cateCounts};

        // Hàm tạo màu sắc ngẫu nhiên cho đẹp
        function generateColors(count) {
            const colors = [
                '#4880FF', '#00B69B', '#FFB038', '#E91F63', '#9C27B0', 
                '#3F51B5', '#00BCD4', '#8BC34A', '#FFC107', '#795548'
            ];
            // Nếu số category nhiều hơn mảng màu mẫu thì lặp lại hoặc random
            return colors.slice(0, count);
        }

        const ctxPie = document.getElementById('pieChart').getContext('2d');
        new Chart(ctxPie, {
            type: 'doughnut', 
            data: {
                labels: cateLabels, // Tên Category thật
                datasets: [{
                    data: cateData, // Số lượng video thật
                    backgroundColor: generateColors(cateData.length),
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                cutout: '70%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            boxWidth: 12,
                            padding: 20
                        }
                    }
                }
            }
        });
    </script>

</body>
</html>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - J4Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/AdminStyle.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

    <jsp:include page="./common/sidebar.jsp">
        <jsp:param name="active" value="dashboard"/>
    </jsp:include>

    <div class="admin-content">
        <jsp:include page="./common/header.jsp"></jsp:include>

        <h3 class="fw-bold mb-4">Tổng Quan</h3>
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-info">
                        <h6>Tổng Người Dùng</h6>
                        <h3>${totalUsers}</h3>
                    </div>
                    <div class="stats-icon bg-primary bg-opacity-10 text-primary">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-info">
                        <h6>Tổng Video</h6>
                        <h3>${totalVideos}</h3>
                    </div>
                    <div class="stats-icon bg-warning bg-opacity-10 text-warning">
                        <i class="fas fa-video"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-info">
                        <h6>Tổng Lượt Xem</h6>
                        <h3>12,450</h3>
                    </div>
                    <div class="stats-icon bg-success bg-opacity-10 text-success">
                        <i class="fas fa-eye"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <div class="chart-container">
                    <h5 class="fw-bold mb-4">Thống Kê Lượt Xem (Wave Chart)</h5>
                    <canvas id="waveChart"></canvas>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="chart-container">
                    <h5 class="fw-bold mb-4">Tỷ Lệ Thể Loại</h5>
                    <canvas id="pieChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 1. WAVE CHART (Line Chart with fill)
        const ctxWave = document.getElementById('waveChart').getContext('2d');
        new Chart(ctxWave, {
            type: 'line',
            data: {
                labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
                datasets: [{
                    label: 'Lượt Truy Cập',
                    data: [120, 190, 300, 500, 200, 300, 450],
                    borderColor: '#4880FF',
                    backgroundColor: 'rgba(72, 128, 255, 0.2)', // Màu nền dưới sóng
                    borderWidth: 2,
                    tension: 0.4, // Tạo độ cong cho sóng
                    fill: true // Tô màu vùng dưới
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true } }
            }
        });

        // 2. PIE CHART
        const ctxPie = document.getElementById('pieChart').getContext('2d');
        new Chart(ctxPie, {
            type: 'doughnut', // Hoặc 'pie'
            data: {
                labels: ['Tiên Hiệp', 'Kiếm Hiệp', 'Huyền Huyễn'],
                datasets: [{
                    data: [55, 30, 15],
                    backgroundColor: ['#4880FF', '#00B69B', '#FFB038'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                cutout: '70%' // Làm rỗng giữa (Doughnut)
            }
        });
    </script>

</body>
</html> --%>


