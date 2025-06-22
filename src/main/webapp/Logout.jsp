<%-- 
    Document   : Logout
    Created on : 21 Jun 2025, 11:37:09 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logging Out...</title>
</head>
<body>
    <%
        // Invalidate the current session
        session.invalidate();

        // Redirect to the home page (or login page) after a short delay
        // You can change "index.html" to your desired landing page (e.g., "login.jsp")
        response.sendRedirect("index.html");
    %>
</body>
</html>
