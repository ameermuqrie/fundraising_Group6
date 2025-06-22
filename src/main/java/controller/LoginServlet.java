package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import model.User;
import model.UserDAO;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.getUserByEmailAndPassword(email, password);

        if (user != null && user.getRole() != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole().toLowerCase()); // ✅ This line is important

            String role = user.getRole().toLowerCase();

            if (role.equals("admin")) {
                response.sendRedirect("admin_dashboard.jsp");
            } else if (role.equals("fundraiser")) {
                response.sendRedirect("user_dashboard.jsp");
            } else {
                request.setAttribute("error", "Unknown role: " + role);
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
