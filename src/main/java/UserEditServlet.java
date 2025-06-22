/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.User;
import model.UserDAO;

@WebServlet("/UserEditServlet")
public class UserEditServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve the user ID from the hidden input field
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                // If ID is missing, something went wrong, redirect to list
                response.sendRedirect("UserList.jsp");
                return;
            }
            int id = Integer.parseInt(idParam);

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User user = new User();
            user.setId(id); // Set the ID for the update operation
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            UserDAO dao = new UserDAO();
            dao.updateUser(user); // Make sure this method uses the ID for the WHERE clause in SQL

            // Redirect back to UserList.jsp after successful update
            response.sendRedirect("UserList.jsp");
        } catch (NumberFormatException e) {
            // Handle case where ID is not a valid number
            response.sendRedirect("UserList.jsp?error=invalidid"); // Or show an error message
        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();
            throw new ServletException("Error updating user: " + e.getMessage(), e);
        }
    }
}
