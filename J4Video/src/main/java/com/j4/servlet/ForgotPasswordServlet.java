package com.j4.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.j4.DAO.UserDAO;
import com.j4.entity.User;
import com.j4.util.EmailService;

import java.util.Random;

/**
 * Servlet implementation class ForgotPasswordServlet
 */
@WebServlet("/forgotpassword")
public class ForgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/views/client/forgot-password.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("sendOTP".equals(action)) {
            // --- BƯỚC 1: XỬ LÝ GỬI OTP ---
            String email = request.getParameter("email");
            User user = UserDAO.findByEmail(email);

            if (user == null) {
                request.setAttribute("error", "Email này chưa được đăng ký!");
                request.getRequestDispatcher("/views/client/forgot-password.jsp").forward(request, response);
            } else {
                // Tạo mã OTP 6 số ngẫu nhiên
                int otpValue = new Random().nextInt(900000) + 100000;
                
                try {
                    // Gửi Email
                    String subject = "Mã xác thực quên mật khẩu - J4Video";
                    String body = "<h3>Xin chào " + user.getFullName() + "!</h3>"
                                + "<p>Bạn vừa yêu cầu lấy lại mật khẩu.</p>"
                                + "<p>Mã OTP của bạn là: <b style='color:red; font-size:20px;'>" + otpValue + "</b></p>"
                                + "<p>Mã này sẽ hết hiệu lực sau 5 phút.</p>";
                    
                    EmailService.send(email, subject, body);
                    
                    // Lưu OTP và Email vào Session để kiểm tra ở bước sau
                    session.setAttribute("otpCode", String.valueOf(otpValue));
                    session.setAttribute("resetEmail", email);
                    session.setAttribute("otpTime", System.currentTimeMillis()); // Lưu thời gian để check hết hạn (nếu muốn)

                    // Chuyển sang trang nhập OTP
                    request.getRequestDispatcher("/views/client/verify-otp.jsp").forward(request, response);

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Lỗi gửi mail: " + e.getMessage());
                    request.getRequestDispatcher("/views/client/forgot-password.jsp").forward(request, response);
                }
            }

        } else if ("verifyOTP".equals(action)) {
            // --- BƯỚC 2: XÁC THỰC OTP VÀ ĐỔI PASS ---
            String enteredOtp = request.getParameter("otp");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            String sessionOtp = (String) session.getAttribute("otpCode");
            String email = (String) session.getAttribute("resetEmail");

            // Kiểm tra OTP
            if (sessionOtp == null || !sessionOtp.equals(enteredOtp)) {
                request.setAttribute("error", "Mã OTP không chính xác!");
                request.getRequestDispatcher("/views/client/verify-otp.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu trùng khớp
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("/views/client/verify-otp.jsp").forward(request, response);
                return;
            }

            // Thực hiện đổi mật khẩu
            try {
                User user = UserDAO.findByEmail(email);
                if (user != null) {
                    user.setPassword(newPassword);
                    UserDAO.updadte(user); // Dùng hàm update (lưu ý chính tả trong file DAO của bạn)
                    
                    // Xóa session OTP để bảo mật
                    session.removeAttribute("otpCode");
                    session.removeAttribute("resetEmail");
                    session.removeAttribute("otpTime");

                    request.setAttribute("message", "Đổi mật khẩu thành công! Hãy đăng nhập lại.");
                    request.getRequestDispatcher("/views/client/login.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
