package com.login;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.Cookie;


import java.io.IOException;
import java.sql.*;

@WebServlet("/Login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/travel_guide";
    private static final String USER = "root";
    private static final String PASSWORD = "Obslink_19";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt with email: " + email + " and password: " + password);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);

            String sql = "SELECT first_name,last_name FROM users WHERE email = ? AND password = ?";
            System.out.println("SQL Query: " + sql);

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String fullName = firstName + " " + lastName;
                System.out.println("User found: " + fullName);

                System.out.println("redirecting to next page");
                HttpSession session = request.getSession();
                session.setAttribute("username", fullName);
                session.setAttribute("email", email);
                
             // Set a cookie for persistent login
                Cookie loginCookie = new Cookie("userEmail", email);
                loginCookie.setMaxAge(12 * 60 * 60); // 12 hours in seconds
                response.addCookie(loginCookie);
                System.out.println("Cookie created: userEmail=" + email);

                // Forward to obslist.jsp using RequestDispatcher
                RequestDispatcher dispatcher = request.getRequestDispatcher("obslist.jsp");
                dispatcher.forward(request, response);
                
            } else {
                System.out.println("No matching user found.");
                request.setAttribute("error", "Invalid email or password.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }

            conn.close();
        } catch (Exception e) {
            System.out.println("Exception during login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
    // Optionally override doGet if needed (can forward to login.jsp)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        response.sendRedirect("login.jsp");
    }
}
