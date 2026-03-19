package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.MockTest;
import models.Course;
import models.Teacher;
import models.User;

public class MockTestDAO extends DBContext {
    
    // CREATE
    public boolean createMockTest(MockTest mockTest) {
        String sql = "INSERT INTO mock_tests (course_id, teacher_id, title, description, questions_json, duration_minutes, passing_score) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, mockTest.getCourseId());
            ps.setInt(2, mockTest.getTeacherId());
            ps.setString(3, mockTest.getTitle());
            ps.setString(4, mockTest.getDescription());
            ps.setString(5, mockTest.getQuestionsJson());
            ps.setInt(6, mockTest.getDurationMinutes());
            ps.setDouble(7, mockTest.getPassingScore());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    mockTest.setTestId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public MockTest getMockTestById(int testId) {
        String sql = "SELECT * FROM mock_tests WHERE test_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToMockTest(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<MockTest> getAllMockTests() {
        String sql = "SELECT * FROM mock_tests ORDER BY created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTest(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    // UPDATE
    public boolean updateMockTest(MockTest mockTest) {
        String sql = "UPDATE mock_tests SET course_id = ?, teacher_id = ?, title = ?, description = ?, "
                   + "questions_json = ?, duration_minutes = ?, passing_score = ? WHERE test_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, mockTest.getCourseId());
            ps.setInt(2, mockTest.getTeacherId());
            ps.setString(3, mockTest.getTitle());
            ps.setString(4, mockTest.getDescription());
            ps.setString(5, mockTest.getQuestionsJson());
            ps.setInt(6, mockTest.getDurationMinutes());
            ps.setDouble(7, mockTest.getPassingScore());
            ps.setInt(8, mockTest.getTestId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteMockTest(int testId) {
        String sql = "DELETE FROM mock_tests WHERE test_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, testId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get mock tests by course
     */
    public List<MockTest> getMockTestsByCourseId(int courseId) {
        String sql = "SELECT mt.*, u.name as teacher_name, u.email as teacher_email "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE mt.course_id = ? "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithTeacher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    /**
     * Get mock tests by teacher
     */
    public List<MockTest> getMockTestsByTeacher(int teacherUserId) {
        String sql = "SELECT mt.*, c.title as course_title, u.name as teacher_name "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE mt.teacher_id = ? "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teacherUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    /**
     * Get mock tests with full details (course + teacher)
     */
    public List<MockTest> getMockTestsWithDetails() {
        String sql = "SELECT mt.*, c.title as course_title, c.level as course_level, "
                   + "u.name as teacher_name, u.email as teacher_email "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    /**
     * Get active mock tests (not expired)
     */
    public List<MockTest> getActiveMockTests() {
        String sql = "SELECT mt.*, c.title as course_title, u.name as teacher_name "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE mt.is_active = 1 "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    /**
     * Get mock tests by difficulty level
     */
    public List<MockTest> getMockTestsByLevel(String level) {
        String sql = "SELECT mt.*, c.title as course_title, u.name as teacher_name "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE c.level = ? "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, level);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    /**
     * Get mock test count by course
     */
    public int getMockTestCountByCourse(int courseId) {
        String sql = "SELECT COUNT(*) FROM mock_tests WHERE course_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
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
     * Get mock test count by teacher
     */
    public int getMockTestCountByTeacher(int teacherUserId) {
        String sql = "SELECT COUNT(*) FROM mock_tests WHERE teacher_id = ?";
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
     * Search mock tests by title or course title
     */
    public List<MockTest> searchMockTests(String keyword) {
        String sql = "SELECT mt.*, c.title as course_title, u.name as teacher_name "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE mt.title LIKE ? OR c.title LIKE ? "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    /**
     * Get recent mock tests (last 30 days)
     */
    public List<MockTest> getRecentMockTests() {
        String sql = "SELECT mt.*, c.title as course_title, u.name as teacher_name "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE mt.created_at >= DATEADD(day, -30, GETDATE()) "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    /**
     * Get mock tests with statistics (attempt count, average score)
     */
    public List<MockTest> getMockTestsWithStatistics() {
        String sql = "SELECT mt.*, c.title as course_title, u.name as teacher_name, "
                   + "COUNT(tr.result_id) as attempt_count, "
                   + "AVG(tr.score) as average_score "
                   + "FROM mock_tests mt "
                   + "JOIN courses c ON mt.course_id = c.course_id "
                   + "JOIN teachers t ON mt.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "LEFT JOIN test_results tr ON mt.test_id = tr.test_id "
                   + "GROUP BY mt.test_id, c.title, u.name "
                   + "ORDER BY mt.created_at DESC";
        List<MockTest> mockTests = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                mockTests.add(mapResultSetToMockTestWithStatistics(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mockTests;
    }
    
    // Helper methods
    
    private MockTest mapResultSetToMockTest(ResultSet rs) throws SQLException {
        MockTest mockTest = new MockTest();
        mockTest.setTestId(rs.getInt("test_id"));
        mockTest.setCourseId(rs.getInt("course_id"));
        mockTest.setTeacherId(rs.getInt("teacher_id"));
        mockTest.setTitle(rs.getString("title"));
        mockTest.setDescription(rs.getString("description"));
        mockTest.setQuestionsJson(rs.getString("questions_json"));
        mockTest.setDurationMinutes(rs.getInt("duration_minutes"));
        mockTest.setPassingScore(rs.getDouble("passing_score"));
        mockTest.setIsActive(rs.getBoolean("is_active"));
        mockTest.setCreatedAt(rs.getTimestamp("created_at"));
        return mockTest;
    }
    
    private MockTest mapResultSetToMockTestWithTeacher(ResultSet rs) throws SQLException {
        MockTest mockTest = mapResultSetToMockTest(rs);
        // Additional teacher info can be stored or returned as needed
        return mockTest;
    }
    
    private MockTest mapResultSetToMockTestWithDetails(ResultSet rs) throws SQLException {
        MockTest mockTest = mapResultSetToMockTest(rs);
        // Additional course and teacher info can be stored or returned as needed
        return mockTest;
    }
    
    private MockTest mapResultSetToMockTestWithStatistics(ResultSet rs) throws SQLException {
        MockTest mockTest = mapResultSetToMockTest(rs);
        // Additional statistics can be stored or returned as needed
        return mockTest;
    }
}
