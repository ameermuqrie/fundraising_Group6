<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fundraising System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fdf6e3;
        }

        header {
            background-color: #d6a96e;
            color: white;
            padding: 20px 0;
        }

        nav {
            display: flex;
            justify-content: center;
            gap: 40px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
        }

        nav a:hover {
            text-decoration: underline;
        }

        main {
            text-align: center;
            padding: 50px;
        }

        footer {
            background-color: #d6a96e;
            color: white;
            text-align: center;
            padding: 15px 0;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        .greeting {
            font-size: 20px;
            margin: 20px 0;
            color: #333;
        }

        .logout {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<header>
    <nav>
        <% 
            User user = (User) session.getAttribute("user");
            if (user == null) {
        %>
            <a href="UserForm.jsp">Register</a>
            <a href="Login.jsp">Login</a>
            <a href="donationForm.jsp">Let's Donate</a>
            <a href="create_campaign.jsp">Join Campaign</a>
        <% } else if ("admin".equalsIgnoreCase(user.getRole())) { %>
            <a href="UserList.jsp">List Users</a>
            <a href="adminDonationView.jsp">List Donations</a>
            <a href="view_campaign.jsp">List Campaigns</a>
        <% } else { %>
            <a href="donationForm.jsp">Donate Now</a>
            <a href="create_campaign.jsp">Start Campaign</a>
            <a href="view_campaign.jsp">View Campaigns</a>
        <% } %>
    </nav>
</header>

<main>
    <h1>Welcome to Our Fundraising System</h1>
    <p class="greeting">
        <% if (user != null) { %>
            Hello, <strong><%= user.getEmail() %></strong>! You are logged in as <%= user.getRole() %>.
        <% } else { %>
            Please log in to access more features.
        <% } %>
    </p>

    <img src="banner.JPG" alt="Fundraising Banner" width="70%">

    <% if (user != null) { %>
        <div class="logout">
            <form action="LogoutServlet" method="post">
                <input type="submit" value="Logout">
            </form>
        </div>
    <% } %>
</main>

<footer>
    &copy; 2025 Fundraising System. All rights reserved.
</footer>

</body>
</html>
