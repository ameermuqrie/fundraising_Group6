<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
            <a href="user_dashboard.jsp">Home</a>
        </nav>
    </header>

    <h2>Donation History</h2>
    <table>
        <%-- Updated table headers to match database columns --%>
        <tr><th>Donation ID</th><th>User ID</th><th>Campaign ID</th><th>Amount (RM)</th><th>Status</th><th>Date</th></tr>
       <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");
                stmt = con.createStatement();
                
                // SQL query updated to select directly from 'donations' table
                String sql = "SELECT donationID, userID, campaignID, amount, paymentStatus, date " +
                             "FROM donations ORDER BY date DESC"; // Order by date, newest first

                rs = stmt.executeQuery(sql);

                boolean hasDonations = false;
                while (rs.next()) {
                    hasDonations = true;
        %>
        <tr>
            <form action="UpdateDonationStatusServlet" method="post">
                <td><%= rs.getInt("donationID") %></td>
                <td><%= rs.getInt("userID") %></td>    <%-- Display userID directly --%>
                <td><%= rs.getInt("campaignID") %></td> <%-- Display campaignID directly --%>
                <td><%= String.format("%.2f", rs.getDouble("amount")) %></td>
                <td><%= rs.getString("paymentStatus") %></td>
                <td> <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("date")) %></td>
                
        </tr>
        <%
                }
                if (!hasDonations) {
                    out.println("<tr><td colspan='7'>No donations found in the system.</td></tr>");
                }
            } catch (SQLException se) {
                out.println("<tr><td colspan='7'>Database Error: " + se.getMessage() + "</td></tr>");
                se.printStackTrace();
            } catch (ClassNotFoundException cnfe) {
                out.println("<tr><td colspan='7'>Error: JDBC Driver not found.</td></tr>");
                cnfe.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </table>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>
