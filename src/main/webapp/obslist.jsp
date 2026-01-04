<%@ page import="java.util.*,java.sql.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
	String userEmail = (String) session.getAttribute("email");

	// Check for login cookie if session is null
	   if (username == null || userEmail == null) {
	       Cookie[] cookies = request.getCookies();
	       if (cookies != null) {
	           for (Cookie cookie : cookies) {
	               if ("userEmail".equals(cookie.getName())) {
					   System.out.println("Cookie found: " + cookie.getName() + "=" + cookie.getValue());
	                   userEmail = cookie.getValue();

	                   // Fetch user details from the database
	                   try {
	                       Class.forName("com.mysql.cj.jdbc.Driver");
	                       Connection conn = DriverManager.getConnection("//database url,host,name e.g jdbc:mysql://127.0.0.1:9999/example", "root", "Obslink_19");

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
	                       }

	                       conn.close();
	                   } catch (Exception e) {
	                       e.printStackTrace();
	                   }
	               }
	           }
	       }
	   }

	   // Redirect to login if no session or cookie is found
	   if (username == null || userEmail == null) {
	       response.sendRedirect("login.jsp");
	       return;
	   }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ObsList</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" >
    <link rel="stylesheet" href="css/style.css" >
</head>
<body>

<section class="header">
    <a href="home.html" class="logo">ObsList</a>
<nav class="navbar">
    <a href="home.jsp">home</a>
    <a href="about.jsp">about</a>
    <a href="packages.jsp">package</a>
    
    <b><span style="color: #8e448e; font-size:1.5rem ; margin-left: 15px; ">Welcome, <%= username %>!</span></b>

    <form action="logout" method="post" style="display:inline; margin-left: 10px;">
        <button type="submit"
            style="background:red; color:white; border:none; padding:5px 12px; border-radius:5px;">
            Logout
        </button>
    </form>
</nav>

    <div id="menu-btn" class="fas fa-bars"></div>
</section>

<div class="heading" style="background: url('Images/web1 (19).jpg') no-repeat">
    <h1>Welcome to ObsList</h1>
</div>

