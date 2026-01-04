package com.ObsList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/AddDestinationServlet")
public class AddDestinationServlet extends HttpServlet {

    
	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "";
    private static final String USER = "";
    private static final String PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get session and validate login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("email");

        // Retrieve form inputs
        String place = request.getParameter("place");
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        String visitDate = request.getParameter("visit"); // expected format: YYYY-MM
        String status = request.getParameter("status");

        // Convert YYYY-MM to YYYY-MM-01 for MySQL DATE format
        if (visitDate != null && !visitDate.isEmpty()) {
            visitDate += "-01";
        }

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);

            String sql = "INSERT INTO to_visit (user_email, place_name, location, type, visit_date, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userEmail);
            ps.setString(2, place);
            ps.setString(3, location);
            ps.setString(4, type);
            ps.setString(5, visitDate);
            ps.setString(6, status);

            ps.executeUpdate();
            System.out.println("added row");
            conn.close();

           
            response.sendRedirect("obslist.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error adding destination: " + e.getMessage());
        }
    }
}
