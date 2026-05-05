package com.j4.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.j4.DAO.UserDAO;
import com.j4.DAO.VideoDAO;
import com.j4.entity.User;
import com.j4.entity.Video;

/**
 * Servlet implementation class AuthServlet
 */
@WebServlet({"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uri = request.getRequestURI();
		if (uri.contains("login")) {
			request.getRequestDispatcher("/views/client/login.jsp").forward(request, response);
		} else if (uri.contains("logout")) { 
			
			request.getSession().removeAttribute("user");
			
			response.sendRedirect(request.getContextPath() + "/home");
		}
		else{
			request.getRequestDispatcher("/views/client/register.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String uri = request.getRequestURI();
		
		if (uri.contains("login")) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			User user = UserDAO.findByEmail(email);
			if (user == null || !user.getPassword().equals(password)) {
				request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng!");
				request.getRequestDispatcher("/views/client/login.jsp").forward(request, response);
			} else {
				// ckeck off tk
				if (!user.isActive()) { 
			        request.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
			        request.getRequestDispatcher("/views/client/login.jsp").forward(request, response);
			        return; 
			    }
				
				request.getSession().setAttribute("user", user);
				
				if (user.isAdmin()) {
			        response.sendRedirect(request.getContextPath() + "/admin");
			    } else {
			        response.sendRedirect(request.getContextPath() + "/home");
			    }
			}
			
		} else if (uri.contains("register")) { 
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String repeatPassword = request.getParameter("repeatPassword");
			String fullname = request.getParameter("fullName");
			
			if (!password.equals(repeatPassword)) {
				request.setAttribute("error", "Xác nhận mật khẩu không đúng!");
				request.getRequestDispatcher("/views/client/register.jsp").forward(request, response);
			} else {
				// check email co ton tai k
				User existingUser = UserDAO.findByEmail(email);
				if (existingUser != null) {
					request.setAttribute("error", "Email này đã được sử dụng!");
					request.getRequestDispatcher("/views/client/register.jsp").forward(request, response);
				} else {
					User user = new User();  
					user.setEmail(email);
					user.setPassword(password); // Lưu password
					user.setFullName(fullname);
					user.setActive(true);
					user.setAdmin(false);
					
					UserDAO.insert(user);
					request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
					request.getRequestDispatcher("/views/client/login.jsp").forward(request, response);
				}
			}
		}
	}

}
