package com.ObsList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteDestinationServlet")
public class DeleteDestinationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/travel_guide";
    private static final String USER = "root";
    private static final String PASSWORD = "Obslink_19";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);

                PreparedStatement ps = conn.prepareStatement("DELETE FROM to_visit WHERE id = ?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                System.out.println("deleted row");
                conn.close();

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error deleting record: " + e.getMessage());
                return;
            }
        }

        response.sendRedirect("obslist.jsp");
    }
}
