<%-- 
    Document   : user_dashboard
    Created on : 12 Jun 2025, 9:33:34 AM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fdf6e3;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensures footer stays at the bottom */
        }
        header {
            background-color: #d6a96e; /* Kept original header color */
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        nav {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-bottom: 20px;
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
        main {
            flex-grow: 1; /* Allows main content to take up available space */
            padding: 30px;
            text-align: center;
            display: flex; /* Use flexbox for layout of containers */
            flex-direction: column; /* Stack elements vertically */
            align-items: center; /* Center items horizontally */
            gap: 30px; /* Space between the welcome message and action containers */
        }
        
        .action-containers {
            display: flex; /* Flexbox for side-by-side containers */
            justify-content: center;
            gap: 40px; /* Space between the two action containers */
            width: 100%;
            max-width: 960px; /* Limit overall width */
            flex-wrap: wrap; /* Allow wrapping on smaller screens */
        }
        .dashboard-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            flex: 1; /* Allows containers to grow and shrink */
            min-width: 300px; /* Minimum width before wrapping */
            max-width: 450px; /* Maximum width for individual containers */
            text-align: center;
        }
        h2 {
            color: #333;
            font-size: 2.2em;
            margin-bottom: 25px;
        }
        .dashboard-container h3 {
            color: #d6a96e; /* Match header color for heading */
            font-size: 1.8em;
            margin-bottom: 20px;
        }
        .dashboard-container p {
            color: #555;
            font-size: 1.1em;
            line-height: 1.6;
            margin-bottom: 25px;
        }
        .dashboard-container a.button {
            display: inline-block;
            background-color: #d6a96e; /* Button color matching header */
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            font-size: 1em;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .dashboard-container a.button:hover {
            background-color: #b78c54; /* Darker shade on hover */
            transform: translateY(-2px);
        }
        main img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        footer {
            background-color: #d6a96e; /* Kept original footer color */
            color: white;
            text-align: center;
            padding: 15px 0;
            margin-top: auto; /* Pushes footer to the bottom */
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .action-containers {
                flex-direction: column;
                align-items: center;
            }
            .dashboard-container {
                max-width: 90%; /* Adjust width for smaller screens */
            }
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <a href="Logout.jsp">Logout</a>
        </nav>
    </header>

    <main>
        <div>
            <h2>Welcome, Fundraiser!</h2>
            <p>Thank you for your support. You can make a difference through the options below.</p>
        </div>

        <div class="action-containers">
            <div class="dashboard-container">
                <h3>Make a Donation</h3>
                <p>Your contribution helps us achieve our goals. Every little bit makes a big difference!</p>
                <a href="donationForm.jsp" class="button">Donate Now</a>
            </div>

            <div class="dashboard-container">
                <h3>Oversee Campaigns</h3>
                <p>Monitor existing campaigns, approve new ones, and track overall campaign performance.</p>
                <a href="view_campaign.jsp" class="button">View Campaigns</a>
            </div>
        </div>
    </main>

    <footer>
        &copy; 2025 Fundraising System. All rights reserved.
    </footer>
</body>
</html>

