package com.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class Logout extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // don't create new session
        if (session != null) {
            session.removeAttribute("username");
            session.removeAttribute("email");
            session.invalidate(); // destroys the session fully
        }

        Cookie logincookie	= new Cookie("userEmail","");
        logincookie	.setMaxAge(0);
        response.addCookie(logincookie);
        
        
        response.sendRedirect("login.jsp");
    }
}
