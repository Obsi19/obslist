<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page session="true" %>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userEmail = (String) session.getAttribute("email");
    boolean isLoggedIn = false;

    // Check for login cookie if session is null
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
                            isLoggedIn = true;
                        }

                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    } else {
        isLoggedIn = true;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About</title>

    <!-- swiper css link -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
 
    <!-- font awesome cdn link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- custom css file link  -->
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<!-- header section starts here -->
<section class="header">
    <a href="home.jsp" class="logo">ObsList</a>

    <nav class="navbar">
        <a href="home.jsp">home</a>
        <a href="about.jsp">about</a>
        <a href="packages.jsp">package</a>
        
        <% if (isLoggedIn) { %>
            <b><span style="color: #8e448e; font-size:1.5rem; margin-left: 15px;">Welcome, <%= username %>!</span></b>
            <a href="obslist.jsp">My ObsList</a>
            <form action="logout" method="post" style="display:inline; margin-left: 10px;">
                <button type="submit" style="background:red; color:white; border:none; padding:5px 12px; border-radius:5px;">
                    Logout
                </button>
            </form>
        <% } else { %>
            <a href="login.jsp">login</a>
        <% } %>
    </nav>
    
    <div id="menu-btn" class="fas fa-bars"></div>
</section>

<!-- heading section ends here -->
<div class="heading" style="background: url('Images/img-5.jpg') no-repeat">
    <h1>About Us </h1>
</div>

<!-- about section starts here -->
<section class="about">
    <div class="image">
        <img src="Images/web1 (16).jpg" alt="">
    </div>
    <div class="content">
        <h3>Why Choose Us?</h3>
        <p>We are a team of passionate travelers and adventure seekers, dedicated to providing you with the best travel experiences. Our mission is to help you explore the world, create unforgettable memories, and discover new cultures.</p>
        <p>With years of experience in the travel industry, we have curated a selection of unique and exciting travel packages that cater to all types of travelers. Whether you're looking for a relaxing beach getaway, an adventurous mountain trek, or a cultural city tour, we have something for everyone.</p>
        <div class="icon-container">
            <div class="icon">
                <i class="fas fa-map"></i>
                <span>Top destinations</span>
            </div>

            <div class="icon">
                <i class="fas fa-hand-holding-usd"></i>
                <span>Affordable prices</span>
            </div>

            <div class="icon">
                <i class="fas fa-headset"></i>
                <span>24/7 guide services</span>
            </div>
        </div>
    </div>
</section>
<!-- about section ends here -->

<!-- footer section starts here -->
<section class="footer">
    <div class="box-container">
        <div class="box">
            <h3>quick links</h3>
            <a href="home.jsp"><i class="fas fa-angle-right"></i> home </a>
            <a href="about.jsp"><i class="fas fa-angle-right"></i> about </a>
            <a href="packages.jsp"><i class="fas fa-angle-right"></i> package </a>
            <% if (!isLoggedIn) { %>
                <a href="login.jsp"><i class="fas fa-angle-right"></i> login </a>
            <% } else { %>
                <a href="obslist.jsp"><i class="fas fa-angle-right"></i> my list </a>
            <% } %>
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
            <a href="#"><i class="fas fa-envelope"></i> Obslink19@gmail.com </a>
            <a href="#"><i class="fas fa-map"></i> lahore, Pakistan - 54000 </a>
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
        &copy; copyright @ 2025 by <span> Obslink19 </span> | all rights reserved!
    </div>
</section>
<!-- footer section ends here -->

<!-- swiper js link -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- custom js file link -->
<script src="js/script.js"></script>

</body>
</html>