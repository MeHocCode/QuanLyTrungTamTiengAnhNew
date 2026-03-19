package dal;

import dto.EnrollmentDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Enrollment;

public class EnrollmentDAO extends DBContext {
    
    // CREATE
    public boolean createEnrollment(Enrollment enrollment) {
        String sql = "INSERT INTO enrollments (student_id, class_id, status) "
                   + "VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, enrollment.getStudentId());
            ps.setInt(2, enrollment.getClassId());
            ps.setString(3, enrollment.getStatus());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    enrollment.setEnrollmentId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Enrollment getEnrollmentById(int enrollmentId) {
        String sql = "SELECT * FROM enrollments WHERE enrollment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToEnrollment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Enrollment> getAllEnrollments() {
        String sql = "SELECT * FROM enrollments ORDER BY enrolled_at DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                enrollments.add(mapResultSetToEnrollment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }
    
    // UPDATE
    public boolean updateEnrollment(Enrollment enrollment) {
        String sql = "UPDATE enrollments SET student_id = ?, class_id = ?, status = ? "
                   + "WHERE enrollment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollment.getStudentId());
            ps.setInt(2, enrollment.getClassId());
            ps.setString(3, enrollment.getStatus());
            ps.setInt(4, enrollment.getEnrollmentId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteEnrollment(int enrollmentId) {
        String sql = "DELETE FROM enrollments WHERE enrollment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // STATUS MANAGEMENT
    
    /**
     * Approve enrollment
     */
    public boolean approveEnrollment(int enrollmentId) {
        String sql = "UPDATE enrollments SET status = 'APPROVED' WHERE enrollment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Reject enrollment
     */
    public boolean rejectEnrollment(int enrollmentId) {
        String sql = "UPDATE enrollments SET status = 'REJECTED' WHERE enrollment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Cancel enrollment
     */
    public boolean cancelEnrollment(int enrollmentId) {
        String sql = "UPDATE enrollments SET status = 'CANCELLED' WHERE enrollment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get enrollments by student (with user info)
     */
    public List<Enrollment> getEnrollmentsByStudentId(int studentId) {
        String sql = "SELECT e.*, u.name as student_name, u.email as student_email, u.phone as student_phone "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE e.student_id = ? "
                   + "ORDER BY e.enrolled_at DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                enrollments.add(mapResultSetToEnrollmentWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }
    
    /**
     * Get enrollments by class
     */
    public List<Enrollment> getEnrollmentsByClassId(int classId) {
        String sql = "SELECT e.*, s.name as student_name, u.email as student_email "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE e.class_id = ? "
                   + "ORDER BY e.enrolled_at DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                enrollments.add(mapResultSetToEnrollmentWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }
    
    /**
     * Get pending enrollments
     */
    public List<Enrollment> getPendingEnrollments() {
        String sql = "SELECT e.*, s.name as student_name, u.email as student_email, u.phone as student_phone "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE e.status = 'PENDING' "
                   + "ORDER BY e.enrolled_at DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                enrollments.add(mapResultSetToEnrollmentWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }
    
    /**
     * Get approved enrollments
     */
    public List<Enrollment> getApprovedEnrollments() {
        String sql = "SELECT e.*, s.name as student_name, u.email as student_email "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE e.status = 'APPROVED' "
                   + "ORDER BY e.enrolled_at DESC";
        List<Enrollment> enrollments = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                enrollments.add(mapResultSetToEnrollmentWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }
    
    /**
     * Get enrollment count by class
     */
    public int getEnrollmentCountByClass(int classId) {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE class_id = ? AND status = 'APPROVED'";
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
     * Get enrollment count by student
     */
    public int getEnrollmentCountByStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND status = 'APPROVED'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // DTO OPERATIONS
    
    /**
     * Get all enrollments with full details
     */
    public List<EnrollmentDTO> getAllEnrollmentDTOs() {
        String sql = "SELECT e.*, s.name as student_name, s.email as student_email, s.phone as student_phone, "
                   + "c.class_id, co.title as course_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "JOIN classes c ON e.class_id = c.class_id "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users tu ON t.user_id = tu.user_id "
                   + "ORDER BY e.enrolled_at DESC";
        List<EnrollmentDTO> enrollmentDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                enrollmentDTOs.add(mapResultSetToEnrollmentDTO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollmentDTOs;
    }
    
    /**
     * Get enrollments by student ID with full details
     */
    public List<EnrollmentDTO> getEnrollmentDTOsByStudentId(int studentId) {
        String sql = "SELECT e.*, s.name as student_name, s.email as student_email, s.phone as student_phone, "
                   + "c.class_id, co.title as course_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "JOIN classes c ON e.class_id = c.class_id "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users tu ON t.user_id = tu.user_id "
                   + "WHERE e.student_id = ? "
                   + "ORDER BY e.enrolled_at DESC";
        List<EnrollmentDTO> enrollmentDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                enrollmentDTOs.add(mapResultSetToEnrollmentDTO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollmentDTOs;
    }
    
    /**
     * Get enrollments by class ID with full details
     */
    public List<EnrollmentDTO> getEnrollmentDTOsByClassId(int classId) {
        String sql = "SELECT e.*, s.name as student_name, s.email as student_email, s.phone as student_phone, "
                   + "c.class_id, co.title as course_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "JOIN classes c ON e.class_id = c.class_id "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users tu ON t.user_id = tu.user_id "
                   + "WHERE e.class_id = ? "
                   + "ORDER BY e.enrolled_at DESC";
        List<EnrollmentDTO> enrollmentDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                enrollmentDTOs.add(mapResultSetToEnrollmentDTO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollmentDTOs;
    }
    
    /**
     * Get pending enrollment DTOs
     */
    public List<EnrollmentDTO> getPendingEnrollmentDTOs() {
        String sql = "SELECT e.*, s.name as student_name, s.email as student_email, s.phone as student_phone, "
                   + "c.class_id, co.title as course_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM enrollments e "
                   + "JOIN students s ON e.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "JOIN classes c ON e.class_id = c.class_id "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users tu ON t.user_id = tu.user_id "
                   + "WHERE e.status = 'PENDING' "
                   + "ORDER BY e.enrolled_at DESC";
        List<EnrollmentDTO> enrollmentDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                enrollmentDTOs.add(mapResultSetToEnrollmentDTO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollmentDTOs;
    }
    
    // Helper methods
    
    private Enrollment mapResultSetToEnrollment(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
        enrollment.setStudentId(rs.getInt("student_id"));
        enrollment.setClassId(rs.getInt("class_id"));
        enrollment.setStatus(rs.getString("status"));
        enrollment.setEnrolledAt(rs.getTimestamp("enrolled_at"));
        return enrollment;
    }
    
    private Enrollment mapResultSetToEnrollmentWithStudent(ResultSet rs) throws SQLException {
        Enrollment enrollment = mapResultSetToEnrollment(rs);
        // Additional student info can be stored or returned as needed
        return enrollment;
    }
    
    private EnrollmentDTO mapResultSetToEnrollmentDTO(ResultSet rs) throws SQLException {
        EnrollmentDTO enrollmentDTO = new EnrollmentDTO();
        enrollmentDTO.setEnrollmentId(rs.getInt("enrollment_id"));
        enrollmentDTO.setStudentId(rs.getInt("student_id"));
        enrollmentDTO.setClassId(rs.getInt("class_id"));
        enrollmentDTO.setStatus(rs.getString("status"));
        enrollmentDTO.setEnrolledAt(rs.getTimestamp("enrolled_at"));
        enrollmentDTO.setStudentName(rs.getString("student_name"));
        enrollmentDTO.setStudentEmail(rs.getString("student_email"));
        enrollmentDTO.setStudentPhone(rs.getString("student_phone"));
        enrollmentDTO.setCourseTitle(rs.getString("course_title"));
        enrollmentDTO.setTeacherName(rs.getString("teacher_name"));
        enrollmentDTO.setTeacherEmail(rs.getString("teacher_email"));
        return enrollmentDTO;
    }
}
