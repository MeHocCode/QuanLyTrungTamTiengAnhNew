package dal;

import dto.TeacherDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Teacher;
import models.User;

public class TeacherDAO extends DBContext {
    
    // CREATE
    public boolean createTeacher(Teacher teacher) {
        String sql = "INSERT INTO teachers (user_id, expertise, experience_years, qualification) "
                   + "VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teacher.getUserId());
            ps.setString(2, teacher.getExpertise());
            ps.setInt(3, teacher.getExperienceYears());
            ps.setString(4, teacher.getQualification());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single (by user_id)
    public Teacher getTeacherByUserId(int userId) {
        String sql = "SELECT * FROM teachers WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToTeacher(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Teacher> getAllTeachers() {
        String sql = "SELECT * FROM teachers ORDER BY user_id";
        List<Teacher> teachers = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                teachers.add(mapResultSetToTeacher(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
    
    // UPDATE
    public boolean updateTeacher(Teacher teacher) {
        String sql = "UPDATE teachers SET expertise = ?, experience_years = ?, qualification = ? "
                   + "WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, teacher.getExpertise());
            ps.setInt(2, teacher.getExperienceYears());
            ps.setString(3, teacher.getQualification());
            ps.setInt(4, teacher.getUserId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteTeacher(int userId) {
        String sql = "DELETE FROM teachers WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // JOIN METHODS
    
    /**
     * Get teacher with user information
     */
    public Teacher getTeacherWithUserInfo(int userId) {
        String sql = "SELECT t.*, u.name, u.email, u.phone "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE t.user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToTeacherWithUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get teachers by expertise
     */
    public List<Teacher> getTeachersByExpertise(String expertise) {
        String sql = "SELECT t.*, u.name, u.email, u.phone "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE t.expertise LIKE ? "
                   + "ORDER BY u.name";
        List<Teacher> teachers = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + expertise + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                teachers.add(mapResultSetToTeacherWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
    
    /**
     * Get all teachers with user information
     */
    public List<Teacher> getAllTeachersWithUserInfo() {
        String sql = "SELECT t.*, u.name, u.email, u.phone, u.active "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE u.role = 'TEACHER' "
                   + "ORDER BY u.name";
        List<Teacher> teachers = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                teachers.add(mapResultSetToTeacherWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
    
    /**
     * Get teachers by status (active/inactive)
     */
    public List<Teacher> getTeachersByStatus(String status) {
        String sql = "SELECT t.*, u.name, u.email, u.phone "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE u.active = ? "
                   + "ORDER BY u.name";
        List<Teacher> teachers = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                teachers.add(mapResultSetToTeacherWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
    
    /**
     * Search teachers by name or email
     */
    public List<Teacher> searchTeachers(String keyword) {
        String sql = "SELECT t.*, u.name, u.email, u.phone "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE u.name LIKE ? OR u.email LIKE ? OR t.expertise LIKE ? "
                   + "ORDER BY u.name";
        List<Teacher> teachers = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                teachers.add(mapResultSetToTeacherWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
    
    /**
     * Get teacher count by expertise
     */
    public int getTeacherCountByExpertise(String expertise) {
        String sql = "SELECT COUNT(*) FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE t.expertise LIKE ? AND u.active = 'ACTIVE'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + expertise + "%");
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
     * Get teachers by experience range
     */
    public List<Teacher> getTeachersByExperience(int minYears, int maxYears) {
        String sql = "SELECT t.*, u.name, u.email, u.phone "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE t.experience_years BETWEEN ? AND ? "
                   + "ORDER BY t.experience_years DESC";
        List<Teacher> teachers = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, minYears);
            ps.setInt(2, maxYears);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                teachers.add(mapResultSetToTeacherWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
    
    // DTO operations for JOIN queries and display
    public List<TeacherDTO> getAllTeacherDTOs() {
        String sql = "SELECT t.*, u.name, u.email, u.phone, u.active "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id";
        List<TeacherDTO> teacherDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                TeacherDTO teacherDTO = new TeacherDTO();
                teacherDTO.setUserId(rs.getInt("user_id"));
                teacherDTO.setUserId(rs.getInt("user_id"));
                teacherDTO.setExpertise(rs.getString("expertise"));
                teacherDTO.setExperienceYears(rs.getInt("experience_years"));
                teacherDTO.setQualification(rs.getString("qualification"));
                teacherDTO.setName(rs.getString("name"));
                teacherDTO.setEmail(rs.getString("email"));
                teacherDTO.setPhone(rs.getString("phone"));
                teacherDTO.setActive(rs.getString("active"));
                teacherDTOs.add(teacherDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacherDTOs;
    }
    
    public TeacherDTO getTeacherDTOByUserId(int userId) {
        String sql = "SELECT t.*, u.name, u.email, u.phone, u.active "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE t.user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                TeacherDTO teacherDTO = new TeacherDTO();
                teacherDTO.setUserId(rs.getInt("user_id"));
                teacherDTO.setUserId(rs.getInt("user_id"));
                teacherDTO.setExpertise(rs.getString("expertise"));
                teacherDTO.setExperienceYears(rs.getInt("experience_years"));
                teacherDTO.setQualification(rs.getString("qualification"));
                teacherDTO.setName(rs.getString("name"));
                teacherDTO.setEmail(rs.getString("email"));
                teacherDTO.setPhone(rs.getString("phone"));
                teacherDTO.setActive(rs.getString("active"));
                return teacherDTO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<TeacherDTO> getActiveTeacherDTOs() {
        String sql = "SELECT t.*, u.name, u.email, u.phone, u.active "
                   + "FROM teachers t "
                   + "JOIN users u ON t.user_id = u.user_id "
                   + "WHERE u.active = 'ACTIVE' "
                   + "ORDER BY u.name";
        List<TeacherDTO> teacherDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                TeacherDTO teacherDTO = new TeacherDTO();
                teacherDTO.setUserId(rs.getInt("user_id"));
                teacherDTO.setUserId(rs.getInt("user_id"));
                teacherDTO.setExpertise(rs.getString("expertise"));
                teacherDTO.setExperienceYears(rs.getInt("experience_years"));
                teacherDTO.setQualification(rs.getString("qualification"));
                teacherDTO.setName(rs.getString("name"));
                teacherDTO.setEmail(rs.getString("email"));
                teacherDTO.setPhone(rs.getString("phone"));
                teacherDTO.setActive(rs.getString("active"));
                teacherDTOs.add(teacherDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacherDTOs;
    }
    
    // Helper methods
    
    private Teacher mapResultSetToTeacher(ResultSet rs) throws SQLException {
        Teacher teacher = new Teacher();
        teacher.setUserId(rs.getInt("user_id"));
        teacher.setUserId(rs.getInt("user_id"));
        teacher.setExpertise(rs.getString("expertise"));
        teacher.setExperienceYears(rs.getInt("experience_years"));
        teacher.setQualification(rs.getString("qualification"));
        return teacher;
    }
    
    private Teacher mapResultSetToTeacherWithUser(ResultSet rs) throws SQLException {
        Teacher teacher = mapResultSetToTeacher(rs);
        
        // Create User object for additional info
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        if (rs.getString("active") != null) {
            user.setActive(rs.getString("active"));
        }
        
        // Note: You might want to extend Teacher class to include User info
        // or create a TeacherDTO class. For now, we'll store it in a way that can be accessed
        
        return teacher;
    }
}
