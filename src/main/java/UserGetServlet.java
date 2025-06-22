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

@WebServlet("/UserGetServlet")
public class UserGetServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("userID"); // Correctly expects "userID"
            if (idParam == null || idParam.isEmpty()) {
                response.sendRedirect("UserList.jsp");
                return;
            }

            int userID = Integer.parseInt(idParam);
            UserDAO dao = new UserDAO();
            User user = dao.getUserById(userID);

            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("UserEdit.jsp").forward(request, response);
            } else {
                // User not found, redirect back to list
                response.sendRedirect("UserList.jsp");
            }
        } catch (NumberFormatException e) {
            // Handle invalid ID format
            response.sendRedirect("UserList.jsp?error=invalididformat");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading user for edit: " + e.getMessage(), e);
        }
    }
}