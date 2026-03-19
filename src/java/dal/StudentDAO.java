package dal;

import dto.StudentDTO;
import java.util.List;
import models.Student;

public class StudentDAO {
    
    // Basic CRUD operations using Student model
    public List<Student> getAllStudents() {
        // TODO: Implement get all students from database
        return null;
    }
    
    public Student getStudentById(int id) {
        // TODO: Implement get student by ID from database
        return null;
    }
    
    public boolean createStudent(Student student) {
        // TODO: Implement student creation in database
        return false;
    }
    
    public boolean updateStudent(Student student) {
        // TODO: Implement student update in database
        return false;
    }
    
    public boolean deleteStudent(int id) {
        // TODO: Implement student deletion from database
        return false;
    }
    
    // DTO operations for JOIN queries and display
    public List<StudentDTO> getAllStudentDTOs() {
        // TODO: Implement JOIN with users table to get student details
        // SELECT s.*, u.name, u.email, u.phone, u.active 
        // FROM students s JOIN users u ON s.user_id = u.user_id
        return null;
    }
    
    public StudentDTO getStudentDTOById(int studentId) {
        // TODO: Implement JOIN query by student ID
        return null;
    }
    
    public List<StudentDTO> getActiveStudentDTOs() {
        // TODO: Implement JOIN query for active students only
        return null;
    }
    
    public List<StudentDTO> getStudentsByLevel(String level) {
        // TODO: Implement JOIN query for students by level
        return null;
    }
}
