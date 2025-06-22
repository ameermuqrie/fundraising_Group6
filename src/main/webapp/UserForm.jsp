<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>User Management</title>
    <meta charset="UTF-8">
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

        h1 {
            text-align: center;
            margin-top: 30px;
        }

        form {
            background-color: white;
            padding: 30px;
            max-width: 500px;
            margin: 20px auto;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
        }

        td {
            padding: 10px;
            font-size: 16px;
        }

        input[type="text"], input[type="password"], select {
            width: 100%;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #d6a96e;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #c58e47;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #0077cc;
            font-weight: bold;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
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
            <a href="Login.jsp">Login</a>
        </nav>
    </header>

    <h1>REGISTRATION USER</h1>
    <form action="UserCreateServlet" method="post">
        <table>
            <tr>
                <td>Email:</td>
                <td><input type="text" name="email" required /></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" required /></td>
            </tr>
            <tr>
                <td>Role:</td>
                <td>
                    <select name="role" required>
                        <option value="admin">admin</option>
                        <option value="fundraiser">fundraiser</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="register" /></td>
            </tr>
        </table>
    </form>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>
