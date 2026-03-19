package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Class;

public class ClassDAO extends DBContext {
    
    // CREATE
    public boolean createClass(Class clazz) {
        String sql = "INSERT INTO classes (course_id, teacher_id, start_date, end_date, max_size, schedule_json, location_or_link, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, clazz.getCourseId());
            ps.setInt(2, clazz.getTeacherId());
            ps.setDate(3, clazz.getStartDate() != null ? new java.sql.Date(clazz.getStartDate().getTime()) : null);
            ps.setDate(4, clazz.getEndDate() != null ? new java.sql.Date(clazz.getEndDate().getTime()) : null);
            ps.setInt(5, clazz.getMaxSize());
            ps.setString(6, clazz.getScheduleJson());
            ps.setString(7, clazz.getLocationOrLink());
            ps.setString(8, clazz.getStatus());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    clazz.setClassId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single
    public Class getClassById(int classId) {
        String sql = "SELECT * FROM classes WHERE class_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToClass(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Class> getAllClasses() {
        String sql = "SELECT * FROM classes ORDER BY created_at DESC";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                classes.add(mapResultSetToClass(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    // UPDATE
    public boolean updateClass(Class clazz) {
        String sql = "UPDATE classes SET course_id = ?, teacher_id = ?, start_date = ?, end_date = ?, "
                   + "max_size = ?, schedule_json = ?, location_or_link = ?, status = ? WHERE class_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, clazz.getCourseId());
            ps.setInt(2, clazz.getTeacherId());
            ps.setDate(3, clazz.getStartDate() != null ? new java.sql.Date(clazz.getStartDate().getTime()) : null);
            ps.setDate(4, clazz.getEndDate() != null ? new java.sql.Date(clazz.getEndDate().getTime()) : null);
            ps.setInt(5, clazz.getMaxSize());
            ps.setString(6, clazz.getScheduleJson());
            ps.setString(7, clazz.getLocationOrLink());
            ps.setString(8, clazz.getStatus());
            ps.setInt(9, clazz.getClassId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteClass(int classId) {
        String sql = "DELETE FROM classes WHERE class_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, classId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get classes by course
     */
    public List<Class> getClassesByCourse(int courseId) {
        String sql = "SELECT c.*, co.title as course_title "
                   + "FROM classes c "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "WHERE c.course_id = ? "
                   + "ORDER BY c.start_date";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                classes.add(mapResultSetToClassWithCourse(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    /**
     * Get classes by teacher
     */
    public List<Class> getClassesByTeacher(int teacherId) {
        String sql = "SELECT c.*, u.name as teacher_name "
                   + "FROM classes c "
                   + "JOIN teachers t ON c.teacher_id = t.user_id "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE c.teacher_id = ? "
                   + "ORDER BY c.start_date";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                classes.add(mapResultSetToClassWithTeacher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    /**
     * Get active classes
     */
    public List<Class> getActiveClasses() {
        String sql = "SELECT c.*, co.title as course_title, u.name as teacher_name "
                   + "FROM classes c "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "WHERE c.status = 'ONGOING' "
                   + "ORDER BY c.start_date";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                classes.add(mapResultSetToClassWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    /**
     * Get classes with full details (course + teacher)
     */
    public List<Class> getClassesWithDetails() {
        String sql = "SELECT c.*, co.title as course_title, u.name as teacher_name, u.email as teacher_email "
                   + "FROM classes c "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "ORDER BY c.start_date DESC";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                classes.add(mapResultSetToClassWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    /**
     * Get classes by status
     */
    public List<Class> getClassesByStatus(String status) {
        String sql = "SELECT c.*, co.title as course_title, u.name as teacher_name "
                   + "FROM classes c "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "WHERE c.status = ? "
                   + "ORDER BY c.start_date";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                classes.add(mapResultSetToClassWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    /**
     * Search classes by course title or teacher name
     */
    public List<Class> searchClasses(String keyword) {
        String sql = "SELECT c.*, co.title as course_title, u.name as teacher_name "
                   + "FROM classes c "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "WHERE co.title LIKE ? OR u.name LIKE ? "
                   + "ORDER BY c.start_date";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                classes.add(mapResultSetToClassWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    /**
     * Get upcoming classes
     */
    public List<Class> getUpcomingClasses() {
        String sql = "SELECT c.*, co.title as course_title, u.name as teacher_name "
                   + "FROM classes c "
                   + "JOIN courses co ON c.course_id = co.course_id "
                   + "LEFT JOIN teachers t ON c.teacher_id = t.user_id "
                   + "LEFT JOIN users u ON t.user_id = u.user_id "
                   + "WHERE c.status = 'PLANNED' AND c.start_date > GETDATE() "
                   + "ORDER BY c.start_date";
        List<Class> classes = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                classes.add(mapResultSetToClassWithDetails(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classes;
    }
    
    /**
     * Get class count by status
     */
    public int getClassCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM classes WHERE status = ?";
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
     * Get class count by course
     */
    public int getClassCountByCourse(int courseId) {
        String sql = "SELECT COUNT(*) FROM classes WHERE course_id = ?";
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
     * Update class status
     */
    public boolean updateClassStatus(int classId, String status) {
        String sql = "UPDATE classes SET status = ? WHERE class_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, classId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper methods
    
    private Class mapResultSetToClass(ResultSet rs) throws SQLException {
        Class clazz = new Class();
        clazz.setClassId(rs.getInt("class_id"));
        clazz.setCourseId(rs.getInt("course_id"));
        clazz.setTeacherId(rs.getInt("teacher_id"));
        clazz.setStartDate(rs.getDate("start_date"));
        clazz.setEndDate(rs.getDate("end_date"));
        clazz.setMaxSize(rs.getInt("max_size"));
        clazz.setScheduleJson(rs.getString("schedule_json"));
        clazz.setLocationOrLink(rs.getString("location_or_link"));
        clazz.setStatus(rs.getString("status"));
        clazz.setCreatedAt(rs.getTimestamp("created_at"));
        return clazz;
    }
    
    private Class mapResultSetToClassWithCourse(ResultSet rs) throws SQLException {
        Class clazz = mapResultSetToClass(rs);
        // Additional course info can be stored or returned as needed
        return clazz;
    }
    
    private Class mapResultSetToClassWithTeacher(ResultSet rs) throws SQLException {
        Class clazz = mapResultSetToClass(rs);
        // Additional teacher info can be stored or returned as needed
        return clazz;
    }
    
    private Class mapResultSetToClassWithDetails(ResultSet rs) throws SQLException {
        Class clazz = mapResultSetToClass(rs);
        // Additional course and teacher info can be stored or returned as needed
        return clazz;
    }
    
    public List<Class> getClassesByCourseId(int courseId) {
        return getClassesByCourse(courseId);
    }
    
    public List<Class> getClassesByTeacherId(int teacherId) {
        return getClassesByTeacher(teacherId);
    }
}
