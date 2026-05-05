package com.j4.servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.j4.DAO.CategoryDAO;
import com.j4.entity.Category;

/**
 * Servlet implementation class CategoryManagerServlet
 */
@WebServlet({"/admin/categories", "/admin/categories/add", "/admin/categories/edit", "/admin/categories/delete"})
public class CategoryManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryManagerServlet() {
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
            Category category = CategoryDAO.findById(id);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/views/admin/category/edit.jsp").forward(request, response);
            
        } else if (uri.contains("add")) {
            request.getRequestDispatcher("/views/admin/category/add.jsp").forward(request, response);
            
        } else if (uri.contains("delete")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            CategoryDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            
        } else {
        	List<Category> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = CategoryDAO.findByKeyword(keyword);
            } else {
                list = CategoryDAO.findAll();
            }
            request.setAttribute("list", list);
            request.getRequestDispatcher("/views/admin/category/list.jsp").forward(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        String uri = request.getRequestURI();
        
        String name = request.getParameter("name");
        String code = request.getParameter("code");

        if (uri.contains("add")) {
            Category c = new Category();
            c.setName(name);
            c.setCode(code);
            CategoryDAO.insert(c);
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            
        } else if (uri.contains("edit")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            Category c = CategoryDAO.findById(id);
            c.setName(name);
            c.setCode(code);
            CategoryDAO.update(c);
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
	}

}
