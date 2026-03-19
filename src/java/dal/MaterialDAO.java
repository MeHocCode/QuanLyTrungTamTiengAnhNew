package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Material;
import models.Class;
import models.Teacher;
import models.User;

public class MaterialDAO extends DBContext {
    
    // CREATE
    public boolean createMaterial(Material material) {
        String sql = "INSERT INTO materials (class_id, uploaded_by, filename, url) "
                   + "VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, material.getClassId());
            ps.setInt(2, material.getUploadedBy());
            ps.setString(3, material.getFilename());
            ps.setString(4, material.getUrl());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    material.setMaterialId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Material getMaterialById(int materialId) {
        String sql = "SELECT * FROM materials WHERE material_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, materialId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToMaterial(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Material> getAllMaterials() {
        String sql = "SELECT * FROM materials ORDER BY created_at DESC";
        List<Material> materials = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                materials.add(mapResultSetToMaterial(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }
    
    // UPDATE
    public boolean updateMaterial(Material material) {
        String sql = "UPDATE materials SET class_id = ?, uploaded_by = ?, filename = ?, url = ? "
                   + "WHERE material_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, material.getClassId());
            ps.setInt(2, material.getUploadedBy());
            ps.setString(3, material.getFilename());
            ps.setString(4, material.getUrl());
            ps.setInt(5, material.getMaterialId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteMaterial(int materialId) {
        String sql = "DELETE FROM materials WHERE material_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, materialId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get materials by class
     */
    public List<Material> getMaterialsByClassId(int classId) {
        String sql = "SELECT m.*, u.name as teacher_name, u.email as teacher_email "
                   + "FROM materials m "
                   + "JOIN classes c ON m.class_id = c.class_id "
                   + "LEFT JOIN teachers t ON m.uploaded_by = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "WHERE m.class_id = ? "
                   + "ORDER BY m.created_at DESC";
        List<Material> materials = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                materials.add(mapResultSetToMaterialWithTeacher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }
    
    /**
     * Get materials by teacher
     */
    public List<Material> getMaterialsByTeacher(int teacherUserId) {
        String sql = "SELECT m.*, c.title as class_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM materials m "
                   + "JOIN classes c ON m.class_id = c.class_id "
                   + "JOIN teachers t ON m.uploaded_by = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE m.uploaded_by = ? "
                   + "ORDER BY m.created_at DESC";
        List<Material> materials = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teacherUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                materials.add(mapResultSetToMaterialWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }
    
    /**
     * Get materials with full details (class + teacher)
     */
    public List<Material> getMaterialsWithDetails() {
        String sql = "SELECT m.*, c.title as class_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM materials m "
                   + "JOIN classes c ON m.class_id = c.class_id "
                   + "LEFT JOIN teachers t ON m.uploaded_by = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "ORDER BY m.created_at DESC";
        List<Material> materials = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                materials.add(mapResultSetToMaterialWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }
    
    /**
     * Search materials by filename or class title
     */
    public List<Material> searchMaterials(String keyword) {
        String sql = "SELECT m.*, c.title as class_title, u.name as teacher_name "
                   + "FROM materials m "
                   + "JOIN classes c ON m.class_id = c.class_id "
                   + "LEFT JOIN teachers t ON m.uploaded_by = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "WHERE m.filename LIKE ? OR c.title LIKE ? "
                   + "ORDER BY m.created_at DESC";
        List<Material> materials = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                materials.add(mapResultSetToMaterialWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }
    
    /**
     * Get material count by class
     */
    public int getMaterialCountByClass(int classId) {
        String sql = "SELECT COUNT(*) FROM materials WHERE class_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
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
     * Get recent materials (last 7 days)
     */
    public List<Material> getRecentMaterials() {
        String sql = "SELECT m.*, c.title as class_title, u.name as teacher_name "
                   + "FROM materials m "
                   + "JOIN classes c ON m.class_id = c.class_id "
                   + "LEFT JOIN teachers t ON m.uploaded_by = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "WHERE m.created_at >= DATEADD(day, -7, GETDATE()) "
                   + "ORDER BY m.created_at DESC";
        List<Material> materials = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                materials.add(mapResultSetToMaterialWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }
    
    // Helper methods
    
    private Material mapResultSetToMaterial(ResultSet rs) throws SQLException {
        Material material = new Material();
        material.setMaterialId(rs.getInt("material_id"));
        material.setClassId(rs.getInt("class_id"));
        material.setUploadedBy(rs.getInt("uploaded_by"));
        material.setFilename(rs.getString("filename"));
        material.setUrl(rs.getString("url"));
        material.setCreatedAt(rs.getTimestamp("created_at"));
        return material;
    }
    
    private Material mapResultSetToMaterialWithTeacher(ResultSet rs) throws SQLException {
        Material material = mapResultSetToMaterial(rs);
        // Additional teacher info can be stored or returned as needed
        return material;
    }
    
    private Material mapResultSetToMaterialWithDetails(ResultSet rs) throws SQLException {
        Material material = mapResultSetToMaterial(rs);
        // Additional class and teacher info can be stored or returned as needed
        return material;
    }
}
