<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page session="true" %>
<%
    // Check if the user is already logged in via session
    String username = (String) session.getAttribute("username");
    String userEmail = (String) session.getAttribute("email");

    // If session attributes are null, check for the login cookie
    if (username == null || userEmail == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    userEmail = cookie.getValue();

                    // Fetch user details from the database
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/travel_guide", "root", "Obslink_19");

                        PreparedStatement ps = conn.prepareStatement("SELECT first_name, last_name FROM users WHERE email = ?");
                        ps.setString(1, userEmail);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            username = firstName + " " + lastName;

                            // Set session attributes
                            session.setAttribute("username", username);
                            session.setAttribute("email", userEmail);

                            // Forward to obslist.jsp
                            response.sendRedirect("obslist.jsp");
                            return;
                        }

                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    // If no session or cookie is found, continue to the login page
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
<!-- Header -->
<section class="header">
    <a href="home.html" class="logo">ObsList</a>
    <nav class="navbar">
        <a href="home.jsp">home</a>
        <a href="about.jsp">about</a>
        <a href="packages.jsp">package</a>
        <a href="register.jsp">register</a>
    </nav>
    <div id="menu-btn" class="fas fa-bars"></div>
</section>

<!-- Hero -->
<div class="heading" style="background: url('Images/web1 (11).jpg') no-repeat">
    <h1>Welcome to ObsList</h1>
</div>

<!-- Login Section -->
<section class="login">
    <p>Login to your account</p>
    <form action="Login" method="post" class="login-form">

        <div class="flex">
            <div class="inputbox">
                <span>Email: </span>
                <input type="email" placeholder="Enter your email" name="email" required>
            </div>
            
            <div class="inputbox">
                <span>Password: </span>
                <input type="password" placeholder="Enter your password" name="password" required>
            </div>
        </div>

        <div class="flex">
            <input type="submit" value="Submit" class="btn" name="submit">
            <p>Don't have an account? <a href="register.jsp">Register Now</a></p>
            <p>Forgot Password? <a href="register.jsp">Reset Now</a></p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <p style="color:red;"><%= request.getAttribute("error") %></p>
        <% } %>

    </form>
</section>

<!-- Footer -->
<section class="footer">
    <div class="box-container">
        <div class="box">
            <h3>quick links</h3>
            <a href="home.jsp"><i class="fas fa-angle-right"></i> home </a>
            <a href="about.jsp"><i class="fas fa-angle-right"></i> about </a>
            <a href="package.jsp"><i class="fas fa-angle-right"></i> package </a>
            <a href="login.jsp"><i class="fas fa-angle-right"></i> login </a>
        </div>

        <div class="box">
            <h3>extra links</h3>
            <a href="#"><i class="fas fa-angle-right"></i> ask questions</a>
            <a href="#"><i class="fas fa-angle-right"></i> about us</a>
            <a href="#"><i class="fas fa-angle-right"></i> privacy policy</a>
            <a href="#"><i class="fas fa-angle-right"></i> terms of use</a>
        </div>

        <div class="box">
            <h3>Contact Info</h3>
            <a href="#"><i class="fas fa-phone"></i> +92-309-7220811</a>
            <a href="#"><i class="fas fa-phone"></i> +92-310-1230987</a>
            <a href="#"><i class="fas fa-envelope"></i> Obslink19@gmail.com</a>
            <a href="#"><i class="fas fa-map"></i> Lahore, Pakistan - 54000</a>
        </div>

        <div class="box">
            <h3>Follow Us</h3>
            <a href="#"><i class="fab fa-facebook-f"></i> facebook</a>
            <a href="#"><i class="fab fa-twitter"></i> twitter</a>
            <a href="#"><i class="fab fa-instagram"></i> instagram</a>
            <a href="#"><i class="fab fa-linkedin"></i> linkedin</a>
        </div>
    </div>

    <div class="credit">
        &copy; copyright @ 2025 by <span>Obslink19</span> | all rights reserved!
    </div>
</section>

<!-- JS Scripts -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="js/script.js"></script>

</body>
</html>
