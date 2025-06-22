/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/UpdateDonationStatusServlet") // <- This enables direct mapping
public class UpdateDonationStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int donationID = Integer.parseInt(request.getParameter("donationID"));
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");
            PreparedStatement ps = con.prepareStatement(
                "UPDATE donations SET paymentStatus = ? WHERE donationID = ?"
            );
            ps.setString(1, status);
            ps.setInt(2, donationID);
            ps.executeUpdate();
            response.sendRedirect("adminDonationView.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

