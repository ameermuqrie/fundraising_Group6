/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/DeleteDonationServlet")
public class DeleteDonationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        deleteDonation(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        deleteDonation(request, response);
    }

    private void deleteDonation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int donationID = Integer.parseInt(request.getParameter("donationID"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");
            PreparedStatement ps = con.prepareStatement("DELETE FROM donations WHERE donationID = ?");
            ps.setInt(1, donationID);
            ps.executeUpdate();
            response.sendRedirect("adminDonationView.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
