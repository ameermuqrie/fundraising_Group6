<%-- 
    Document   : UserEdit
    Created on : 12 Jun 2025, 4:23:58 AM
    Author     : farajuhaimi
--%>

<%@ page import="java.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect("UserList.jsp");
        return;
    }
%>
<html>
<head>
    <title>Edit User</title>
</head>
<body>
    <h2>Edit User</h2>
    <form action="UserEditServlet" method="post">
        <input type="hidden" name="id" value="<%= user.getId() %>" />
        <table>
            <tr>
                <td>Email:</td>
                <td><input type="text" name="email" value="<%= user.getEmail() %>" required /></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" value="<%= user.getPassword() %>" required /></td>
            </tr>
          <tr>
          <td>Role:</td>
               <td>
          <select name="role">
            <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>admin</option>
            <option value="fundraiser" <%= "fundraiser".equals(user.getRole()) ? "selected" : "" %>>fundraiser</option>
          </select>
               </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Update User" /></td>
            </tr>
        </table>
    </form>
</body>
</html>

