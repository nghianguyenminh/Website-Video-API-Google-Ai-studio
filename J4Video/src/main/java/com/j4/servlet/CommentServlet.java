package com.j4.servlet;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.j4.DAO.CommentDAO;
import com.j4.DAO.VideoDAO;
import com.j4.entity.Comment;
import com.j4.entity.User;
import com.j4.entity.Video;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/comment")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
request.setCharacterEncoding("UTF-8");
        
        // chekc login
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String videoIdStr = request.getParameter("videoId");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Integer videoId = Integer.valueOf(videoIdStr); // tao hop chua kien int
            String content = request.getParameter("content");

            if (content != null && !content.trim().isEmpty()) {
                Comment comment = new Comment();
                comment.setContent(content);
                comment.setCommentDate(new Date());
                comment.setUser(user);
                
                Video video = new Video();
                video.setId(videoId);
                comment.setVideo(video);

                // insert DB
                CommentDAO.insert(comment);
            }
            

            response.sendRedirect(request.getContextPath() + "/video?id=" + videoId);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
	}

}
