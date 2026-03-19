package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Grade;
import models.Submission;
import models.Student;
import models.User;

public class GradeDAO extends DBContext {
    
    // CREATE
    public boolean createGrade(Grade grade) {
        String sql = "INSERT INTO grades (submission_id, score, feedback, graded_at) "
                   + "VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, grade.getSubmissionId());
            ps.setDouble(2, grade.getScore());
            ps.setString(3, grade.getFeedback());
            ps.setTimestamp(4, grade.getGradedAt() != null ? new Timestamp(grade.getGradedAt().getTime()) : new Timestamp(System.currentTimeMillis()));
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    grade.setGradeId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Grade getGradeById(int gradeId) {
        String sql = "SELECT * FROM grades WHERE grade_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, gradeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToGrade(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Grade> getAllGrades() {
        String sql = "SELECT * FROM grades ORDER BY graded_at DESC";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                grades.add(mapResultSetToGrade(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }
    
    // UPDATE
    public boolean updateGrade(Grade grade) {
        String sql = "UPDATE grades SET submission_id = ?, score = ?, feedback = ?, graded_at = ? "
                   + "WHERE grade_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, grade.getSubmissionId());
            ps.setDouble(2, grade.getScore());
            ps.setString(3, grade.getFeedback());
            ps.setTimestamp(4, grade.getGradedAt() != null ? new Timestamp(grade.getGradedAt().getTime()) : null);
            ps.setInt(5, grade.getGradeId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteGrade(int gradeId) {
        String sql = "DELETE FROM grades WHERE grade_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, gradeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get grades by student
     */
    public List<Grade> getGradesByStudentId(int studentId) {
        String sql = "SELECT g.*, s.title as assignment_title, u.name as student_name "
                   + "FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "JOIN assignments a ON sub.assignment_id = a.assignment_id "
                   + "JOIN students st ON sub.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE sub.student_id = ? "
                   + "ORDER BY g.graded_at DESC";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                grades.add(mapResultSetToGradeWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }
    
    /**
     * Get grades by assignment
     */
    public List<Grade> getGradesByAssignmentId(int assignmentId) {
        String sql = "SELECT g.*, a.title as assignment_title, u.name as student_name, u.email as student_email "
                   + "FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "JOIN assignments a ON sub.assignment_id = a.assignment_id "
                   + "JOIN students st ON sub.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE sub.assignment_id = ? "
                   + "ORDER BY g.graded_at DESC";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                grades.add(mapResultSetToGradeWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }
    
    /**
     * Get grades with full details (assignment + student)
     */
    public List<Grade> getGradesWithDetails() {
        String sql = "SELECT g.*, a.title as assignment_title, u.name as student_name, u.email as student_email "
                   + "FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "JOIN assignments a ON sub.assignment_id = a.assignment_id "
                   + "JOIN students st ON sub.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "ORDER BY g.graded_at DESC";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                grades.add(mapResultSetToGradeWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }
    
    /**
     * Get average grade by assignment
     */
    public double getAverageGradeByAssignment(int assignmentId) {
        String sql = "SELECT AVG(g.score) as avg_score FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "JOIN assignments a ON sub.assignment_id = a.assignment_id "
                   + "WHERE sub.assignment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("avg_score");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    /**
     * Get grade count by student
     */
    public int getGradeCountByStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "WHERE sub.student_id = ?";
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
    
    /**
     * Get grade count by assignment
     */
    public int getGradeCountByAssignment(int assignmentId) {
        String sql = "SELECT COUNT(*) FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "WHERE sub.assignment_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
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
     * Get recent grades (last 30 days)
     */
    public List<Grade> getRecentGrades() {
        String sql = "SELECT g.*, a.title as assignment_title, u.name as student_name, u.email as student_email "
                   + "FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "JOIN assignments a ON sub.assignment_id = a.assignment_id "
                   + "JOIN students st ON sub.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE g.graded_at >= DATEADD(day, -30, GETDATE()) "
                   + "ORDER BY g.graded_at DESC";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                grades.add(mapResultSetToGradeWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }
    
    /**
     * Search grades by student name or assignment title
     */
    public List<Grade> searchGrades(String keyword) {
        String sql = "SELECT g.*, a.title as assignment_title, u.name as student_name, u.email as student_email "
                   + "FROM grades g "
                   + "JOIN submissions sub ON g.submission_id = sub.submission_id "
                   + "JOIN assignments a ON sub.assignment_id = a.assignment_id "
                   + "JOIN students st ON sub.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE a.title LIKE ? OR u.name LIKE ? "
                   + "ORDER BY g.graded_at DESC";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                grades.add(mapResultSetToGradeWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }
    
    // Helper methods
    
    private Grade mapResultSetToGrade(ResultSet rs) throws SQLException {
        Grade grade = new Grade();
        grade.setGradeId(rs.getInt("grade_id"));
        grade.setSubmissionId(rs.getInt("submission_id"));
        grade.setScore(rs.getDouble("score"));
        grade.setFeedback(rs.getString("feedback"));
        grade.setGradedAt(rs.getTimestamp("graded_at"));
        return grade;
    }
    
    private Grade mapResultSetToGradeWithDetails(ResultSet rs) throws SQLException {
        Grade grade = mapResultSetToGrade(rs);
        // Additional assignment and student info can be stored or returned as needed
        return grade;
    }
}
