<%-- 
    Document   : admin_dashboard
    Created on : 12 Jun 2025, 9:28:08 AM
    Author     : faraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fdf6e3;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #d6a96e;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        nav {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-bottom: 20px;
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
            padding: 30px;
            text-align: center;
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
    </style>
</head>
<body>
    <header>
        <nav>
            <a href="index.html">Home</a>
            <a href="UserList.jsp">User List</a>
            <a href="adminDonationView.jsp">Donations</a>
            <a href="view_campaign.jsp">Campaigns</a>
        </nav>
    </header>

    <main>
        <h2>Welcome, Admin!</h2>
         <img src="banner.JPG" alt="Fundraising Banner">
        <p>Use the navigation above to manage users, donations, and campaigns.</p>
    </main>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>

