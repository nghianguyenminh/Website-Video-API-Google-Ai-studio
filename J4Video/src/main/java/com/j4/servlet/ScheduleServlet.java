package com.j4.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.j4.DAO.CategoryDAO;
import com.j4.DAO.VideoDAO;
import com.j4.entity.Category;
import com.j4.entity.Video;
/**
 * Servlet implementation class ScheduleServlet
 */
@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScheduleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Category> categories = CategoryDAO.findAll();
        request.setAttribute("categories", categories);

        
        List<Video> list = VideoDAO.findByActive(true);
        request.setAttribute("list", list);

        request.getRequestDispatcher("/views/client/schedule.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
