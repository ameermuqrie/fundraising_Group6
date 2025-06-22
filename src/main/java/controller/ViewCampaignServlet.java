/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

/**
 *
 * @author Ameer Muqrie
 */
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import model.CampaignDAO;
import model.Campaign;

@WebServlet("/viewCampaigns")
public class ViewCampaignServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Campaign> list = new CampaignDAO().getAllCampaigns();
            request.setAttribute("campaigns", list);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("campaigns", null);
        }

        request.getRequestDispatcher("view_campaign.jsp").forward(request, response);
    }
}