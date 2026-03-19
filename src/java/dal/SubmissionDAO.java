package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Submission;
import models.Assignment;
import models.Student;
import models.User;

public class SubmissionDAO extends DBContext {
    
    // CREATE
    public boolean submitAssignment(Submission submission) {
        String sql = "INSERT INTO submissions (assignment_id, student_id, file_url, submitted_at) "
                   + "VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, submission.getAssignmentId());
            ps.setInt(2, submission.getStudentId());
            ps.setString(3, submission.getFileUrl());
            ps.setTimestamp(4, submission.getSubmittedAt() != null ? new Timestamp(submission.getSubmittedAt().getTime()) : new Timestamp(System.currentTimeMillis()));
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    submission.setSubmissionId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Submission getSubmissionById(int submissionId) {
        String sql = "SELECT * FROM submissions WHERE submission_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, submissionId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToSubmission(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Submission> getAllSubmissions() {
        String sql = "SELECT * FROM submissions ORDER BY submitted_at DESC";
        List<Submission> submissions = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                submissions.add(mapResultSetToSubmission(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }
    
    // UPDATE
    public boolean updateSubmission(Submission submission) {
        String sql = "UPDATE submissions SET assignment_id = ?, student_id = ?, file_url = ?, submitted_at = ? "
                   + "WHERE submission_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, submission.getAssignmentId());
            ps.setInt(2, submission.getStudentId());
            ps.setString(3, submission.getFileUrl());
            ps.setTimestamp(4, submission.getSubmittedAt() != null ? new Timestamp(submission.getSubmittedAt().getTime()) : null);
            ps.setInt(5, submission.getSubmissionId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteSubmission(int submissionId) {
        String sql = "DELETE FROM submissions WHERE submission_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, submissionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // GRADING METHODS
    
    /**
     * Grade submission
     */
    public boolean gradeSubmission(int submissionId, double score, String feedback) {
        String sql = "UPDATE submissions SET grade = ?, feedback = ? WHERE submission_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, score);
            ps.setString(2, feedback);
            ps.setInt(3, submissionId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get submissions by assignment
     */
    public List<Submission> getSubmissionsByAssignmentId(int assignmentId) {
        String sql = "SELECT s.*, u.name as student_name, u.email as student_email "
                   + "FROM submissions s "
                   + "JOIN students st ON s.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE s.assignment_id = ? "
                   + "ORDER BY s.submitted_at DESC";
        List<Submission> submissions = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                submissions.add(mapResultSetToSubmissionWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }
    
    /**
     * Get submissions by student
     */
    public List<Submission> getSubmissionsByStudentId(int studentId) {
        String sql = "SELECT s.*, a.title as assignment_title, a.description as assignment_description "
                   + "FROM submissions s "
                   + "JOIN assignments a ON s.assignment_id = a.assignment_id "
                   + "JOIN students st ON s.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE s.student_id = ? "
                   + "ORDER BY s.submitted_at DESC";
        List<Submission> submissions = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                submissions.add(mapResultSetToSubmissionWithAssignment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }
    
    /**
     * Get submissions with full details (assignment + student)
     */
    public List<Submission> getSubmissionsWithDetails() {
        String sql = "SELECT s.*, a.title as assignment_title, a.description as assignment_description, "
                   + "u.name as student_name, u.email as student_email "
                   + "FROM submissions s "
                   + "JOIN assignments a ON s.assignment_id = a.assignment_id "
                   + "JOIN students st ON s.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "ORDER BY s.submitted_at DESC";
        List<Submission> submissions = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                submissions.add(mapResultSetToSubmissionWithFullDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }
    
    /**
     * Get graded submissions
     */
    public List<Submission> getGradedSubmissions() {
        String sql = "SELECT s.*, a.title as assignment_title, u.name as student_name, u.email as student_email "
                   + "FROM submissions s "
                   + "JOIN assignments a ON s.assignment_id = a.assignment_id "
                   + "JOIN students st ON s.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE s.grade IS NOT NULL "
                   + "ORDER BY s.submitted_at DESC";
        List<Submission> submissions = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                submissions.add(mapResultSetToSubmissionWithFullDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }
    
    /**
     * Get ungraded submissions
     */
    public List<Submission> getUngradedSubmissions() {
        String sql = "SELECT s.*, a.title as assignment_title, u.name as student_name, u.email as student_email "
                   + "FROM submissions s "
                   + "JOIN assignments a ON s.assignment_id = a.assignment_id "
                   + "JOIN students st ON s.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE s.grade IS NULL "
                   + "ORDER BY s.submitted_at DESC";
        List<Submission> submissions = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                submissions.add(mapResultSetToSubmissionWithFullDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }
    
    /**
     * Get submission count by assignment
     */
    public int getSubmissionCountByAssignment(int assignmentId) {
        String sql = "SELECT COUNT(*) FROM submissions WHERE assignment_id = ?";
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
     * Get graded submission count by assignment
     */
    public int getGradedSubmissionCountByAssignment(int assignmentId) {
        String sql = "SELECT COUNT(*) FROM submissions WHERE assignment_id = ? AND grade IS NOT NULL";
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
     * Get submission count by student
     */
    public int getSubmissionCountByStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM submissions WHERE student_id = ?";
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
     * Search submissions by student name or assignment title
     */
    public List<Submission> searchSubmissions(String keyword) {
        String sql = "SELECT s.*, a.title as assignment_title, u.name as student_name, u.email as student_email "
                   + "FROM submissions s "
                   + "JOIN assignments a ON s.assignment_id = a.assignment_id "
                   + "JOIN students st ON s.student_id = st.user_id "
                   + "JOIN users u ON st.user_id = u.user_id "
                   + "WHERE a.title LIKE ? OR u.name LIKE ? "
                   + "ORDER BY s.submitted_at DESC";
        List<Submission> submissions = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                submissions.add(mapResultSetToSubmissionWithFullDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }
    
    // Helper methods
    
    private Submission mapResultSetToSubmission(ResultSet rs) throws SQLException {
        Submission submission = new Submission();
        submission.setSubmissionId(rs.getInt("submission_id"));
        submission.setAssignmentId(rs.getInt("assignment_id"));
        submission.setStudentId(rs.getInt("student_id"));
        submission.setFileUrl(rs.getString("file_url"));
        submission.setSubmittedAt(rs.getTimestamp("submitted_at"));
        submission.setGrade(rs.getDouble("grade"));
        submission.setFeedback(rs.getString("feedback"));
        submission.setCreatedAt(rs.getTimestamp("created_at"));
        return submission;
    }
    
    private Submission mapResultSetToSubmissionWithStudent(ResultSet rs) throws SQLException {
        Submission submission = mapResultSetToSubmission(rs);
        // Additional student info can be stored or returned as needed
        return submission;
    }
    
    private Submission mapResultSetToSubmissionWithAssignment(ResultSet rs) throws SQLException {
        Submission submission = mapResultSetToSubmission(rs);
        // Additional assignment info can be stored or returned as needed
        return submission;
    }
    
    private Submission mapResultSetToSubmissionWithFullDetails(ResultSet rs) throws SQLException {
        Submission submission = mapResultSetToSubmission(rs);
        // Additional assignment and student info can be stored or returned as needed
        return submission;
    }
}
