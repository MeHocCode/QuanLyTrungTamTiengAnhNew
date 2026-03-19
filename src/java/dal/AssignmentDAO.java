package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Assignment;
import models.Class;
import models.Teacher;
import models.User;

public class AssignmentDAO extends DBContext {
    
    // CREATE
    public boolean createAssignment(Assignment assignment) {
        String sql = "INSERT INTO assignments (class_id, teacher_id, title, description, start_date, end_date) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, assignment.getClassId());
            ps.setInt(2, assignment.getTeacherId());
            ps.setString(3, assignment.getTitle());
            ps.setString(4, assignment.getDescription());
            ps.setTimestamp(5, assignment.getStartDate() != null ? new Timestamp(assignment.getStartDate().getTime()) : null);
            ps.setTimestamp(6, assignment.getEndDate() != null ? new Timestamp(assignment.getEndDate().getTime()) : null);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    assignment.setAssignmentId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Assignment getAssignmentById(int assignmentId) {
        String sql = "SELECT * FROM assignments WHERE assignment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToAssignment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Assignment> getAllAssignments() {
        String sql = "SELECT * FROM assignments ORDER BY created_at DESC";
        List<Assignment> assignments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                assignments.add(mapResultSetToAssignment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }
    
    // UPDATE
    public boolean updateAssignment(Assignment assignment) {
        String sql = "UPDATE assignments SET class_id = ?, teacher_id = ?, title = ?, description = ?, "
                   + "start_date = ?, end_date = ? WHERE assignment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignment.getClassId());
            ps.setInt(2, assignment.getTeacherId());
            ps.setString(3, assignment.getTitle());
            ps.setString(4, assignment.getDescription());
            ps.setTimestamp(5, assignment.getStartDate() != null ? new Timestamp(assignment.getStartDate().getTime()) : null);
            ps.setTimestamp(6, assignment.getEndDate() != null ? new Timestamp(assignment.getEndDate().getTime()) : null);
            ps.setInt(7, assignment.getAssignmentId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteAssignment(int assignmentId) {
        String sql = "DELETE FROM assignments WHERE assignment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get assignments by class
     */
    public List<Assignment> getAssignmentsByClassId(int classId) {
        String sql = "SELECT a.*, u.name as teacher_name, u.email as teacher_email "
                   + "FROM assignments a "
                   + "JOIN classes c ON a.class_id = c.class_id "
                   + "JOIN teachers t ON a.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE a.class_id = ? "
                   + "ORDER BY a.start_date DESC";
        List<Assignment> assignments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                assignments.add(mapResultSetToAssignmentWithTeacher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }
    
    /**
     * Get assignments by teacher
     */
    public List<Assignment> getAssignmentsByTeacher(int teacherUserId) {
        String sql = "SELECT a.*, c.title as class_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM assignments a "
                   + "JOIN classes c ON a.class_id = c.class_id "
                   + "JOIN teachers t ON a.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE a.teacher_id = ? "
                   + "ORDER BY a.start_date DESC";
        List<Assignment> assignments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teacherUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                assignments.add(mapResultSetToAssignmentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }
    
    /**
     * Get assignments with full details (class + teacher)
     */
    public List<Assignment> getAssignmentsWithDetails() {
        String sql = "SELECT a.*, c.title as class_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM assignments a "
                   + "JOIN classes c ON a.class_id = c.class_id "
                   + "JOIN teachers t ON a.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "ORDER BY a.created_at DESC";
        List<Assignment> assignments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                assignments.add(mapResultSetToAssignmentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }
    
    /**
     * Get active assignments (not ended)
     */
    public List<Assignment> getActiveAssignments() {
        String sql = "SELECT a.*, c.title as class_title, u.name as teacher_name "
                   + "FROM assignments a "
                   + "JOIN classes c ON a.class_id = c.class_id "
                   + "JOIN teachers t ON a.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE (a.end_date IS NULL OR a.end_date > GETDATE()) "
                   + "ORDER BY a.start_date DESC";
        List<Assignment> assignments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                assignments.add(mapResultSetToAssignmentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }
    
    /**
     * Get assignments by date range
     */
    public List<Assignment> getAssignmentsByDateRange(java.util.Date startDate, java.util.Date endDate) {
        String sql = "SELECT a.*, c.title as class_title, u.name as teacher_name "
                   + "FROM assignments a "
                   + "JOIN classes c ON a.class_id = c.class_id "
                   + "JOIN teachers t ON a.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE a.start_date BETWEEN ? AND ? "
                   + "ORDER BY a.start_date DESC";
        List<Assignment> assignments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, startDate != null ? new Timestamp(startDate.getTime()) : null);
            ps.setTimestamp(2, endDate != null ? new Timestamp(endDate.getTime()) : null);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                assignments.add(mapResultSetToAssignmentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }
    
    /**
     * Get assignment count by class
     */
    public int getAssignmentCountByClass(int classId) {
        String sql = "SELECT COUNT(*) FROM assignments WHERE class_id = ?";
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
     * Get assignment count by teacher
     */
    public int getAssignmentCountByTeacher(int teacherUserId) {
        String sql = "SELECT COUNT(*) FROM assignments WHERE teacher_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teacherUserId);
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
     * Search assignments by title or class title
     */
    public List<Assignment> searchAssignments(String keyword) {
        String sql = "SELECT a.*, c.title as class_title, u.name as teacher_name "
                   + "FROM assignments a "
                   + "JOIN classes c ON a.class_id = c.class_id "
                   + "JOIN teachers t ON a.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE a.title LIKE ? OR c.title LIKE ? "
                   + "ORDER BY a.start_date DESC";
        List<Assignment> assignments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                assignments.add(mapResultSetToAssignmentWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }
    
    // Helper methods
    
    private Assignment mapResultSetToAssignment(ResultSet rs) throws SQLException {
        Assignment assignment = new Assignment();
        assignment.setAssignmentId(rs.getInt("assignment_id"));
        assignment.setClassId(rs.getInt("class_id"));
        assignment.setTeacherId(rs.getInt("teacher_id"));
        assignment.setTitle(rs.getString("title"));
        assignment.setDescription(rs.getString("description"));
        assignment.setStartDate(rs.getTimestamp("start_date"));
        assignment.setEndDate(rs.getTimestamp("end_date"));
        assignment.setCreatedAt(rs.getTimestamp("created_at"));
        return assignment;
    }
    
    private Assignment mapResultSetToAssignmentWithTeacher(ResultSet rs) throws SQLException {
        Assignment assignment = mapResultSetToAssignment(rs);
        // Additional teacher info can be stored or returned as needed
        return assignment;
    }
    
    private Assignment mapResultSetToAssignmentWithDetails(ResultSet rs) throws SQLException {
        Assignment assignment = mapResultSetToAssignment(rs);
        // Additional class and teacher info can be stored or returned as needed
        return assignment;
    }
}
