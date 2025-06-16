<%-- 
    Document   : user_dashboard
    Created on : 12 Jun 2025, 9:33:34 AM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
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
            <a href="donationForm.jsp">Donate</a>
            <a href="create_campaign.jsp">Join Campaign</a>
        </nav>
    </header>

    <main>
        <h2>Welcome, Fundraiser!</h2>
         <img src="banner.JPG" alt="Fundraising Banner">
        <p>Thank you for your support. You can donate or join a campaign using the menu above.</p>
    </main>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>

