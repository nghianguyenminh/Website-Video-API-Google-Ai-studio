package com.j4.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.j4.DAO.CategoryDAO;
import com.j4.DAO.UserDAO;
import com.j4.DAO.VideoDAO;
import com.j4.entity.Category;
import com.j4.entity.User;
import com.j4.entity.Video;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8"); 
	    List<Category> categories = CategoryDAO.findAll();
	    request.setAttribute("categories", categories);
	    List<Video> trendingList = VideoDAO.findTopViews(7);
	    request.setAttribute("trendingList", trendingList);
	    
	    String keyword = request.getParameter("keyword");
	    String categoryCode = request.getParameter("category");
	    
	    List<Video> list;
	    
	    if (keyword != null && !keyword.trim().isEmpty()) {
	      
	        list = VideoDAO.findByKeyword(keyword);
	        request.setAttribute("keyword", keyword);
	        
	    } else if (categoryCode != null && !categoryCode.trim().isEmpty()) {  
	       
	        list = VideoDAO.findByCategoryCode(categoryCode);
	        
	     
	        for (Category c : categories) {
	            if (c.getCode().equals(categoryCode)) {
	                request.setAttribute("categoryName", c.getName()); 
	                break;
	            }
	        }
	        
	    } else {
	       
	        list = VideoDAO.findByActive(true);
	    }
	    
	    request.setAttribute("list", list);
	    
	    request.getRequestDispatcher("/views/client/home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		HttpSession   session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		
		if (currentUser != null) {
			try {
				String fullName = request.getParameter("fullName"); // paramate la lay data tu jsp
				String email = request.getParameter("email");
				
				currentUser.setFullName(fullName);
				UserDAO.updadte(currentUser);  
				session.setAttribute("user", currentUser);
				
				request.setAttribute("message", "Cập nhật hồ sơ thành công!");
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("error", "Cập nhật thất bại!");
			}
		}
		
		request.getRequestDispatcher("/views/client/profile.jsp").forward(request, response);
	}
}
