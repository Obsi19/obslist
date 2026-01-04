package com.ObsList;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import org.json.JSONObject;

@WebServlet("/api/edit/*")
public class EditRestApiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final String DB_URL = "jdbc:mysql://127.0.0.1:3306/travel_guide";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "Obslink_19";

    /**
     * Handles PUT requests for updating destinations
     */
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Extract ID from URL path
        String pathInfo = request.getPathInfo();
        String[] pathParts = pathInfo.split("/");
        int id;
        
        try {
            id = Integer.parseInt(pathParts[1]);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid destination ID");
            return;
        }
        
        // Read request body
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        
        try {
            JSONObject data = new JSONObject(sb.toString());
            String place = data.getString("place_name");
            String location = data.getString("location");
            String type = data.getString("type");
            String visitDate = data.getString("visit_date");
            String status = data.getString("status");
            
            // Format date properly for MySQL
            if (visitDate != null && !visitDate.isEmpty()) {
                if (visitDate.length() > 10) {
                    visitDate = visitDate.substring(0, 10);
                }
                if (!visitDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    try {
                        java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("MMM yyyy");
                        java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date date = inputFormat.parse(visitDate);
                        visitDate = outputFormat.format(date);
                    } catch (java.text.ParseException e) {
                        visitDate = "2025-01-01";
                    }
                }
            }
            
            if (place == null || place.isEmpty() || 
                    location == null || location.isEmpty() || 
                    type == null || type.isEmpty() || 
                    status == null || status.isEmpty()) {
                
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("text/plain");
                response.getWriter().write("Error: Missing required fields");
                return;
            }
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE to_visit SET place_name = ?, location = ?, type = ?, visit_date = ?, status = ? WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, place);
                    ps.setString(2, location);
                    ps.setString(3, type);
                    ps.setString(4, visitDate);
                    ps.setString(5, status);
                    ps.setInt(6, id);
                    
                    int updated = ps.executeUpdate();
                    response.setContentType("text/plain");
                    if (updated > 0) {
                        response.getWriter().write("success");
                    } else {
                        response.getWriter().write("update_failed");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("text/plain");
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
    
    // Also support POST for browsers/clients that don't support PUT
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPut(request, response);
    }
}