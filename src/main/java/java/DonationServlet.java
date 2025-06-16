/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package java;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/DonationServlet") 
public class DonationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = 1; // Assume logged-in user
        int campaignID = Integer.parseInt(request.getParameter("campaignID"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO donations (userID, campaignID, amount) VALUES (?, ?, ?)"
            );
            ps.setInt(1, userID);
            ps.setInt(2, campaignID);
            ps.setDouble(3, amount);
            ps.executeUpdate();
            response.sendRedirect("donationHistory.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       response.sendRedirect("views/donationHistory.jsp");

    }
}
