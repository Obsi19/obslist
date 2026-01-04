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
                        //add your database values 
                        Connection conn = DriverManager.getConnection(//database url,host,name e.g "jdbc:mysql://127.0.0.1:9999/example", "root", "Obslink_19");

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
    <title>Home</title>

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

<!-- header section ends here -->

<!-- home section starts here -->
<section class="home">
    <div class="swiper home-slider">
        <div class="swiper-wrapper">
            <div class="swiper-slide slide" style="background: url(Images/img-3.jpg) no-repeat">
                <div class="content">
                    <span>Explore, Discover, Travel</span>
                    <h3>Travel Around The World</h3>
                    <a href="packages.jsp" class="btn">Discover More</a>
                </div>
            </div>
  
            <div class="swiper-slide slide" style="background: url(Images/j.jpg) no-repeat">
                <div class="content">
                    <span>Explore, Discover, Travel</span>
                    <h3>Discover New PLaces</h3>
                    <a href="packages.jsp" class="btn">Discover More</a>
                </div>
            </div>

            <div class="swiper-slide slide" style="background: url(Images/img-6.jpg) no-repeat">
                <div class="content">
                    <span>Explore, Discover, Travel</span>
                    <h3>Make Your Tour Worth While</h3>
                    <a href="packages.jsp" class="btn">Discover More</a>
                </div>
            </div>
        </div>

        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>
</section>

<!-- home section ends here -->

<!-- services section start here  -->
<section class="services">
    <h1 class="heading-title"> our services </h1>

    <div class="box-container">
        <div class="box">
            <img src="Images/adventure.png" alt="">
            <h3>Adventure</h3>
        </div>

        <div class="box">
            <img src="Images/guide.png" alt="">
            <h3>Tour Guide</h3>
        </div>

        <div class="box">
            <img src="Images/offroad.png" alt="">
            <h3>Off Road</h3>
        </div>

        <div class="box">
            <img src="Images/hiking.png" alt="">
            <h3>Trekking</h3>
        </div>

        <div class="box">
            <img src="Images/campfire.png" alt="">
            <h3>Camp Fire</h3>
        </div>
        <div class="box">
            <img src="Images/rafting.png" alt="">
            <h3>Rafting</h3>
        </div>
        <div class="box">
            <img src="Images/stargazing.png" alt="">
            <h3>stargazing</h3>
        </div>
        <div class="box">
            <img src="Images/attractions.png" alt="">
            <h3>attractions</h3>
        </div>
        <div class="box">
            <img src="Images/paragliding.png" alt="">
            <h3>paragliding</h3>
        </div>
        <div class="box">
            <img src="Images/lounge.png" alt="">
            <h3>lounging</h3>
        </div>
    </div>   
</section>
<!-- services section ends here -->

<!-- home about section starts here  -->
<section class="home-about">
    <div class="image">
        <img src="Images/web1 (23).jpg" alt="">
    </div>

    <div class="content">
        <h3>About Us</h3>
        <p>We are Obslink19, a travel agency dedicated to providing unforgettable experiences and adventures. Our team of experts is passionate about exploring the world and sharing it with you. We offer a wide range of travel packages, from relaxing beach getaways to thrilling mountain treks</p>
        <a href="about.jsp" class="btn">Read More</a>
    </div>
</section>
<!-- home about section ends here  -->

<!-- home packages section starts here -->
<section class="home-packages">
    <h1 class="heading-title"> our packages </h1>

    <div class="box-container">
        <div class="box">
            <div class="image">
                <img src="Images/img-1.jpg" alt="">
            </div>
            <div class="content">
                <h3>Adventure</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. </p>
                <% if (!isLoggedIn) { %>
                    <a href="login.jsp" class="btn">Book Now</a>
                <% } else { %>
                    <a href="obslist.jsp" class="btn">Add to ObsList</a>
                <% } %>
            </div>
        </div>

        <div class="box">
            <div class="image">
                <img src="Images/img-2.jpg" alt="">
            </div>
            <div class="content">
                <h3>Tour Guide</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit</p>
                <% if (!isLoggedIn) { %>
                    <a href="login.jsp" class="btn">Book Now</a>
                <% } else { %>
                    <a href="obslist.jsp" class="btn">Add to ObsList</a>
                <% } %>
            </div>
        </div>

        <div class="box">
            <div class="image">
                <img src="Images/img-3.jpg" alt="">
            </div>
            <div class="content">
                <h3>Off Road</h3>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                <% if (!isLoggedIn) { %>
                    <a href="login.jsp" class="btn">Book Now</a>
                <% } else { %>
                    <a href="obslist.jsp" class="btn">Add to ObsList</a>
                <% } %>
            </div>
        </div>
    </div>

    <div class="load-more">
        <a href="packages.jsp" class="btn">Load More</a>
    </div>
</section>
<!-- home packages section ends here -->

<!-- home offer section starts here -->
<section class="home-offer">
    <div class="content">
        <h3>up to 50% off</h3>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatibus.</p>
        <% if (!isLoggedIn) { %>
            <a href="login.jsp" class="btn">Book Now</a>
        <% } else { %>
            <a href="obslist.jsp" class="btn">Add to ObsList</a>
        <% } %>
    </div>
</section>
<!-- home offer section ends here -->

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
