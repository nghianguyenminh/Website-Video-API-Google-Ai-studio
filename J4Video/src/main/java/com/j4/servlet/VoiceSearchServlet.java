package com.j4.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.j4.DAO.VideoDAO;

@WebServlet("/api/voice-search")
public class VoiceSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String API_KEY = "AIzaSyAbG9rxYyfeIs-e_SxnUTf_b3G6r3Zi-mA";
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + API_KEY;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // 1. Nhận chuỗi văn bản nhận diện từ trình duyệt
            BufferedReader reader = request.getReader();
            Gson gson = new Gson();
            JsonObject jsonRequest = gson.fromJson(reader, JsonObject.class);
            
            if (jsonRequest == null || !jsonRequest.has("transcript")) {
                response.getWriter().write("{\"keyword\": \"\"}");
                return;
            }

            String transcript = jsonRequest.get("transcript").getAsString();

            // lay list phim ne
            List<String> movieTitles = VideoDAO.getAllMovieTitles();
            String titlesStr = String.join(", ", movieTitles);

            // viet promt 
            String prompt = "Người dùng tìm kiếm bằng giọng nói với câu: '" + transcript + "'.\n"
                          + "Danh sách các phim trên web: " + titlesStr + ".\n"
                          + "Nhiệm vụ: Hãy trích xuất và trả về ĐÚNG TÊN PHIM mà họ muốn tìm. "
                          + "Ví dụ: 'Mở cho tôi phim phàm nhân tu tiên tập 1' -> Trả về: 'Phàm Nhân Tu Tiên'. "
                          + "Nếu nhận diện giọng nói bị sai chính tả (VD: 'tiền nghịch' -> 'Tiên Nghịch'), hãy tự sửa lại cho đúng danh sách. "
                          + "Nếu không có phim nào khớp, trả về từ khóa cốt lõi ngắn gọn nhất. "
                          + "QUY TẮC TỐI THƯỢNG: CHỈ TRẢ VỀ DUY NHẤT TỪ KHÓA, KHÔNG GIẢI THÍCH, KHÔNG XUỐNG DÒNG, KHÔNG DẤU NGOẶC KÉP.";

            
            String aiKeyword = getGeminiKeyword(prompt);
            
           // clear input va trim()
            aiKeyword = aiKeyword.replaceAll("^\"|\"$", "").trim();

         // tra ve giao dien
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("keyword", aiKeyword);
            response.getWriter().write(gson.toJson(jsonResponse));

        } catch (Exception e) {
            e.printStackTrace();
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("keyword", "");
            response.getWriter().write(new Gson().toJson(errorResponse));
        }
    }

   // ham goi api 
    private String getGeminiKeyword(String prompt) {
        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            JsonObject textPart = new JsonObject();
            textPart.addProperty("text", prompt);
            JsonArray partsArray = new JsonArray();
            partsArray.add(textPart);
            JsonObject contentObj = new JsonObject();
            contentObj.add("parts", partsArray);
            JsonArray contentsArray = new JsonArray();
            contentsArray.add(contentObj);
            JsonObject requestBody = new JsonObject();
            requestBody.add("contents", contentsArray);

            Gson gson = new Gson();
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = gson.toJson(requestBody).getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            if (conn.getResponseCode() == 200) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) response.append(line.trim());
                
                JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
                return jsonResponse.getAsJsonArray("candidates").get(0).getAsJsonObject()
                        .getAsJsonObject("content").getAsJsonArray("parts").get(0).getAsJsonObject()
                        .get("text").getAsString();
            }
            return "";
        } catch (Exception e) {
            return "";
        }
    }
}