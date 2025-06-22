package controller;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import model.Campaign;
import model.CampaignDAO;

@WebServlet("/createCampaign")
@MultipartConfig
public class CreateCampaignServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Restrict to admin only
        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"admin".equals(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        double goal = Double.parseDouble(req.getParameter("goal"));
        int creatorId = 1; // Hardcoded, replace with actual session user ID

        Part filePart = req.getPart("photo");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String photoPath = null;

        if (!fileName.isBlank()) {
            String appPath = req.getServletContext().getRealPath("");
            String saveDir = appPath + File.separator + UPLOAD_DIR;
            new File(saveDir).mkdirs();
            filePart.write(saveDir + File.separator + fileName);
            photoPath = UPLOAD_DIR + "/" + fileName;
        }

        Campaign c = new Campaign();
        c.setTitle(title);
        c.setDescription(description);
        c.setGoal(goal);
        c.setCreatorId(creatorId);
        c.setPhotoPath(photoPath);

        try {
            new CampaignDAO().createCampaign(c);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }

        resp.sendRedirect("viewCampaigns");
    }
}
