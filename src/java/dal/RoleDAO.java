package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Role;

public class RoleDAO extends DBContext {
    
    // READ - All
    public List<Role> getAllRoles() {
        String sql = "SELECT * FROM roles ORDER BY role_name ASC";
        List<Role> roles = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                roles.add(mapResultSetToRole(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }
    
    // READ - Single
    public Role getRoleById(int roleId) {
        String sql = "SELECT * FROM roles WHERE role_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToRole(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - By Name
    public Role getRoleByName(String roleName) {
        String sql = "SELECT * FROM roles WHERE role_name = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, roleName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToRole(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get role count
     */
    public int getRoleCount() {
        String sql = "SELECT COUNT(*) FROM roles";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Check if role name exists
     */
    public boolean isRoleNameExists(String roleName) {
        String sql = "SELECT COUNT(*) FROM roles WHERE role_name = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, roleName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Search roles by name or description
     */
    public List<Role> searchRoles(String keyword) {
        String sql = "SELECT * FROM roles WHERE role_name LIKE ? OR description LIKE ? ORDER BY role_name ASC";
        List<Role> roles = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(mapResultSetToRole(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }
    
    // Helper methods
    
    private Role mapResultSetToRole(ResultSet rs) throws SQLException {
        int roleId = rs.getInt("role_id");
        String roleName = rs.getString("role_name");
        
        // Map role_id to Role enum
        return Role.fromRoleId(roleId);
    }
}
