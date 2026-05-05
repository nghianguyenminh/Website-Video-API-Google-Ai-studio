package com.j4.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.j4.DAO.FavoriteDAO;
import com.j4.DAO.UserDAO;
import com.j4.DAO.VideoDAO;
import com.j4.entity.Favorite;
import com.j4.entity.User;
import com.j4.entity.Video;

/**
 * Servlet implementation class Favorite
 */
@WebServlet({"/favorites","/favorites/add", "/favorites/remove"})
public class FavoriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FavoriteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		String uriString = request.getRequestURI();
		if (uriString.contains("add")) {
		    String idString = request.getParameter("id");
		    Integer videoId = Integer.parseInt(idString); 
		    
		    // check xem da like hay chua
		    Favorite existFavorite = FavoriteDAO.findByUserAndVideo(user.getId(), videoId);
		    
		    // 2. neu chua like thi moi them
		    if (existFavorite == null) {
		        Video video = VideoDAO.findById(videoId);
		        
		        Favorite favorite = new Favorite();
		        favorite.setUser(user);
		        favorite.setVideo(video);
		        favorite.setLikeDate(new Date());
		        
		        FavoriteDAO.insert(favorite);
		    }
		    
		    response.sendRedirect(request.getContextPath() + "/favorites");
		    
		} else if (uriString.contains("remove")) { 
		    String idString = request.getParameter("id");
		    Integer favoriteId = Integer.parseInt(idString);
		    FavoriteDAO.delete(favoriteId);
		    
		    response.sendRedirect(request.getContextPath() + "/favorites");
		}
		else {
			user = UserDAO.findById(user.getId());
			List<Favorite> list = FavoriteDAO.findByUser(user.getId());
			request.setAttribute("list", list);
			request.getRequestDispatcher("/views/client/favorite.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
