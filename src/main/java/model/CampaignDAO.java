package model;

import java.sql.*;
import java.util.*;

public class CampaignDAO {

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
        } catch (ClassNotFoundException ex) {
            throw new SQLException("MySQL JDBC Driver not found. Add it to your project libraries.", ex);
        }
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/fundraising", "root", "admin");
    }

    // Create a new campaign
    public int createCampaign(Campaign c) throws SQLException {
        String sql = "INSERT INTO campaigns (title, description, goal, creator_id, photo_path) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, c.getTitle());
            ps.setString(2, c.getDescription());
            ps.setDouble(3, c.getGoal());
            ps.setInt(4, c.getCreatorId());
            ps.setString(5, c.getPhotoPath());

            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Creating campaign failed, no rows affected.");
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
            return 0;
        }
    }

    // Get all campaigns
    public List<Campaign> getAllCampaigns() throws SQLException {
        List<Campaign> list = new ArrayList<>();
        String sql = "SELECT * FROM campaigns ORDER BY created_at DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignID(rs.getInt("campaignID")); // ✅ Ensure your DB column is named 'campaignID'
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoal(rs.getDouble("goal"));
                c.setCreatorId(rs.getInt("creator_id"));
                c.setPhotoPath(rs.getString("photo_path"));
                list.add(c);
            }
        }
        return list;
    }

    // Get a campaign by ID
    public Campaign getCampaignById(int campaignID) {
        Campaign c = null;
        String sql = "SELECT * FROM campaigns WHERE campaignID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, campaignID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                c = new Campaign();
                c.setCampaignID(rs.getInt("campaignID"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoal(rs.getDouble("goal"));
                c.setCreatorId(rs.getInt("creator_id"));
                c.setPhotoPath(rs.getString("photo_path"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return c;
    }

    // Update a campaign
    public void updateCampaign(Campaign campaign) {
        String sql = "UPDATE campaigns SET title=?, description=?, goal=?, photo_path=? WHERE campaignID=?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, campaign.getTitle());
            stmt.setString(2, campaign.getDescription());
            stmt.setDouble(3, campaign.getGoal());
            stmt.setString(4, campaign.getPhotoPath());
            stmt.setInt(5, campaign.getCampaignID());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a campaign
    public void deleteCampaign(int campaignID) {
        String sql = "DELETE FROM campaigns WHERE campaignID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, campaignID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
