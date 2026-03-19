package dal;

import dto.StudentDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Student;
import models.User;
import models.Role;

public class StudentDAO extends DBContext {
    
    // CREATE
    public boolean createStudent(Student student) {
        String sql = "INSERT INTO students (user_id, date_of_birth, address, parent_name, parent_phone, level) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, student.getUserId());
            ps.setDate(2, student.getDateOfBirth() != null ? new java.sql.Date(student.getDateOfBirth().getTime()) : null);
            ps.setString(3, student.getAddress());
            ps.setString(4, student.getParentName());
            ps.setString(5, student.getParentPhone());
            ps.setString(6, student.getLevel());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // READ - Single (by user_id)
    public Student getStudentByUserId(int userId) {
        String sql = "SELECT * FROM students WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // READ - All
    public List<Student> getAllStudents() {
        String sql = "SELECT * FROM students ORDER BY user_id";
        List<Student> students = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    // UPDATE
    public boolean updateStudent(Student student) {
        String sql = "UPDATE students SET date_of_birth = ?, address = ?, parent_name = ?, parent_phone = ?, level = ? "
                   + "WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, student.getDateOfBirth() != null ? new java.sql.Date(student.getDateOfBirth().getTime()) : null);
            ps.setString(2, student.getAddress());
            ps.setString(3, student.getParentName());
            ps.setString(4, student.getParentPhone());
            ps.setString(5, student.getLevel());
            ps.setInt(6, student.getUserId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // DELETE
    public boolean deleteStudent(int userId) {
        String sql = "DELETE FROM students WHERE user_id = ?";
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
     * Get student with user information
     */
    public Student getStudentWithUserInfo(int userId) {
        String sql = "SELECT s.*, u.name, u.email, u.phone, u.active "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE s.user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToStudentWithUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get students by level
     */
    public List<Student> getStudentsByLevel(String level) {
        String sql = "SELECT s.*, u.name, u.email, u.phone "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE s.level = ? "
                   + "ORDER BY u.name";
        List<Student> students = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, level);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                students.add(mapResultSetToStudentWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    /**
     * Get all students with user information
     */
    public List<Student> getAllStudentsWithUserInfo() {
        String sql = "SELECT s.*, u.name, u.email, u.phone, u.active "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE u.role = 'STUDENT' "
                   + "ORDER BY u.name";
        List<Student> students = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                students.add(mapResultSetToStudentWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    /**
     * Get students by status (active/inactive)
     */
    public List<Student> getStudentsByStatus(String status) {
        String sql = "SELECT s.*, u.name, u.email, u.phone "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE u.active = ? "
                   + "ORDER BY u.name";
        List<Student> students = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                students.add(mapResultSetToStudentWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    /**
     * Search students by name or email
     */
    public List<Student> searchStudents(String keyword) {
        String sql = "SELECT s.*, u.name, u.email, u.phone "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE u.name LIKE ? OR u.email LIKE ? "
                   + "ORDER BY u.name";
        List<Student> students = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                students.add(mapResultSetToStudentWithUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    /**
     * Get student count by level
     */
    public int getStudentCountByLevel(String level) {
        String sql = "SELECT COUNT(*) FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE s.level = ? AND u.active = 'ACTIVE'";
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
    
    // DTO operations for JOIN queries and display
    public List<StudentDTO> getAllStudentDTOs() {
        String sql = "SELECT s.*, u.name, u.email, u.phone, u.active "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id";
        List<StudentDTO> studentDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                StudentDTO studentDTO = new StudentDTO();
                studentDTO.setUserId(rs.getInt("user_id"));
                studentDTO.setDateOfBirth(rs.getDate("date_of_birth"));
                studentDTO.setAddress(rs.getString("address"));
                studentDTO.setParentName(rs.getString("parent_name"));
                studentDTO.setParentPhone(rs.getString("parent_phone"));
                studentDTO.setLevel(rs.getString("level"));
                studentDTO.setName(rs.getString("name"));
                studentDTO.setEmail(rs.getString("email"));
                studentDTO.setPhone(rs.getString("phone"));
                studentDTO.setActive(rs.getString("active"));
                studentDTOs.add(studentDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return studentDTOs;
    }
    
    public StudentDTO getStudentDTOByUserId(int userId) {
        String sql = "SELECT s.*, u.name, u.email, u.phone, u.active "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE s.user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StudentDTO studentDTO = new StudentDTO();
                studentDTO.setUserId(rs.getInt("user_id"));
                studentDTO.setDateOfBirth(rs.getDate("date_of_birth"));
                studentDTO.setAddress(rs.getString("address"));
                studentDTO.setParentName(rs.getString("parent_name"));
                studentDTO.setParentPhone(rs.getString("parent_phone"));
                studentDTO.setLevel(rs.getString("level"));
                studentDTO.setName(rs.getString("name"));
                studentDTO.setEmail(rs.getString("email"));
                studentDTO.setPhone(rs.getString("phone"));
                studentDTO.setActive(rs.getString("active"));
                return studentDTO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<StudentDTO> getActiveStudentDTOs() {
        String sql = "SELECT s.*, u.name, u.email, u.phone, u.active "
                   + "FROM students s "
                   + "JOIN users u ON s.user_id = u.user_id "
                   + "WHERE u.active = 'ACTIVE' "
                   + "ORDER BY u.name";
        List<StudentDTO> studentDTOs = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                StudentDTO studentDTO = new StudentDTO();
                studentDTO.setUserId(rs.getInt("user_id"));
                studentDTO.setDateOfBirth(rs.getDate("date_of_birth"));
                studentDTO.setAddress(rs.getString("address"));
                studentDTO.setParentName(rs.getString("parent_name"));
                studentDTO.setParentPhone(rs.getString("parent_phone"));
                studentDTO.setLevel(rs.getString("level"));
                studentDTO.setName(rs.getString("name"));
                studentDTO.setEmail(rs.getString("email"));
                studentDTO.setPhone(rs.getString("phone"));
                studentDTO.setActive(rs.getString("active"));
                studentDTOs.add(studentDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return studentDTOs;
    }
    
    // Helper methods
    
    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setUserId(rs.getInt("user_id"));
        student.setDateOfBirth(rs.getDate("date_of_birth"));
        student.setAddress(rs.getString("address"));
        student.setParentName(rs.getString("parent_name"));
        student.setParentPhone(rs.getString("parent_phone"));
        student.setLevel(rs.getString("level"));
        return student;
    }
    
    private Student mapResultSetToStudentWithUser(ResultSet rs) throws SQLException {
        Student student = mapResultSetToStudent(rs);
        
        // Create User object for additional info
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        if (rs.getString("active") != null) {
            user.setActive(rs.getString("active"));
        }
        
        // Note: You might want to extend Student class to include User info
        // or create a StudentDTO class. For now, we'll store it in a way that can be accessed
        
        return student;
    }
}
