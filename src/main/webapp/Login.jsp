<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Fundraising System</title>
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
            padding: 20px;
            text-align: center;
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

        .container {
            max-width: 500px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #d6a96e;
            color: white;
            padding: 12px;
            margin-top: 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            width: 100%;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #c58e47;
        }

        .error {
            color: red;
            font-weight: bold;
            text-align: center;
            margin-bottom: 15px;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
        }

        .register-link a {
            color: #0077cc;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        footer {
            background-color: #d6a96e;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: 60px;
            position: relative;
        }
    </style>
</head>
<body>

<header>
    <nav>
        <a href="index.html">Home</a>
    </nav>
</header>

<div class="container">
 <form action="LoginServlet" method="post">
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <label for="email">Email:</label>
    <input type="text" id="email" name="email" required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>

    <input type="submit" value="Login">

    <div class="register-link">
        <p>Don't have an account? <a href="UserForm.jsp">Register here</a></p>
    </div>
</form>

</div>

<footer>
    &copy; 2025 Fundraising System. All rights reserved.
</footer>

</body>
</html>
