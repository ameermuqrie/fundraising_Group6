/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDAO;

/**
 *
 * @author farajuhaimi
 */
@WebServlet("/UserDeleteServlet")
public class UserDeleteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userIDParam = request.getParameter("userID");

        // Defensive: return to list if missing
        if (userIDParam == null || userIDParam.isEmpty()) {
            response.sendRedirect("UserListServlet"); // fallback instead of error
            return;
        }

        try {
            int userID = Integer.parseInt(userIDParam);
            new UserDAO().deleteUser(userID);
            response.sendRedirect("UserListServlet");
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid user ID format: " + userIDParam, e);
        } catch (Exception e) {
            throw new ServletException("Failed to delete user.", e);
        }
    }
}

