# 🌍 ObsList - Travel Destination Bucket List Manager

<p align="center">
  <img src="src/main/webapp/Images/web1%20(11).jpg" alt="ObsList Banner" width="100%">
</p>

**ObsList** is a full-stack Java web application that helps users create and manage their travel bucket list. Built using **Java Servlets**, **JSP**, **AJAX**, **Sessions**, **Cookies**, and **MySQL**, this project demonstrates a complete MVC architecture with a modern, responsive UI.

---

## 📸 Project Screenshots

### 🏠 Home Page
<p align="center">
  <img src="src/main/webapp/Images/img-3.jpg" alt="Home Page Slider" width="80%">
</p>

*Beautiful image slider showcasing travel destinations with Swiper.js integration*

### 📦 Travel Packages
<p align="center">
  <img src="src/main/webapp/Images/web1%20(17).jpg" alt="Packages" width="80%">
</p>

*Browse and explore various travel packages*

### 🔐 Login Page
<p align="center">
  <img src="src/main/webapp/Images/web1%20(11).jpg" alt="Login Page" width="80%">
</p>

*Secure login with session and cookie-based authentication*

### 📝 ObsList Dashboard
<p align="center">
  <img src="src/main/webapp/Images/web1%20(19).jpg" alt="ObsList Dashboard" width="80%">
</p>

*Personal travel bucket list with CRUD operations and inline editing*

### ℹ️ About Page
<p align="center">
  <img src="src/main/webapp/Images/about. jpg" alt="About Page" width="80%">
</p>

### 📋 Registration
<p align="center">
  <img src="src/main/webapp/Images/web1%20(24).jpg" alt="Registration" width="80%">
</p>

---

## ⚙️ Technology Stack

| Technology | Purpose |
|------------|---------|
| ☕ **Java 21** | Core programming language |
| 🧩 **Jakarta Servlets** | Server-side request handling |
| 📄 **JSP (Java Server Pages)** | Dynamic HTML generation |
| 🔄 **AJAX (Fetch API)** | Asynchronous data operations |
| 🍪 **Cookies** | Persistent user login (12-hour expiry) |
| 📦 **HTTP Sessions** | Server-side user state management |
| 🗄️ **MySQL** | Database for users and destinations |
| 🎨 **CSS3** | Custom styling with CSS variables |
| 📱 **Responsive Design** | Mobile-first approach with media queries |
| 🎠 **Swiper.js** | Touch-enabled image sliders |
| 🔤 **Font Awesome** | Icon library |

---

## 📁 Project Structure

```
obslist/
├── . classpath                    # Eclipse classpath configuration
├── .project                      # Eclipse project metadata
├── . settings/                    # Eclipse IDE settings
├── LICENSE                       # Apache 2.0 License
├── README.md                     # This file
├── build/
│   └── classes/                  # Compiled Java classes
│
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       ├── login/
        │       │   ├── Login.java              # 🔐 Login servlet with session & cookie creation
        │       │   └── Logout.java             # 🚪 Logout servlet - session & cookie invalidation
        │       │
        │       └── ObsList/
        │           ├── AddDestinationServlet.java     # ➕ Add new destination
        │           ├── EditDestinationServlet. java    # ✏️ Edit destination (POST)
        │           ├── EditRestApiServlet.java        # ✏️ RESTful PUT API for editing
        │           ├── DeleteDestinationServlet.java  # 🗑️ Delete destination (GET)
        │           └── DeleteRestApiServlet. java      # 🗑️ RESTful DELETE API
        │
        └── webapp/
            ├── META-INF/                    # Web application metadata
            ├── WEB-INF/
            │   └── lib/
            │       └── json-20230618.jar    # JSON parsing library
            │
            ├── css/
            │   └── style.css               # 🎨 Main stylesheet (960+ lines)
            │
            ├── js/
            │   └── script.js               # 📜 JavaScript for UI interactions
            │
            ├── Images/                      # 🖼️ 40+ high-quality travel images
            │   ├── about.jpg
            │   ├── adventure.png
            │   ├── img-1.jpg ...  img-6.jpg
            │   ├── web1 (1).jpg ... web1 (26).jpg
            │   └── ...  (icons & backgrounds)
            │
            ├── home.jsp                    # 🏠 Landing page with slider
            ├── about.jsp                   # ℹ️ About us page
            ├── packages.jsp                # 📦 Travel packages listing
            ├── login.jsp                   # 🔐 User login form
            ├── register.jsp                # 📝 User registration form
            └── obslist.jsp                 # 📋 Main bucket list dashboard
```

