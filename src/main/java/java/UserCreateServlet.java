package java;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.model.User;
import java.model.UserDAO;

@WebServlet(urlPatterns = {"/UserCreateServlet"})
public class UserCreateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        try {
            new UserDAO().insertUser(user);  // Save to DB
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // Save user in session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // Redirect based on role
        if ("admin".equalsIgnoreCase(role)) {
            response.sendRedirect("UserListServlet");
        } else {
            response.sendRedirect("user_dashboard.jsp");
        }
    }
}
