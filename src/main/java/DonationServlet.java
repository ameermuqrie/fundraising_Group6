import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/DonationServlet")
public class DonationServlet extends HttpServlet {
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- IMPORTANT SECURITY NOTE: ---
        // Retrieving userID directly from a form input is highly insecure for production applications.
        // A malicious user could easily impersonate another user.
        // For a real-world application, userID MUST be obtained securely from the user's session
        // after they have successfully logged in.
        // This modification is done to fulfill the user's specific request for direct input.
        // --- END SECURITY NOTE ---

        int userID;
        int campaignID;
        double amount;

        // Get PrintWriter for error messages early
        PrintWriter out = response.getWriter();
        response.setContentType("text/html"); // Set content type for error pages

        try {
            // Get userID from the form input (as requested by the user)
            userID = Integer.parseInt(request.getParameter("userID"));
            campaignID = Integer.parseInt(request.getParameter("campaignID"));
            amount = Double.parseDouble(request.getParameter("amount"));
        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
            out.println("<html><body>");
            out.println("<h2>Input Error: User ID, Campaign ID, or Amount is not a valid number.</h2>");
            out.println("<p>Please ensure you enter numbers for User ID, Campaign ID, and Amount.</p>");
            out.println("<p><a href='donationForm.jsp'>Go Back to Donate Page</a></p>"); // Link back to the donation form
            out.println("</body></html>");
            return; // Stop further execution
        }

        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement checkUserPs = null; // For checking if userID exists
        ResultSet rs = null; // For result of user ID check

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");

            // Step 1: Verify if the provided User ID exists in the 'users' table
            checkUserPs = con.prepareStatement("SELECT userID FROM users WHERE userID = ?");
            checkUserPs.setInt(1, userID);
            rs = checkUserPs.executeQuery();

            if (!rs.next()) { // If no user with the given userID is found
                out.println("<html><body>");
                out.println("<h2>Error: User with ID " + userID + " does not exist.</h2>");
                out.println("<p>Please enter a valid User ID or <a href='Login.jsp'>Log In</a>.</p>");
                out.println("<p><a href='index.html'>Go Back to Donate Page</a></p>");
                out.println("</body></html>");
                return; // Stop execution if userID is invalid
            }
            // Close ResultSet and PreparedStatement for the check immediately
            rs.close();
            checkUserPs.close();


            // Step 2: Insert the donation into the 'donations' table
            ps = con.prepareStatement(
                "INSERT INTO donations (userID, campaignID, amount) VALUES (?, ?, ?)"
            );
            ps.setInt(1, userID);
            ps.setInt(2, campaignID);
            ps.setDouble(3, amount);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // Donation successful, redirect to donationHistory.jsp
                // Adjust path if donationHistory.jsp is in a subfolder like 'views/'
                response.sendRedirect("donationHistory.jsp");
            } else {
                out.println("<html><body>");
                out.println("<h2>Error: Failed to record donation. No rows affected.</h2>");
                out.println("<p>The donation could not be processed. Please try again.</p>");
                out.println("<p><a href='index.html'>Go Back to Donate Page</a></p>");
                out.println("</body></html>");
            }
        } catch (SQLException se) {
            se.printStackTrace();
            // Check for specific foreign key constraint violation error code if needed
            // For MySQL, it's typically 1452
            if (se.getErrorCode() == 1452) { // Foreign key constraint fails
                 out.println("<html><body>");
                 out.println("<h2>Database Error: Invalid Campaign ID or User ID.</h2>");
                 out.println("<p>The Campaign ID you entered might not exist, or there was an issue with the User ID.</p>");
                 out.println("<p><a href='index.html'>Go Back to Donate Page</a></p>");
                 out.println("</body></html>");
            } else {
                out.println("<html><body>");
                out.println("<h2>Database Error: " + se.getMessage() + "</h2>");
                out.println("<p>There was a problem connecting to or interacting with the database. Please contact support.</p>");
                out.println("<p><a href='index.html'>Go Back to Donate Page</a></p>");
                out.println("</body></html>");
            }
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            out.println("<html><body>");
            out.println("<h2>JDBC Driver Error: " + cnfe.getMessage() + "</h2>");
            out.println("<p>The database driver was not found. Please ensure 'mysql-connector-java.jar' is in your classpath.</p>");
            out.println("<p><a href='index.html'>Go Back to Donate Page</a></p>");
            out.println("</body></html>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<html><body>");
            out.println("<h2>An unexpected error occurred: " + e.getMessage() + "</h2>");
            out.println("<p>Something went wrong. Please try again later.</p>");
            out.println("<p><a href='index.html'>Go Back to Donate Page</a></p>");
            out.println("</body></html>");
        } finally {
            // Close resources in reverse order of opening
            try {
                if (rs != null) rs.close();
            } catch (SQLException se) { se.printStackTrace(); }
            try {
                if (checkUserPs != null) checkUserPs.close();
            } catch (SQLException se) { se.printStackTrace(); }
            try {
                if (ps != null) ps.close();
            } catch (SQLException se) { se.printStackTrace(); }
            try {
                if (con != null) con.close();
            } catch (SQLException se) { se.printStackTrace(); }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This is typically used for direct access to the JSP for display.
        // Ensure the path is correct relative to your web application context root.
        response.sendRedirect("views/donationHistory.jsp");
    }
}
