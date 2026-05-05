package com.j4.servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.j4.DAO.CategoryDAO;
import com.j4.DAO.UserDAO;
import com.j4.DAO.VideoDAO;
import com.j4.entity.User;
import com.j4.entity.Video;

/**
 * Servlet implementation class AdminHomeServlet
 */
@WebServlet("/admin")
public class AdminHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminHomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		List<Video> videos = VideoDAO.findAll();
        List<User> users = UserDAO.findAll(); 
        long totalViews = VideoDAO.getTotalViews();  // tinh tong luot xem
        
        request.setAttribute("totalVideos", videos.size());
        request.setAttribute("totalUsers", users.size());
        request.setAttribute("totalViews", totalViews);
        
       
        List<Object[]> stats = CategoryDAO.getCategoryStats(); // lay list thong ke de thong ke the loai 
        
        // Tạo 2 chuỗi mảng cho Javascript: cateNames=['A','B'] và cateCounts=[10,5]
        StringBuilder cateNames = new StringBuilder("[");
        StringBuilder cateCounts = new StringBuilder("[");
        
        for (int i = 0; i < stats.size(); i++) {
            Object[] row = stats.get(i);
            String name = (String) row[0]; // lay ten the loai
            Long count = (Long) row[1]; // lay so luong vd
            
            // Nối chuỗi tên (phải có dấu nháy đơn ' ')
            cateNames.append("'").append(name).append("'");
            // Nối chuỗi số
            cateCounts.append(count);
            
            // Nếu chưa phải phần tử cuối thì thêm dấu phẩy
            if (i < stats.size() - 1) {
                cateNames.append(", ");
                cateCounts.append(", ");
            }
        }
        
        // Đóng ngoặc vuông
        cateNames.append("]");
        cateCounts.append("]");
        
        // Gửi dữ liệu biểu đồ sang JSP
        request.setAttribute("cateNames", cateNames.toString());
        request.setAttribute("cateCounts", cateCounts.toString());
        
        // Chuyển hướng về trang Dashboard (home.jsp)
        request.getRequestDispatcher("/views/admin/home.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
