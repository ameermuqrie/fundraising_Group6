
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.User;
import model.UserDAO;

@WebServlet(urlPatterns = {"/UserCreateServlet"})
public class UserCreateServlet extends HttpServlet {

     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setEmail(email);
        user.setPassword(password); // In a real application, hash this password!
        user.setRole(role);

        try {
            UserDAO userDAO = new UserDAO();
            // Check if user already exists (optional but good practice for registration)
            if (userDAO.getUserByEmailAndPassword(email, password) != null) {
                request.setAttribute("error", "Email already registered. Please use a different email or login.");
                request.getRequestDispatcher("UserForm.jsp").forward(request, response);
                return; // Stop further processing
            }
            userDAO.insertUser(user);  // Save to DB
            // No need to save the user in session immediately after registration,
            // as they need to log in first.
            // HttpSession session = request.getSession();
            // session.setAttribute("user", user);

            // *** IMPORTANT CHANGE HERE ***
            // After successful registration, redirect to the login page.
            response.sendRedirect("Login.jsp");

        } catch (SQLException e) {
            // Log the exception for debugging purposes (e.g., using a logging framework)
            e.printStackTrace();
            // Set an error message and forward back to the registration form
            request.setAttribute("error", "Error registering user: " + e.getMessage());
            request.getRequestDispatcher("UserForm.jsp").forward(request, response);
        }
    }
}