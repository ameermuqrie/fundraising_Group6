package controller;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import model.Campaign;
import model.CampaignDAO;

@WebServlet("/updateCampaign")
@MultipartConfig
public class UpdateCampaignServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admin-only access
        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"admin".equals(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        try {
            int campaignID = Integer.parseInt(req.getParameter("campaignID"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            double goal = Double.parseDouble(req.getParameter("goal"));

            Campaign existing = new CampaignDAO().getCampaignById(campaignID);
            if (existing == null) {
                throw new ServletException("Campaign not found with ID: " + campaignID);
            }

            String photoPath = existing.getPhotoPath();

            Part filePart = req.getPart("photo");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (!fileName.isBlank()) {
                    String appPath = req.getServletContext().getRealPath("");
                    String saveDir = appPath + File.separator + UPLOAD_DIR;
                    new File(saveDir).mkdirs();
                    filePart.write(saveDir + File.separator + fileName);
                    photoPath = UPLOAD_DIR + "/" + fileName;
                }
            }

            Campaign updated = new Campaign();
            updated.setCampaignID(campaignID);
            updated.setTitle(title);
            updated.setDescription(description);
            updated.setGoal(goal);
            updated.setPhotoPath(photoPath);

            new CampaignDAO().updateCampaign(updated);
            resp.sendRedirect("viewCampaigns");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Update failed</h3><pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
    }
}
