<%-- 
    Document   : update_campaign
    Created on : 12 Jun 2025, 1:18:33 AM
    Author     : ameer muqrie
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.CampaignDAO, model.Campaign" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Campaign campaign = new CampaignDAO().getCampaignById(id);
%>
<html>
<head>
    <title>Edit Campaign</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f7f7f7;
            padding: 40px 20px;
            color: #4b1b00;
        }

        h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 30px;
        }

        form {
            background-color: #fff;
            max-width: 500px;
            margin: 0 auto;
            padding: 30px 25px;
            border-radius: 10px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 0.95rem;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        input[type="submit"] {
            background-color: #4b1b00;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #5b3a00;
        }

        .preview-img {
            display: block;
            margin: 10px auto 20px;
            border-radius: 6px;
            max-width: 120px;
            height: auto;
        }
    </style>

    <script>
        function validateForm() {
            const title = document.forms["campaignForm"]["title"].value.trim();
            const goal = document.forms["campaignForm"]["goal"].value;
            if (title === "") {
                alert("Title must not be empty.");
                return false;
            }
            if (goal <= 0 || isNaN(goal)) {
                alert("Goal must be a positive number.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

    <h2>Edit Campaign</h2>

    <form name="campaignForm" action="updateCampaign" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
        <input type="hidden" name="campaignID" value="<%= campaign.getCampaignID() %>">

        <label for="title">Title</label>
        <input type="text" name="title" value="<%= campaign.getCampaignID() %>">

        <label for="description">Description</label>
        <textarea name="description"><%= campaign.getDescription() %></textarea>

        <label for="goal">Goal Amount (RM)</label>
        <input type="number" name="goal" value="<%= campaign.getGoal() %>" step="0.01">

        <% if (campaign.getPhotoPath() != null) { %>
            <label>Current Photo</label>
            <img src="<%= request.getContextPath() + "/" + campaign.getPhotoPath() %>" class="preview-img">
        <% } %>

        <label for="photo">Replace Photo</label>
        <input type="file" name="photo" accept="image/*">

        <input type="submit" value="Update">
    </form>

</body>
</html>

