package com.j4.servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.j4.DAO.ShareDAO;
import com.j4.entity.Share;
import com.j4.entity.User;
import com.j4.entity.Video;
import com.j4.util.EmailService;

/**
 * Servlet implementation class ShareServlet
 */
@WebServlet("/share")
public class ShareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShareServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        
        try {
            String emailTo = request.getParameter("email");
            String videoIdStr = request.getParameter("videoId");
            String videoTitle = request.getParameter("videoTitle");
            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if (emailTo != null && videoIdStr != null) {
                // 1. Gửi Email
                String subject = "Vân Lộ: Có người chia sẻ công pháp '" + videoTitle + "' cho bạn!";
                String videoLink = "http://localhost:8080/J4Video/video?id=" + videoIdStr;
                String content = "<div style='background:#111; color:#fff; padding:20px; border:1px solid #f39c12;'>"
                        + "<h2 style='color:#f39c12'>Vân Lộ Các</h2>"
                        + "<p>Chào đạo hữu,</p>"
                        + "<p>Có một vị đạo hữu vừa chia sẻ bộ phim <b>" + videoTitle + "</b> cho bạn.</p>"
                        + "<p>Hãy click vào nút bên dưới để xem ngay:</p>"
                        + "<a href='" + videoLink + "' style='background:#f39c12; color:#000; padding:10px 20px; text-decoration:none; font-weight:bold;'>XEM NGAY</a>"
                        + "<br><br><small>Chúc đạo hữu tu luyện vui vẻ!</small>"
                        + "</div>";

                EmailService.send(emailTo, subject, content);
                
                // 2. Lưu vào Database
                Share share = new Share();
                share.setEmail(emailTo);
                share.setShare_date(new Date()); 
                
                Video video = new Video(); video.setId(Integer.parseInt(videoIdStr));
                share.setVideo(video);
                
                if (user != null) {
                    share.setUser(user);
                }
                
                ShareDAO.insert(share); 
                
                request.setAttribute("message", "Đã gửi thư chia sẻ thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Gửi thất bại: " + e.getMessage());
        }
        
        // Quay lại trang chi tiết video
        String videoId = request.getParameter("videoId");
        request.getRequestDispatcher("/video?id=" + videoId).forward(request, response);
    }
}
