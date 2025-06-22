<%-- 
    Document   : UserList
    Created on : 12 Jun 2025, 4:23:58 AM
    Author     : farajuhaimi
--%>
<%@ page import="java.util.List, model.UserDAO, model.User" %>
<%
    UserDAO dao = new UserDAO();
    List<User> userList = dao.listAllUsers();
%>
<html>
<head><title>User List</title>
</head>
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
<body>
     <header>
        <nav>
           <a href="admin_dashboard.jsp">Home</a>
        </nav>
    </header>

<h2>User List (Admin View)</h2>
<table border="1">
    <tr><th>ID</th><th>Email</th><th>Password</th><th>Role</th><th>Actions</th></tr>
    <% for (User user : userList) { %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getPassword() %></td>
            <td><%= user.getRole() %></td>
            <td>
                <a href="UserGetServlet?userID=<%= user.getId() %>">Edit</a>
                <a href="UserDeleteServlet?userID=<%= user.getId() %>">Delete</a>

            </td>
        </tr>
    <% } %>
</table>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>