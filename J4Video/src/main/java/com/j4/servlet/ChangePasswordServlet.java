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
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/changepassword")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/views/client/change-password.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentPass = request.getParameter("currentPass");
        String newPass = request.getParameter("newPass");
        String confirmPass = request.getParameter("confirmPass");

        // 1. Kiểm tra mật khẩu cũ (Trong thực tế nên dùng BCrypt, ở đây so sánh string thường theo entity hiện tại)
        if (!currentUser.getPassword().equals(currentPass)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("/views/client/change-password.jsp").forward(request, response);
            return;
        }

        // 2. Kiểm tra mật khẩu mới trùng khớp
        if (!newPass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/views/client/change-password.jsp").forward(request, response);
            return;
        }

        // 3. Cập nhật mật khẩu mới
        try {
            currentUser.setPassword(newPass);
            UserDAO.updadte(currentUser); 
            
            request.setAttribute("message", "Đổi mật khẩu thành công!");
            // upadte lai session
            session.setAttribute("user", currentUser);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại!");
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/views/client/change-password.jsp").forward(request, response);
    }

}
