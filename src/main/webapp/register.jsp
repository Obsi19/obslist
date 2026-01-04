<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";
    String today = java.time.LocalDate.now().toString();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("birth");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");

        if (!password.equals(cpassword)) {
            message = "Passwords do not match.";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://127.0.0.1:3306/travel_guide", "root", "Obslink_19");

                PreparedStatement checkUser = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
                checkUser.setString(1, email);
                ResultSet rs = checkUser.executeQuery();

                if (rs.next()) {
                    message = "Email already registered.";
                } else {
                    PreparedStatement insert = conn.prepareStatement(
                            "INSERT INTO users (first_name, last_name, email, phone, dob, address, password) VALUES (?, ?, ?, ?, ?, ?, ?)");

                    insert.setString(1, firstName);
                    insert.setString(2, lastName);
                    insert.setString(3, email);
                    insert.setString(4, phone);
                    insert.setString(5, dob);
                    insert.setString(6, address);
                    insert.setString(7, password); // consider hashing later

                    insert.executeUpdate();
                    conn.close();
                    response.sendRedirect("login.jsp");
                    return;
                }

                conn.close();
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="css/style.css" />
    <script src="js/script.js" defer></script>
</head>
<body>

<section class="header">
    <a href="home.html" class="logo">ObsList</a>
    <nav class="navbar">
        <a href="home.jsp">home</a>
        <a href="about.jsp">about</a>
        <a href="packages.jsp">package</a>
        <a href="login.jsp">login</a>
    </nav>
    <div id="menu-btn" class="fas fa-bars"></div>
</section>

<div class="heading" style="background: url('Images/web1 (24).jpg') no-repeat">
    <h1>Come On</h1>
</div>

<section class="register">
    <h1 class="header-title">Register Yourself</h1>
    <p style="color: red; font-size:large; font-weight: bold; text-align: center;"><%= message %></p>

    <form method="post" class="register-form">
        <div class="flex">
            <div class="inputbox">
                <span>First Name:</span>
                <input type="text" name="firstName" placeholder="Enter your first name"
                       value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>" required>
            </div>
            <div class="inputbox">
                <span>Last Name:</span>
                <input type="text" name="lastName" placeholder="Enter your last name"
                       value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>" required>
            </div>
            <div class="inputbox">
                <span>Email:</span>
                <input type="email" name="email" placeholder="Enter your email"
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required>
            </div>
            <div class="inputbox">
                <span>Phone Number:</span>
                <input type="number" name="phone" placeholder="Enter your phone number"
                       value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>" required>
            </div>
            <div class="inputbox">
                <span>Date of Birth:</span>
                <input type="date" name="birth"
                       value="<%= request.getParameter("birth") != null ? request.getParameter("birth") : "2000-01-01" %>"
                       max="<%= today %>" required>
            </div>
            <div class="inputbox">
                <span>Address:</span>
                <input type="text" name="address" placeholder="Enter your address"
                       value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>" required>
            </div>
            <div class="inputbox">
                <span>Password:</span>
                <input type="password" name="password" placeholder="Enter your Password"
                        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                        title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" 
                        required>              
            </div>
            
            <div class="inputbox">
                <span>Confirm Password:</span>
                <input type="password" name="cpassword" placeholder="Confirm Your Password" required>
            </div>
        </div>
        <input type="submit" value="Submit" class="btn" name="submit">
    </form>
</section>

<section class="footer">
    <div class="box-container">
        <div class="box">
            <h3>quick links</h3>
            <a href="home.jsp"><i class="fas fa-angle-right"></i> home</a>
            <a href="about.jsp"><i class="fas fa-angle-right"></i> about</a>
            <a href="packages.jsp"><i class="fas fa-angle-right"></i> package</a>
            <a href="login.jsp"><i class="fas fa-angle-right"></i> login</a>
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
        &copy; copyright @ 2025 by <span> Obslink19 </span> | all rights reserved!
    </div>
</section>

</body>
</html>
