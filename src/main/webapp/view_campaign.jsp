<%-- 
    Document   : view_campaign
    Created on : 12 Jun 2025, 1:21:06 AM
    Author     : ameer muqrie
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.model.Campaign" %>
<html>
<head>
    <title>All Campaigns</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f7f7f7;
            margin: 0;
            padding: 40px 20px;
            color: #4b1b00;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
        }
        a {
            color: #4b1b00;
            text-decoration: none;
            font-weight: 600;
        }
        a:hover { text-decoration: underline; }
        .new-campaign {
            display: inline-block;
            margin: 0 auto 40px;
            background: #4b1b00;
            color: #fff;
            padding: 12px 20px;
            border-radius: 6px;
            font-weight: bold;
            transition: .3s;
        }
        .new-campaign i { margin-right: 6px; }
        .new-campaign:hover {
            background: #5b3a00;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(75, 27, 0, .3);
        }
        .campaign-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
            padding: 0;
            list-style: none;
        }
        .campaign-card {
            background: #fff;
            width: 300px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, .1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: .3s;
        }
        .campaign-card:hover { transform: translateY(-4px); }
        .campaign-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            display: block;
        }
        .card-body {
            padding: 20px 18px 22px;
            flex: 1;
        }
        .card-body h3 {
            margin: 0 0 6px;
            font-size: 1.25rem;
            line-height: 1.3;
            color: #4b1b00;
        }
        .goal {
            font-weight: 700;
            margin-bottom: 10px;
        }
        .desc {
            font-size: .95rem;
            line-height: 1.4;
            color: #444;
            margin-bottom: 16px;
            max-height: 60px;
            overflow: hidden;
        }
        .card-actions {
            font-size: .9rem;
            border-top: 1px solid #eee;
            padding-top: 12px;
            display: flex;
            gap: 10px;
        }
        .card-actions a {
            display: inline-flex;
            align-items: center;
        }
        .card-actions i { margin-right: 4px; }
    </style>
</head>
<body>

<h2>All Campaigns</h2>
<div style="text-align:center;">
    <a href="create_campaign.jsp" class="new-campaign">
        <i class="fas fa-plus-circle"></i> New Campaign
    </a>
</div>

<ul class="campaign-grid">
    <%
        List<Campaign> list = (List<Campaign>) request.getAttribute("campaigns");
        if (list == null || list.isEmpty()) {
    %>
        <li style="color:#666;">No campaigns found.</li>
    <%
        } else {
            for (Campaign c : list) {
    %>
    <li class="campaign-card">
        <% if (c.getPhotoPath() != null) { %>
            <img src="<%= request.getContextPath() + "/" + c.getPhotoPath() %>" alt="<%= c.getTitle() %>">
        <% } else { %>
            <img src="images/placeholder.jpg" alt="No Image Available">
        <% } %>

        <div class="card-body">
            <h3><%= c.getTitle() %></h3>
            <div class="goal">RM <%= String.format("%,.2f", c.getGoal()) %></div>
            <p class="desc"><%= c.getDescription() %></p>

            <div class="card-actions">
                <a href="update_campaign.jsp?id=<%= c.getCampaignID() %>">
                    <i class="fas fa-edit"></i> Edit
                </a>
                |
                <a href="deleteCampaign?id=<%= c.getCampaignID() %>"
                   onclick="return confirm('Delete this campaign?');">
                    <i class="fas fa-trash-alt"></i> Delete
                </a>
            </div>
        </div>
    </li>
    <%
            }
        }
    %>
</ul>

</body>
</html>


