package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.TestResult;

public class TestResultDAO extends DBContext {
    
    // CREATE
    public boolean createTestResult(TestResult testResult) {
        String sql = "INSERT INTO test_results (test_id, student_id, score, answers_json, completed_at) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, testResult.getTestId());
            ps.setInt(2, testResult.getStudentId());
            ps.setDouble(3, testResult.getScore());
            ps.setString(4, testResult.getAnswersJson());
            ps.setTimestamp(5, testResult.getCompletedAt() != null ? new Timestamp(testResult.getCompletedAt().getTime()) : new Timestamp(System.currentTimeMillis()));
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    testResult.setResultId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public TestResult getTestResultById(int resultId) {
        String sql = "SELECT * FROM test_results WHERE result_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, resultId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToTestResult(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<TestResult> getAllTestResults() {
        String sql = "SELECT * FROM test_results ORDER BY taken_at DESC";
        List<TestResult> testResults = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                testResults.add(mapResultSetToTestResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testResults;
    }
    
    // UPDATE
    public boolean updateTestResult(TestResult testResult) {
        String sql = "UPDATE test_results SET test_id = ?, student_id = ?, score = ?, answers_json = ?, completed_at = ? "
                   + "WHERE result_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, testResult.getTestId());
            ps.setInt(2, testResult.getStudentId());
            ps.setDouble(3, testResult.getScore());
            ps.setString(4, testResult.getAnswersJson());
            ps.setTimestamp(5, testResult.getCompletedAt() != null ? new Timestamp(testResult.getCompletedAt().getTime()) : null);
            ps.setInt(6, testResult.getResultId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteTestResult(int resultId) {
        String sql = "DELETE FROM test_results WHERE result_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, resultId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get test results by student
     */
    public List<TestResult> getTestResultsByStudentId(int studentId) {
        String sql = "SELECT tr.*, mt.title as test_title, u.name as student_name, u.email as student_email "
                   + "FROM test_results tr "
                   + "JOIN mock_tests mt ON tr.test_id = mt.test_id "
                   + "JOIN students s ON tr.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE tr.student_id = ? "
                   + "ORDER BY tr.completed_at DESC";
        List<TestResult> testResults = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                testResults.add(mapResultSetToTestResultWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testResults;
    }
    
    /**
     * Get test results by test
     */
    public List<TestResult> getTestResultsByTestId(int testId) {
        String sql = "SELECT tr.*, u.name as student_name, u.email as student_email "
                   + "FROM test_results tr "
                   + "JOIN mock_tests mt ON tr.test_id = mt.test_id "
                   + "JOIN students s ON tr.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE tr.test_id = ? "
                   + "ORDER BY tr.score DESC";
        List<TestResult> testResults = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                testResults.add(mapResultSetToTestResultWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testResults;
    }
    
    /**
     * Get test results with full details (test + student)
     */
    public List<TestResult> getTestResultsWithDetails() {
        String sql = "SELECT tr.*, mt.title as test_title, mt.questions_json, "
                   + "u.name as student_name, u.email as student_email "
                   + "FROM test_results tr "
                   + "JOIN mock_tests mt ON tr.test_id = mt.test_id "
                   + "JOIN students s ON tr.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "ORDER BY tr.completed_at DESC";
        List<TestResult> testResults = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                testResults.add(mapResultSetToTestResultWithFullDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testResults;
    }
    
    /**
     * Get high scores by student
     */
    public List<TestResult> getHighScoresByStudent(int studentId) {
        String sql = "SELECT tr.*, mt.title as test_title, u.name as student_name "
                   + "FROM test_results tr "
                   + "JOIN mock_tests mt ON tr.test_id = mt.test_id "
                   + "JOIN students s ON tr.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE tr.student_id = ? "
                   + "AND tr.score = ("
                   + "    SELECT MAX(tr2.score) "
                   + "    FROM test_results tr2 "
                   + "    WHERE tr2.test_id = tr.test_id AND tr2.student_id = ?"
                   + ") "
                   + "ORDER BY tr.completed_at DESC";
        List<TestResult> testResults = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                testResults.add(mapResultSetToTestResultWithStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testResults;
    }
    
    /**
     * Get average score by test
     */
    public double getAverageScoreByTest(int testId) {
        String sql = "SELECT AVG(score) as avg_score FROM test_results WHERE test_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, testId);
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
     * Get test result count by student
     */
    public int getTestResultCountByStudent(int studentId) {
        String sql = "SELECT COUNT(*) FROM test_results WHERE student_id = ?";
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
     * Get test result count by test
     */
    public int getTestResultCountByTest(int testId) {
        String sql = "SELECT COUNT(*) FROM test_results WHERE test_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, testId);
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
     * Search test results by student name or test title
     */
    public List<TestResult> searchTestResults(String keyword) {
        String sql = "SELECT tr.*, mt.title as test_title, u.name as student_name, u.email as student_email "
                   + "FROM test_results tr "
                   + "JOIN mock_tests mt ON tr.test_id = mt.test_id "
                   + "JOIN students s ON tr.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE mt.title LIKE ? OR u.name LIKE ? "
                   + "ORDER BY tr.completed_at DESC";
        List<TestResult> testResults = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                testResults.add(mapResultSetToTestResultWithFullDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testResults;
    }
    
    /**
     * Get recent test results (last 30 days)
     */
    public List<TestResult> getRecentTestResults() {
        String sql = "SELECT tr.*, mt.title as test_title, u.name as student_name, u.email as student_email "
                   + "FROM test_results tr "
                   + "JOIN mock_tests mt ON tr.test_id = mt.test_id "
                   + "JOIN students s ON tr.student_id = s.user_id "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE tr.completed_at >= DATEADD(day, -30, GETDATE()) "
                   + "ORDER BY tr.completed_at DESC";
        List<TestResult> testResults = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                testResults.add(mapResultSetToTestResultWithFullDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testResults;
    }
    
    // Helper methods
    
    private TestResult mapResultSetToTestResult(ResultSet rs) throws SQLException {
        TestResult testResult = new TestResult();
        testResult.setResultId(rs.getInt("result_id"));
        testResult.setTestId(rs.getInt("test_id"));
        testResult.setStudentId(rs.getInt("student_id"));
        testResult.setScore(rs.getInt("score"));
        testResult.setAnswersJson(rs.getString("answers_json"));
        testResult.setCompletedAt(rs.getTimestamp("completed_at"));
        return testResult;
    }
    
    private TestResult mapResultSetToTestResultWithStudent(ResultSet rs) throws SQLException {
        TestResult testResult = mapResultSetToTestResult(rs);
        // Additional student info can be stored or returned as needed
        return testResult;
    }
    
    private TestResult mapResultSetToTestResultWithFullDetails(ResultSet rs) throws SQLException {
        TestResult testResult = mapResultSetToTestResult(rs);
        // Additional test and student info can be stored or returned as needed
        return testResult;
    }
}
