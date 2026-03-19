package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Course;

public class CourseDAO extends DBContext {
    
    // CREATE
    public boolean createCourse(Course course) {
        String sql = "INSERT INTO courses (title, description, level, price, type, duration_weeks, published) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setString(3, course.getLevel());
            ps.setDouble(4, course.getPrice());
            ps.setString(5, course.getType());
            ps.setInt(6, course.getDurationWeeks());
            ps.setString(7, course.getPublished());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    course.setCourseId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Course getCourseById(int courseId) {
        String sql = "SELECT * FROM courses WHERE course_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToCourse(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Course> getAllCourses() {
        String sql = "SELECT * FROM courses ORDER BY created_at DESC";
        List<Course> courses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // UPDATE
    public boolean updateCourse(Course course) {
        String sql = "UPDATE courses SET title = ?, description = ?, level = ?, price = ?, "
                   + "type = ?, duration_weeks = ?, published = ? WHERE course_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setString(3, course.getLevel());
            ps.setDouble(4, course.getPrice());
            ps.setString(5, course.getType());
            ps.setInt(6, course.getDurationWeeks());
            ps.setString(7, course.getPublished());
            ps.setInt(8, course.getCourseId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteCourse(int courseId) {
        String sql = "DELETE FROM courses WHERE course_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // SPECIALIZED METHODS
    
    /**
     * Get courses by level
     */
    public List<Course> getCoursesByLevel(String level) {
        String sql = "SELECT * FROM courses WHERE level = ? ORDER BY title";
        List<Course> courses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, level);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    /**
     * Get published courses only
     */
    public List<Course> getPublishedCourses() {
        String sql = "SELECT * FROM courses WHERE published = 'PUBLISHED' ORDER BY title";
        List<Course> courses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    /**
     * Get courses by type
     */
    public List<Course> getCoursesByType(String type) {
        String sql = "SELECT * FROM courses WHERE type = ? ORDER BY title";
        List<Course> courses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    /**
     * Search courses by title or description
     */
    public List<Course> searchCourses(String keyword) {
        String sql = "SELECT * FROM courses WHERE title LIKE ? OR description LIKE ? ORDER BY title";
        List<Course> courses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    /**
     * Get courses by price range
     */
    public List<Course> getCoursesByPriceRange(double minPrice, double maxPrice) {
        String sql = "SELECT * FROM courses WHERE price BETWEEN ? AND ? ORDER BY price";
        List<Course> courses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    /**
     * Get course count by level
     */
    public int getCourseCountByLevel(String level) {
        String sql = "SELECT COUNT(*) FROM courses WHERE level = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, level);
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
     * Get course count by type
     */
    public int getCourseCountByType(String type) {
        String sql = "SELECT COUNT(*) FROM courses WHERE type = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, type);
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
     * Update course status (published)
     */
    public boolean updateCourseStatus(int courseId, String status) {
        String sql = "UPDATE courses SET published = ? WHERE course_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, courseId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get recent courses (created in last 30 days)
     */
    public List<Course> getRecentCourses() {
        String sql = "SELECT * FROM courses WHERE created_at >= DATEADD(day, -30, GETDATE()) ORDER BY created_at DESC";
        List<Course> courses = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                courses.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // Helper method
    
    private Course mapResultSetToCourse(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setCourseId(rs.getInt("course_id"));
        course.setTitle(rs.getString("title"));
        course.setDescription(rs.getString("description"));
        course.setLevel(rs.getString("level"));
        course.setPrice(rs.getDouble("price"));
        course.setType(rs.getString("type"));
        course.setDurationWeeks(rs.getInt("duration_weeks"));
        course.setPublished(rs.getString("published"));
        course.setCreatedAt(rs.getTimestamp("created_at"));
        return course;
    }
}
