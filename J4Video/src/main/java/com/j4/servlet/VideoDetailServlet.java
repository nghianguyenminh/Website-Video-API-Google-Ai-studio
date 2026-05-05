package com.j4.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.j4.DAO.VideoDAO;
import com.j4.entity.Video;
import com.j4.DAO.CommentDAO;
import com.j4.entity.Comment;

/**
 * Servlet implementation class VideoDetailServlet
 */
@WebServlet("/video")
public class VideoDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VideoDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String idStr = request.getParameter("id");
        
        if (idStr != null) {
            try {
                Integer id = Integer.parseInt(idStr); //Integer no giong nhu 1 cai hop so nguyen trong de luu data vao, con int la du lieu nguyen thuy
                
                VideoDAO.incrementViewCount(id);
                Video video = VideoDAO.findById(id);
                
                if (video != null) {
                    request.setAttribute("video", video);
                    
                    List<Video> relatedVideos = VideoDAO.findTopViews(7);
                    request.setAttribute("relatedVideos", relatedVideos);
                    
                    List<Comment> comments = CommentDAO.findByVideoId(id);
                    request.setAttribute("comments", comments);
                    // ---------------------------------------------
                    
                    request.getRequestDispatcher("/views/client/video-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
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
