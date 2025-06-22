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
            background-color: #a0522d; /* Darker brown for submit buttons */
            color: white;
            border: none;
            cursor: pointer;
            margin: 2px;
            padding: 8px 12px; /* Slightly larger padding */
        }

        input[type="submit"]:hover {
            background-color: #8B4513; /* Even darker on hover */
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
            <a href="admin_dashboard.jsp">Home</a>
        </nav>
    </header>

    <h2>All Donations (Admin View)</h2>

    <table>
        <%-- Updated table headers to match database columns directly --%>
        <tr>
            <th>Donation ID</th>
            <th>User ID</th>
            <th>Campaign ID</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
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
                <td>
                    <select name="status">
                        <option value="Pending" <%= "Pending".equals(rs.getString("paymentStatus")) ? "selected" : "" %>>Pending</option>
                        <option value="Completed" <%= "Completed".equals(rs.getString("paymentStatus")) ? "selected" : "" %>>Completed</option>
                        <option value="Refunded" <%= "Refunded".equals(rs.getString("paymentStatus")) ? "selected" : "" %>>Refunded</option>
                    </select>
                </td>
                <td>
                    <%-- Displaying only the date (yyyy-MM-dd) --%>
                    <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("date")) %>
                </td>
                <td>
                    <input type="hidden" name="donationID" value="<%= rs.getInt("donationID") %>">
                    <input type="submit" value="Update">
                </form>
                <form action="DeleteDonationServlet" method="post" style="display:inline;">
                    <input type="hidden" name="donationID" value="<%= rs.getInt("donationID") %>">
                    <input type="submit" value="Delete" onclick="return showCustomConfirm();">
                    <script>
                        function showCustomConfirm() {
                            if (confirm('Are you sure you want to delete this donation? This action cannot be undone.')) {
                                return true; // Proceed with form submission
                            } else {
                                return false; // Cancel form submission
                            }
                        }
                    </script>
                </form>
                </td>
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