---

## 🔧 Prerequisites

Before setting up the project, ensure you have:

- ☕ **Java JDK 21** or higher
- 🌐 **Apache Tomcat 10.1** (Jakarta EE compatible)
- 📦 **Eclipse IDE for Enterprise Java Developers**
- 🗄️ **MySQL Server 8.0+**
- 🔌 **MySQL Connector/J 8.0.33**

---

## 🚀 Eclipse IDE Setup

### Step 1: Install Eclipse IDE

1. Download **Eclipse IDE for Enterprise Java and Web Developers** from [eclipse.org](https://www.eclipse.org/downloads/packages/)
2. Extract and run Eclipse
3. Create a new workspace or use existing one

### Step 2: Download & Configure Apache Tomcat

1. **Download Apache Tomcat 10.1** from [tomcat.apache. org](https://tomcat.apache.org/download-10.cgi)
2. Extract to a folder (e.g., `C:\apache-tomcat-10.1.x`)

3. **Add Tomcat to Eclipse:**
   - Go to `Window` → `Preferences`
   - Navigate to `Server` → `Runtime Environments`
   - Click `Add...`
   - Select **Apache Tomcat v10.1**
   - Browse to your Tomcat installation directory
   - Click `Finish`

<p align="center">
  <img src="src/main/webapp/Images/guide. png" alt="Server Setup" width="60%">
</p>

### Step 3: Import the Project

1. `File` → `Import... `
2. Select `Git` → `Projects from Git`
3. Choose `Clone URI`
4. Enter: `https://github.com/Obsi19/obslist.git`
5. Select `main` branch
6. Import as **Existing Eclipse Project**

### Step 4: Configure MySQL Connector

1. Download **MySQL Connector/J 8.0.33** from [MySQL Downloads](https://dev.mysql.com/downloads/connector/j/)
2. Place the JAR file at `C:\Users\<YourUser>\Downloads\mysql-connector-j-8.0.33\`
3. In Eclipse:
   - Right-click project → `Build Path` → `Configure Build Path`
   - Add the MySQL Connector JAR
   - Ensure `src/main/webapp/WEB-INF/lib/json-20230618.jar` is included

### Step 5: Database Setup

Create the MySQL database and tables:

```sql
-- Create Database
CREATE DATABASE travel_guide;
USE travel_guide;

-- Create Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    dob DATE,
    address VARCHAR(255),
    password VARCHAR(255) NOT NULL
);

-- Create To Visit Table (Bucket List)
CREATE TABLE to_visit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(100) NOT NULL,
    place_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    type ENUM('Beach', 'Mountain', 'Historical') NOT NULL,
    visit_date DATE,
    status ENUM('Pending', 'Planned', 'Visited', 'Cancelled') NOT NULL,
    FOREIGN KEY (user_email) REFERENCES users(email)
);
```

### Step 6: Update Database Credentials

Update the following files with your MySQL credentials:

| File | Line | Update |
|------|------|--------|
| `Login.java` | Lines 21-23 | `DB_URL`, `USER`, `PASSWORD` |
| `Logout.java` | - | No DB connection |
| `AddDestinationServlet.java` | Lines 15-17 | `DB_URL`, `USER`, `PASSWORD` |
| `EditDestinationServlet.java` | Lines 17-19 | `DB_URL`, `DB_USER`, `DB_PASSWORD` |
| `EditRestApiServlet.java` | Lines 12-14 | `DB_URL`, `DB_USER`, `DB_PASSWORD` |
| `DeleteDestinationServlet. java` | Lines 14-16 | `DB_URL`, `USER`, `PASSWORD` |
| `DeleteRestApiServlet.java` | Lines 12-14 | `DB_URL`, `DB_USER`, `DB_PASSWORD` |
| All `.jsp` files | Connection strings | Update inline credentials |

### Step 7: Run the Application

1. Right-click project → `Run As` → `Run on Server`
2. Select **Apache Tomcat v10.1**
3. Click `Finish`
4. Open browser:  `http://localhost:8080/obslist/home.jsp`

---

## 🔐 Authentication & Session Management

### Session Handling

Every JSP page implements session validation:

```java
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String userEmail = (String) session.getAttribute("email");
    
    // Redirect if not authenticated
    if (username == null || userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
```

### Cookie-Based Persistent Login

```java
// Creating login cookie (12-hour expiry)
Cookie loginCookie = new Cookie("userEmail", email);
loginCookie. setMaxAge(12 * 60 * 60); // 12 hours
response.addCookie(loginCookie);

// Checking for existing cookie on page load
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("userEmail".equals(cookie.getName())) {
            // Restore session from cookie
        }
    }
}
```

### Logout Process

```java
// Clear session
session.removeAttribute("username");
session.removeAttribute("email");
session.invalidate();

// Clear cookie
Cookie logincookie = new Cookie("userEmail", "");
logincookie.setMaxAge(0);
response.addCookie(logincookie);
```

---

## 🔄 AJAX Implementation

### RESTful API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/edit/{id}` | PUT | Update destination |
| `/api/delete/{id}` | DELETE | Remove destination |

### Inline Editing with AJAX (Fetch API)

```javascript
// Edit destination using PUT request
fetch('/obslist/api/edit/' + id, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
        id: id,
        place_name: place,
        location: location,
        type:  type,
        visit_date: visitDate,
        status: status
    })
})
.then(res => res.text())
.then(response => {
    if (response === 'success') {
        showNotification('Updated successfully', 'success');
    }
});

// Delete destination using DELETE request
fetch('/obslist/api/delete/' + id, {
    method:  'DELETE'
})
.then(res => res.text())
.then(response => {
    if (response === 'success') {
        row.remove();
        showNotification('Item deleted successfully', 'success');
    }
});
```

---

## 📋 Java Servlets

### Servlet Mapping Summary

| Servlet | URL Pattern | Purpose |
|---------|-------------|---------|
| `Login` | `/Login` | User authentication |
| `Logout` | `/logout` | Session termination |
| `AddDestinationServlet` | `/AddDestinationServlet` | Add new bucket list item |
| `EditDestinationServlet` | `/EditDestinationServlet` | Edit item (legacy POST) |
| `EditRestApiServlet` | `/api/edit/*` | RESTful edit endpoint |
| `DeleteDestinationServlet` | `/DeleteDestinationServlet` | Delete item (GET) |
| `DeleteRestApiServlet` | `/api/delete/*` | RESTful delete endpoint |

---

## 📄 JSP Pages

| Page | Path | Features |
|------|------|----------|
| **Home** | `/home.jsp` | Swiper slider, services section, packages preview |
| **About** | `/about.jsp` | Company information, statistics |
| **Packages** | `/packages.jsp` | Travel packages grid with "Load More" |
| **Login** | `/login.jsp` | Email/password login form |
| **Register** | `/register.jsp` | Full user registration with validation |
| **ObsList** | `/obslist.jsp` | ⭐ Main dashboard - CRUD operations, inline editing |

---

## 🎨 Styling Features

- **CSS Variables** for consistent theming
- **Responsive Grid Layouts** with `auto-fit` and `minmax()`
- **Custom Scrollbar** styling
- **Animated Notifications** for AJAX feedback
- **Mobile-First Media Queries** (768px, 991px, 1200px breakpoints)

---

## 📦 Dependencies

| Dependency | Version | Location |
|------------|---------|----------|
| MySQL Connector/J | 8.0.33 | External JAR |
| JSON Library | 20230618 | `WEB-INF/lib/json-20230618.jar` |
| Swiper.js | 11 | CDN |
| Font Awesome | 6.7.2 | CDN |

---

## 🔒 Security Notes

> ⚠️ **Important:** Before deploying to production: 

1. **Hash passwords** using BCrypt or similar
2. **Use environment variables** for database credentials
3. **Enable HTTPS** for secure data transmission
4. **Implement CSRF protection** on forms
5. **Use PreparedStatements** (already implemented ✅)

---

## 📞 Contact

- **Email:** Obslink19@gmail.com
- **Location:** Lahore, Pakistan - 54000
- **Phone:** +92-309-7220811

---

## 📜 License

This project is licensed under the **Apache License 2.0** - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  &copy; 2025 <b>Obslink19</b> | All Rights Reserved
</p>
