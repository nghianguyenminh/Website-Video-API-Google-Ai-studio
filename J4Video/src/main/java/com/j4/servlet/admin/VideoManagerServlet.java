package com.j4.servlet.admin;

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
 * Servlet implementation class VideoManagerServlet
 */
@WebServlet({ "/admin/videos", "/admin/videos/add", "/admin/videos/edit", "/admin/videos/delete" })
public class VideoManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VideoManagerServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
	    String uri = request.getRequestURI();
	    String keyword = request.getParameter("keyword");
		
		if (uri.contains("add")) {
			request.setAttribute("categories", CategoryDAO.findAll());
			request.getRequestDispatcher("/views/admin/videos/add.jsp").forward(request, response);
		} else if (uri.contains("edit")) {

			String idStr = request.getParameter("id");
			if (idStr != null) {
				Integer id = Integer.parseInt(idStr);
				Video video = VideoDAO.findById(id);
				request.setAttribute("video", video); 
				request.setAttribute("categories", CategoryDAO.findAll());
				request.getRequestDispatcher("/views/admin/videos/edit.jsp").forward(request, response);
			}

		} else if (uri.contains("delete")) {

			String idStr = request.getParameter("id");
			if (idStr != null) {
				Integer id = Integer.parseInt(idStr);
				VideoDAO.delete(id);
			}
			response.sendRedirect(request.getContextPath() + "/admin/videos");
		} else {

			
			List<Video> list;
	        if (keyword != null && !keyword.trim().isEmpty()) {
	            list = VideoDAO.findByKeyword(keyword); 
	        } else {
	            list = VideoDAO.findAll();
	        }
	        request.setAttribute("list", list);
	        request.getRequestDispatcher("/views/admin/videos/list.jsp").forward(request, response);
			
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String uriString = request.getRequestURI();

		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String poster = request.getParameter("poster");
		String youtube_id = request.getParameter("youtube_id");
		String categoryIdStr = request.getParameter("categoryId");
	    Category category = null;
	    if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
	        category = CategoryDAO.findById(Integer.parseInt(categoryIdStr));
	    }
	    String schedule = request.getParameter("schedule");
	    

		if (uriString.contains("add")) {
			Video video = new Video();
			video.setTitle(title);
			video.setDescription(description);
			video.setPoster(poster);
			video.setYoutube_id(youtube_id);
			video.setView_count(0);
			video.setActive(true);
			video.setCategory(category);
			if (schedule != null && !schedule.isEmpty()) {
	            video.setSchedule(schedule);
	        }
			int rs = VideoDAO.insert(video);
			if (rs == 1) {
				request.setAttribute("message", "Thêm Mới Thành Công");
			} else {
				request.setAttribute("error", "Thêm Mới Thất Bại");
			}
			request.getRequestDispatcher("/views/admin/videos/add.jsp").forward(request, response);

		} else if (uriString.contains("edit")) {
			try {
				Integer id = Integer.parseInt(request.getParameter("id"));

				// Tìm video cũ để giữ lại view_count và active (nếu không muốn reset nó)
				Video video = VideoDAO.findById(id);

				// Cập nhật thông tin mới
				video.setTitle(title);
				video.setDescription(description);
				video.setPoster(poster);
				video.setYoutube_id(youtube_id);
				//checkbox
				boolean active = request.getParameter("active") != null; // Checkbox trả về null nếu không chọn
				video.setActive(active);
				video.setCategory(category);
				
				if (schedule != null && !schedule.isEmpty()) {
		            video.setSchedule(schedule);
		        } else {
		        	video.setSchedule(null); // Nếu chọn "Không đặt lịch" thì xóa trong DB
		        }
				int rs = VideoDAO.updadte(video); // Gọi hàm update đã sửa tên

				if (rs == 1) {
					request.setAttribute("message", "Cập nhật thành công");
				} else {
					request.setAttribute("error", "Cập nhật thất bại");
				}

				// Gửi lại video đã sửa để hiện lên form
				request.setAttribute("video", video);
				request.getRequestDispatcher("/views/admin/videos/edit.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
