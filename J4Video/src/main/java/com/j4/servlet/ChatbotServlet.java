package com.j4.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.j4.DAO.VideoDAO;
import com.j4.entity.Video;
import com.j4.util.GeminiService;

@WebServlet("/api/chat")
public class ChatbotServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public ChatbotServlet() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("API Chatbot Tiểu Vân AI is running...");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // dung reader de doc cau hoi cua user
            BufferedReader reader = request.getReader();
            Gson gson = new Gson();
            JsonObject jsonRequest = gson.fromJson(reader, JsonObject.class);
            
            if (jsonRequest == null || !jsonRequest.has("message")) {
                response.getWriter().write("{\"response\": \"Hãy gửi tin nhắn cho Tiểu Vân nhé.\"}");
                return;
            }

            String userMessage = jsonRequest.get("message").getAsString();

           
            long totalMovies = VideoDAO.count();
            List<Video> topViewed = VideoDAO.findTop10BestViews();
            List<Video> topLiked = VideoDAO.findTop10MostLiked();

            
            StringBuilder dbContext = new StringBuilder();
            dbContext.append("DỮ LIỆU CỦA WEBSITE VÂN LỘ HIỆN TẠI:\n");
            dbContext.append("- Tổng số phim đang có: ").append(totalMovies).append(" bộ phim.\n");
            
            dbContext.append("- Top 5 phim xem nhiều nhất: ");
            for(int i = 0; i < Math.min(topViewed.size(), 5); i++) {
                dbContext.append(topViewed.get(i).getTitle()).append(" (").append(topViewed.get(i).getView_count()).append(" view), ");
            }
            dbContext.append("\n");

            dbContext.append("- Top 5 phim được yêu thích nhất (thêm vào mục yêu thích): ");
            for(int i = 0; i < Math.min(topLiked.size(), 5); i++) {
                dbContext.append(topLiked.get(i).getTitle()).append(", ");
            }
            dbContext.append("\n");

            // tao promt
            String systemPrompt = "Bạn là 'Tiểu Vân AI', một nữ trợ lý ảo dễ thương, thông minh trên trang web xem phim tiên hiệp mang tên 'Vân Lộ'. "
                    + "Hãy xưng hô là 'Tiểu Vân' và gọi người dùng là 'đạo hữu' hoặc 'bạn'.\n\n"
                    + "QUY TẮC TRẢ LỜI:\n"
                    + "1. Nếu người hỏi về thông tin website (số lượng phim, phim nào hot, phim nhiều lượt xem...), BẮT BUỘC phải dựa vào dữ liệu sau đây để trả lời chính xác: \n" 
                    + dbContext.toString() + "\n"
                    + "2. Nếu người dùng hỏi về cốt truyện, nhân vật, đạo diễn của một bộ phim cụ thể (bất kể phim đó có trong dữ liệu trên hay không), hãy dùng kiến thức sâu rộng của bạn trên Internet để trả lời thật cuốn hút, chi tiết.\n"
                    + "3. Trả lời định dạng văn bản bình thường, rõ ràng, thân thiện.\n\n"
                    + "Câu hỏi của đạo hữu: " + userMessage;

            // goi api
            String aiResponse = GeminiService.getResponse(systemPrompt);

            // tra ve giao dien cho js
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("response", aiResponse);
            response.getWriter().write(gson.toJson(jsonResponse));

        } catch (Exception e) {
            e.printStackTrace();
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("response", "Tiểu Vân đang bị tẩu hỏa nhập ma (Lỗi Server), đạo hữu vui lòng quay lại sau nhé!");
            response.getWriter().write(new Gson().toJson(errorResponse));
        }
    }
}