/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package java.controller;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.model.Campaign;
import java.model.CampaignDAO;

@WebServlet("/createCampaign")
@MultipartConfig                       // <-- enables file upload
public class CreateCampaignServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        /* ---------- read regular fields ---------- */
        String title       = req.getParameter("title");
        String description = req.getParameter("description");
        double goal        = Double.parseDouble(req.getParameter("goal"));
        int    creatorId   = 1;                        // static for now

        /* ---------- handle file upload ---------- */
        Part filePart = req.getPart("photo");         // <input name="photo">
        String fileName = Paths.get(filePart.getSubmittedFileName())
                               .getFileName().toString();  // MSIE fix
        String photoPath = null;

        if (!fileName.isBlank()) {
            String appPath   = req.getServletContext().getRealPath("");
            String saveDir   = appPath + File.separator + UPLOAD_DIR;
            new File(saveDir).mkdirs();               // create /uploads if missing
            filePart.write(saveDir + File.separator + fileName);
            photoPath = UPLOAD_DIR + "/" + fileName;  // relative path for <img>
        }

        /* ---------- build & save bean ---------- */
        Campaign c = new Campaign();
        c.setTitle(title);
        c.setDescription(description);
        c.setGoal(goal);
        c.setCreatorId(creatorId);
        c.setPhotoPath(photoPath);     // may be null

        try {
            new CampaignDAO().createCampaign(c);
        } catch (Exception ex) { throw new ServletException(ex); }

        resp.sendRedirect("viewCampaigns");
    }
}