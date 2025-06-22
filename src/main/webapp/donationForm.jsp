<%-- 
    Document   : donationForm
    Created on : Jun 8, 2025, 6:59:32 PM
    Author     : Puteri Zulaika
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Make a Donation</title>
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

        /* Center the card */
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 0;
        }

        .card {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 90%;
            text-align: center;
        }

        h1 {
            color: #333;
            font-weight: normal;
            margin-bottom: 20px;
        }

        form input[type="text"], form select {
            padding: 8px;
            width: 100%;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: brown;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-weight: bold;
        }

        /* Footer */
        footer {
            background-color: #d6a96e;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
    </style>
    <script>
        function validateForm() {
            var amount = document.forms["donationForm"]["amount"].value;
            if (isNaN(amount) || amount <= 0) {
                alert("Please enter a valid donation amount.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <header>
        <nav>
            <a href="user_dashboard.jsp">Home</a>
        </nav>
    </header>

    <div class="main-content">
        <div class="card">
            <h1>Lets Donate</h1>
            <form name="donationForm" action="DonationServlet" method="post" onsubmit="return validateForm()">
                <label for="userID"> User ID:</label><br>
                <input type="text" name="userID"><br>
                <label for="campaignID"> Campaign ID:</label><br>
                <input type="text" name="campaignID"><br>
                <label for="title">Select Campaign:</label><br>
                <select name="title">
                    <option value="1">LA FAMILIA</option>
                </select><br>
                <label for="amount">Amount (RM):</label><br>
                <input type="text" name="amount"><br>
                <input type="submit" value="Donate">
            </form>
        </div>
    </div>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>

</body>
</html>
