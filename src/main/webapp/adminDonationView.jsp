<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Donations</title>
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
            margin: 30px 0 20px;
            color: #333;
        }

        table {
            width: 90%;
            margin: 0 auto 40px;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 16px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2c48d;
            color: #333;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #fefaf3;
        }

        tr:hover {
            background-color: #f9e7ce;
        }

        select, input[type="submit"] {
            padding: 6px 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: brown;
            color: white;
            border: none;
            cursor: pointer;
            margin: 2px;
        }

        input[type="submit"]:hover {
            background-color: #a0522d;
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
            <a href="UserList.jsp">List User</a>
            <a href="adminDonationView.jsp">List Donation</a>
            <a href="view_campaign.jsp">List Campaign</a>
        </nav>
    </header>

    <h2>All Donations (Admin View)</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Campaign</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM donations");

                while (rs.next()) {
        %>
        <tr>
            <form action="UpdateDonationStatusServlet" method="post">
                <td><%= rs.getInt("donationID") %></td>
                <td><%= rs.getInt("userID") %></td>
                <td><%= rs.getInt("campaignID") %></td>
                <td><%= rs.getDouble("amount") %></td>
                <td>
                    <select name="status">
                        <option value="Pending" <%= rs.getString("paymentStatus").equals("Pending") ? "selected" : "" %>>Pending</option>
                        <option value="Completed" <%= rs.getString("paymentStatus").equals("Completed") ? "selected" : "" %>>Completed</option>
                        <option value="Refunded" <%= rs.getString("paymentStatus").equals("Refunded") ? "selected" : "" %>>Refunded</option>
                    </select>
                </td>
                <td><%= rs.getTimestamp("date") %></td>
                <td>
                    <input type="hidden" name="donationID" value="<%= rs.getInt("donationID") %>">
                    <input type="submit" value="Update">
            </form>
            <form action="DeleteDonationServlet" method="post" style="display:inline;">
                <input type="hidden" name="donationID" value="<%= rs.getInt("donationID") %>">
                <input type="submit" value="Delete" onclick="return confirm('Are you sure?');">
            </form>
                </td>
        </tr>
        <% } con.close(); } catch (Exception e) { out.println("Error: " + e.getMessage()); } %>
    </table>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>