<section class="obslist">
    <div class="todo-container">
        <h2>ObsList</h2>
        <div class="form">
            <form method="post" action="AddDestinationServlet"> 
                <input type="text" name="place" placeholder="Place" required />
                <input type="text" name="location" placeholder="Location" required />
                <select name="type" required>
                    <option value="">Type</option>
                    <option>Beach</option>
                    <option>Mountain</option>
                    <option>Historical</option>
                </select>
                <input type="month" name="visit" required />
                <select name="status" required>
                    <option value="">Status</option>
                    <option>Pending</option>
                    <option>Planned</option>
                    <option>Visited</option>
                    <option>Cancelled</option>
                </select>
                <button type="submit">Save</button>
            </form>
        </div>

        <table class="Table">
            <thead>
                <tr>
                    <th>Place</th>
                    <th>Location</th>
                    <th>Type</th>
                    <th>Possible Visit</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                // Example: Fetch data from DB (replace with real logic)
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                	
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/travel_guide", "root", "Obslink_19");

                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM to_visit WHERE user_email = ?");
                    ps.setString(1, userEmail);
                    rs = ps.executeQuery();
                    
                    while (rs.next()) {
        %>
		
		<tr data-id="<%= rs.getInt("id") %>">
		    <td class="editable" data-field="place_name"><%= rs.getString("place_name") %></td>
		    <td class="editable" data-field="location"><%= rs.getString("location") %></td>
		    <td class="editable" data-field="type"><%= rs.getString("type") %></td>
		    <td class="editable" data-field="visit_date"><%= rs.getString("visit_date") %></td>
		    <td class="editable" data-field="status"><%= rs.getString("status") %></td>
		    <td class="actions">
		        <button class="edit-btn"><i class="fas fa-edit"></i> Edit</button>
				<button class="delete-btn" data-id="<%= rs.getInt("id") %>"><i class="fas fa-trash"></i> Delete</button>
				
		    </td>
		</tr>
		<%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error loading data</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
            </tbody>
        </table>
    </div>
</section>

<section class="footer">
    <div class="box-container">
        <div class="box">
            <h3>quick links</h3>
            <a href="home.jsp"><i class="fas fa-angle-right"></i> home</a>
            <a href="about.jsp"><i class="fas fa-angle-right"></i> about</a>
            <a href="package.jsp"><i class="fas fa-angle-right"></i> package</a>
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
            <a href="#"><i class="fas fa-map"></i> lahore, Pakistan - 54000</a>
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

<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="js/script.js"></script>

<script>
	// yaad seh if edited then reload the previous data.
document.addEventListener("DOMContentLoaded", function() {
    console.log("DOM loaded, binding edit and delete buttons");
    
    // Log context path for debugging
    const contextPath = window.location.pathname.split('/')[1];
    console.log("Application context path:", contextPath);
    
	const originalValues = {};
	   
	   // Attach event listeners to all edit buttons
	   document.querySelectorAll('.edit-btn').forEach(button => {
	       button.addEventListener('click', function() {
	           console.log("Edit button clicked");
	           const row = this.closest('tr');
	           const id = row.getAttribute('data-id');
	           const cells = row.querySelectorAll('.editable');
	           const isEditing = this.innerHTML.includes("Save");

	           if (isEditing) {
	               // Save changes
	               console.log("Saving changes for row ID:", id);
	               const updatedData = {
	                   id: id
	               };

	               cells.forEach(cell => {
	                   cell.contentEditable = false;
	                   cell.classList.remove('editing');
					   cell.style.caretColor = "";
					   const field = cell.getAttribute('data-field');
	                   
	                   // If it's a select element inside the cell
	                   const select = cell.querySelector('select');
	                   if (select) {
	                       updatedData[field] = select.value;
	                       cell.textContent = select.value; // Replace select with text
	                   } else {
	                       updatedData[field] = cell.textContent.trim();
	                   }
	               });

	               // Send data to server using the edit REST API
	               console.log("Sending data to server:", updatedData);
	               
	               // Use the new edit-specific endpoint
	               fetch((contextPath ? '/' + contextPath : '') + '/api/edit/' + id, {
	                   method: 'PUT',  // RESTful PUT for updates
	                   headers: {
	                       'Content-Type': 'application/json'
	                   },
	                   body: JSON.stringify(updatedData)
	               })
	               .then(res => res.text())
	               .then(response => {
	                   console.log("Server response:", response);
	                   if (response === 'success') {
	                       showNotification('Updated successfully', 'success');
	                   } else {
	                       // Restore original values on failure
	                       restoreOriginalValues(row, id);
	                       showNotification('Update failed', 'error');
	                   }
	               })
	               .catch(error => {
	                   console.error("Update error:", error);
	                   // Restore original values on error
	                   restoreOriginalValues(row, id);
	                   showNotification('Update failed', 'error');
	               });

	               this.innerHTML = '<i class="fas fa-edit"></i> Edit';
	           } else {
	               // Enable editing - STORE ORIGINAL VALUES FIRST
	               console.log("Enabling edit mode for row ID:", id);
	               
	               // Store original values before editing
	               originalValues[id] = {};
	               cells.forEach(cell => {
	                   const field = cell.getAttribute('data-field');
	                   originalValues[id][field] = cell.textContent.trim();
	               });
	               
	               cells.forEach(cell => {
	                   cell.contentEditable = true;
	                   cell.classList.add('editing');
					   cell.style.caretColor = "#8e448e";

					   
	                   // Special handling for type field
	                   if (cell.getAttribute('data-field') === 'type') {
	                       const currentType = cell.textContent.trim();
	                       const types = ["Beach", "Mountain", "Historical"];
	                       createSelectInCell(cell, types, currentType);
	                   }
	                   
	                   // Special handling for status field
	                   if (cell.getAttribute('data-field') === 'status') {
	                       const currentStatus = cell.textContent.trim();
	                       const statuses = ["Pending", "Planned", "Visited", "Cancelled"];
	                       createSelectInCell(cell, statuses, currentStatus);
	                   }
	               });
	               
	               this.innerHTML = '<i class="fas fa-save"></i> Save';
	           }
	       });
	   });
	   
	   // Function to restore original values
	   function restoreOriginalValues(row, id) {
	       if (originalValues[id]) {
	           console.log("Restoring original values for row ID:", id);
	           const cells = row.querySelectorAll('.editable');
	           cells.forEach(cell => {
	               const field = cell.getAttribute('data-field');
	               if (originalValues[id][field]) {
	                   cell.textContent = originalValues[id][field];
	               }
	           });
	       }
	   }
	  	    
    // Attach event listeners to delete buttons
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            const row = this.closest('tr');
            
            if (confirm('Are you sure you want to delete this item?')) {
                console.log("Deleting row ID:", id);
                
                // Use the new delete-specific endpoint
                fetch((contextPath ? '/' + contextPath : '') + '/api/delete/' + id, {
                    method: 'DELETE'  // RESTful DELETE operation
                })
                .then(res => res.text())
                .then(response => {
                    console.log("Server response:", response);
                    if (response === 'success') {
                        // Remove the row from the UI
                        row.remove();
                        showNotification('Item deleted successfully', 'success');
                    } else {
                        showNotification('Delete failed', 'error');
                    }
                })
                .catch(error => {
                    console.error("Delete error:", error);
                    showNotification('Delete failed: ' + error.message, 'error');
                });
            }
        });
    });
    
    function createSelectInCell(cell, options, currentValue) {
        const select = document.createElement("select");
        options.forEach(option => {
            const optionEl = document.createElement("option");
            optionEl.value = option;
            optionEl.text = option;
            if (option === currentValue) {
                optionEl.selected = true;
            }
            select.appendChild(optionEl);
        });
        
        cell.textContent = '';
        cell.appendChild(select);
        cell.contentEditable = false; // Disable contentEditable when using select
    }
});

function showNotification(message, type) {
    console.log("Notification:", message, type);
    
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    document.body.appendChild(notification);
    
    // Add styles directly to the element
    Object.assign(notification.style, {
        position: 'fixed',
        top: '20px',
        right: '20px',
        padding: '15px 20px',
        borderRadius: '4px',
        color: 'white',
        fontSize: '1.4rem',
        zIndex: '1000',
        opacity: '0',
        transform: 'translateY(-20px)',
        transition: 'all 0.3s ease',
        backgroundColor: type === 'success' ? '#4CAF50' : '#F44336'
    });
    
    // Show notification
    setTimeout(() => {
        notification.style.opacity = '1';
        notification.style.transform = 'translateY(0)';
    }, 10);
    
    // Hide and remove notification
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transform = 'translateY(-20px)';
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, 3000);
}
</script>

</body>



</html>
