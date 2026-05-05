package com.j4.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class GeminiService {
   
 
    private static final String API_KEY = "AIzaSyD74t-GrBRqppZhhzam8fniYBhmXK7efK0"; 
   
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + API_KEY;

    public static String getResponse(String prompt) {
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
            String jsonInputString = gson.toJson(requestBody);

            // Gửi request
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Nhận response
            int responseCode = conn.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            }

            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line.trim());
            }

            
            if (responseCode == 200) {
                JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
                return jsonResponse.getAsJsonArray("candidates")
                        .get(0).getAsJsonObject()
                        .getAsJsonObject("content")
                        .getAsJsonArray("parts")
                        .get(0).getAsJsonObject()
                        .get("text").getAsString();
            } else {
                return "Tiểu Vân đang gặp sự cố kết nối linh lực (Lỗi API): " + responseCode;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Xin lỗi đạo hữu, Tiểu Vân đang bận tu luyện. Vui lòng thử lại sau nhé!";
        }
    }
}