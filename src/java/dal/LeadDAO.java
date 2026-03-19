package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Lead;

public class LeadDAO extends DBContext {
    
    // CREATE
    public boolean createLead(Lead lead) {
        String sql = "INSERT INTO leads (name, email, phone, note, status, created_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, lead.getName());
            ps.setString(2, lead.getEmail());
            ps.setString(3, lead.getPhone());
            ps.setString(4, lead.getNote());
            ps.setString(5, lead.getStatus());
            ps.setTimestamp(6, lead.getCreatedAt() != null ? new Timestamp(lead.getCreatedAt().getTime()) : new Timestamp(System.currentTimeMillis()));
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    lead.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Lead getLeadById(int leadId) {
        String sql = "SELECT * FROM leads WHERE lead_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, leadId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToLead(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Lead> getAllLeads() {
        String sql = "SELECT * FROM leads ORDER BY created_at DESC";
        List<Lead> leads = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                leads.add(mapResultSetToLead(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leads;
    }
    
    // UPDATE
    public boolean updateLead(Lead lead) {
        String sql = "UPDATE leads SET name = ?, email = ?, phone = ?, note = ?, status = ? "
                   + "WHERE lead_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, lead.getName());
            ps.setString(2, lead.getEmail());
            ps.setString(3, lead.getPhone());
            ps.setString(4, lead.getNote());
            ps.setString(5, lead.getStatus());
            ps.setInt(6, lead.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteLead(int leadId) {
        String sql = "DELETE FROM leads WHERE lead_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, leadId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get leads by status
     */
    public List<Lead> getLeadsByStatus(String status) {
        String sql = "SELECT * FROM leads WHERE status = ? ORDER BY created_at DESC";
        List<Lead> leads = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                leads.add(mapResultSetToLead(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leads;
    }
    
    /**
     * Get leads by course interest
     */
    public List<Lead> getLeadsByCourseInterest(String courseInterest) {
        String sql = "SELECT * FROM leads WHERE note = ? ORDER BY created_at DESC";
        List<Lead> leads = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, courseInterest);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                leads.add(mapResultSetToLead(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leads;
    }
    
    /**
     * Get new leads (last 7 days)
     */
    public List<Lead> getNewLeads() {
        String sql = "SELECT * FROM leads WHERE created_at >= DATEADD(day, -7, GETDATE()) ORDER BY created_at DESC";
        List<Lead> leads = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                leads.add(mapResultSetToLead(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leads;
    }
    
    /**
     * Get lead count by status
     */
    public int getLeadCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM leads WHERE status = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Search leads by name, email, or course interest
     */
    public List<Lead> searchLeads(String keyword) {
        String sql = "SELECT * FROM leads WHERE name LIKE ? OR email LIKE ? OR note LIKE ? "
                   + "ORDER BY created_at DESC";
        List<Lead> leads = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                leads.add(mapResultSetToLead(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leads;
    }
    
    /**
     * Get recent leads (last 30 days)
     */
    public List<Lead> getRecentLeads() {
        String sql = "SELECT * FROM leads WHERE created_at >= DATEADD(day, -30, GETDATE()) ORDER BY created_at DESC";
        List<Lead> leads = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                leads.add(mapResultSetToLead(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leads;
    }
    
    /**
     * Update lead status
     */
    public boolean updateLeadStatus(int leadId, String status) {
        String sql = "UPDATE leads SET status = ? WHERE lead_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, leadId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper methods
    
    private Lead mapResultSetToLead(ResultSet rs) throws SQLException {
        Lead lead = new Lead();
        lead.setId(rs.getInt("lead_id"));
        lead.setName(rs.getString("name"));
        lead.setEmail(rs.getString("email"));
        lead.setPhone(rs.getString("phone"));
        lead.setNote(rs.getString("note"));
        lead.setStatus(rs.getString("status"));
        lead.setCreatedAt(rs.getTimestamp("created_at"));
        return lead;
    }
}
