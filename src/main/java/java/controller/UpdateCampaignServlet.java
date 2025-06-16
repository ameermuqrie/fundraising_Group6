package java.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.nio.file.Paths;
import java.model.Campaign;
import java.model.CampaignDAO;

@WebServlet("/updateCampaign")
@MultipartConfig
public class UpdateCampaignServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        try {
            // Get form data
            int campaignID = Integer.parseInt(req.getParameter("campaignID")); // should match input name
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            double goal = Double.parseDouble(req.getParameter("goal"));

            // Fetch existing campaign
            Campaign existing = new CampaignDAO().getCampaignById(campaignID);
            if (existing == null) {
                throw new ServletException("Campaign not found with ID: " + campaignID);
            }

            String photoPath = existing.getPhotoPath();

            // Handle uploaded file
            Part filePart = req.getPart("photo");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (!fileName.isBlank()) {
                    String appPath = req.getServletContext().getRealPath("");
                    String saveDir = appPath + File.separator + UPLOAD_DIR;
                    new File(saveDir).mkdirs(); // ensure directory exists
                    filePart.write(saveDir + File.separator + fileName);
                    photoPath = UPLOAD_DIR + "/" + fileName;
                }
            }

            // Prepare updated Campaign
            Campaign updated = new Campaign();
            updated.setCampaignID(campaignID);
            updated.setTitle(title);
            updated.setDescription(description);
            updated.setGoal(goal);
            updated.setPhotoPath(photoPath);

            // Persist to DB
            new CampaignDAO().updateCampaign(updated);

            // Redirect on success
            resp.sendRedirect("viewCampaigns");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Update failed</h3>");
            out.println("<pre>");
            e.printStackTrace(out); // print full error to browser
            out.println("</pre>");
        }
    }
}

