/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package java;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.model.User;
import java.model.UserDAO;

@WebServlet("/UserEditServlet")
public class UserEditServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User user = new User();
            user.setId(userID);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role); // ✅ this captures the new selected role

            UserDAO dao = new UserDAO();
            dao.updateUser(user); // ✅ make sure this method updates the role column

            response.sendRedirect("UserList.jsp");
        } catch (Exception e) {
            throw new ServletException("Error updating user", e);
        }
    }
}
