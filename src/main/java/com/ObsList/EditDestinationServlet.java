package com.ObsList; 

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;



import org.json.JSONObject;

@WebServlet("/EditDestinationServlet")
public class EditDestinationServlet extends HttpServlet  {
    private static final long serialVersionUID = 1L;

    private final String DB_URL = "";
    private final String DB_USER = "";
    private final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;

        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        try {
        	
        	JSONObject data = new JSONObject(sb.toString());
            int id = data.getInt("id");
            String place = data.getString("place_name");
            String location = data.getString("location");
            String type = data.getString("type");
            String visitDate = data.getString("visit_date");
            String status = data.getString("status");
            
            // Format date properly for MySQL
            if (visitDate != null && !visitDate.isEmpty()) {
                // Make sure it's in YYYY-MM-DD format
                if (visitDate.length() > 10) {
                    visitDate = visitDate.substring(0, 10);  // Keep just the YYYY-MM-DD part
                }
                // If it doesn't have proper format, try to fix it
                if (!visitDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    // If it's in another format, attempt to convert it
                    try {
                        java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("MMM yyyy");
                        java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date date = inputFormat.parse(visitDate);
                        visitDate = outputFormat.format(date);
                    } catch (java.text.ParseException e) {
                        // If parsing fails, set a default date
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
            	    PrintWriter out = response.getWriter();
            	    out.print("Error: Missing required fields");
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
                    PrintWriter out = response.getWriter();
                    if (updated > 0) {
                        out.print("success");
                    } else {
                        out.print("update_failed");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            out.print("Error: " + e.getMessage());
        }
    }
}
