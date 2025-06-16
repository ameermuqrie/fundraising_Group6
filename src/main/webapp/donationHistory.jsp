<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Your Donations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fdf6e3;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header and Navigation */
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

        h2 {
            text-align: center;
            margin-top: 30px;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #d6a96e;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2e6d9;
        }

        tr:hover {
            background-color: #f5dcb3;
        }

        footer {
            background-color: #d6a96e;
            color: white;
            text-align: center;
            padding: 15px 0;
            margin-top: auto;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <a href="index.html">Home</a>
            <a href="UserForm.jsp">User</a>
            <a href="donationForm.jsp">Donation</a>
            <a href="create_campaign.jsp">Campaign</a>
        </nav>
    </header>

    <h2>Donation History</h2>
    <table>
        <tr><th>ID</th><th>Campaign</th><th>Amount (RM)</th><th>Status</th><th>Date</th></tr>
        <%
            int userID = 1; // Simulate logged-in user
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM donations WHERE userID = " + userID);
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("donationID") %></td>
            <td><%= rs.getInt("campaignID") %></td>
            <td><%= rs.getDouble("amount") %></td>
            <td><%= rs.getString("paymentStatus") %></td>
            <td><%= rs.getTimestamp("date") %></td>
        </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>
