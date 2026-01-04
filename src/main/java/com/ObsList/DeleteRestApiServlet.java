package com.ObsList;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;


@WebServlet("/api/delete/*")
public class DeleteRestApiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final String DB_URL = "";
    private final String DB_USER = "";
    private final String DB_PASSWORD = "";
    
    /**
     * Handles DELETE requests for removing destinations
     */
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
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
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "DELETE FROM to_visit WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, id);
                    int deleted = ps.executeUpdate();
                    
                    response.setContentType("text/plain");
                    if (deleted > 0) {
                        response.getWriter().write("success");
                    } else {
                        response.getWriter().write("delete_failed");
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
    
    // Also support POST for browsers/clients that don't support DELETE
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doDelete(request, response);
    }
}
