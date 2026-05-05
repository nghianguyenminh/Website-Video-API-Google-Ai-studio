package com.j4.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.j4.DAO.UserDAO;
import com.j4.entity.User;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		request.getRequestDispatcher("/views/client/profile.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String fullName = request.getParameter("fullName");
            
            if (fullName != null && !fullName.trim().isEmpty()) {
                user.setFullName(fullName);
                UserDAO.updadte(user); // bat dau goi dao de luu vo DB
                 session.setAttribute("user", user); // update lai sessi de hien thi data tuc thi
                
                request.setAttribute("message", "Cập nhật hồ sơ thành công!");
            } else {
                request.setAttribute("error", "Tên hiển thị không được để trống!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cập nhật: " + e.getMessage());
        }
        
        // 4. Load lại trang Profile với thông báo thành công/thất bại
        request.getRequestDispatcher("/views/client/profile.jsp").forward(request, response);
    }

}
