package com.j4.servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.j4.DAO.UserDAO;
import com.j4.entity.User;

import jakarta.persistence.Entity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

/**
 * Servlet implementation class UserManagerServlet
 */
@WebServlet({"/admin/users", "/admin/users/add", "/admin/users/edit", "/admin/users/delete"})
public class UserManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserManagerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        String uri = request.getRequestURI();    
        String keyword = request.getParameter("keyword");

        if (uri.contains("edit")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            User user = UserDAO.findById(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/admin/user/edit.jsp").forward(request, response);
            
        } else if (uri.contains("delete")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            User user = UserDAO.findById(id);
            
            // LOGIC BẢO VỆ: Không cho xóa tài khoản Admin
            if (user != null && !user.isAdmin()) {
                UserDAO.delete(id); 
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
            
        } else {
            // Danh sách User
            List<User> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = UserDAO.findByKeyword(keyword); 
            } else {
                list = UserDAO.findAll(); 
            }
            request.setAttribute("list", list);
            request.getRequestDispatcher("/views/admin/user/list.jsp").forward(request, response);
        }
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        String uri = request.getRequestURI();
        
        if (uri.contains("edit")) {
            try {
                Integer id = Integer.parseInt(request.getParameter("id"));
                User user = UserDAO.findById(id);
                
              
                
                // Nếu user này LÀ ADMIN -> Luôn luôn Active (Không cho phép khóa)
                if (user.isAdmin()) {
                    user.setActive(true); 
                } else {
                    // Nếu là User thường -> Nhận trạng thái từ checkbox
                    boolean active = request.getParameter("active") != null;
                    user.setActive(active);
                }
                
                UserDAO.updadte(user); // Cập nhật vào DB
                
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        }
    }

}
