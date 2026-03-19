package dal;

import dto.EnrollmentDTO;
import java.util.List;
import models.Enrollment;

public class EnrollmentDAO {
    
    // Basic CRUD operations using Enrollment model
    public List<Enrollment> getAllEnrollments() {
        // TODO: Implement get all enrollments from database
        return null;
    }
    
    public Enrollment getEnrollmentById(int id) {
        // TODO: Implement get enrollment by ID from database
        return null;
    }
    
    public boolean createEnrollment(Enrollment enrollment) {
        // TODO: Implement enrollment creation in database
        return false;
    }
    
    public boolean approveEnrollment(int id) {
        // TODO: Implement enrollment approval in database
        return false;
    }
    
    public boolean rejectEnrollment(int id) {
        // TODO: Implement enrollment rejection in database
        return false;
    }
    
    public List<Enrollment> getEnrollmentsByStudentId(int studentId) {
        // TODO: Implement get enrollments by student ID from database
        return null;
    }
    
    public List<Enrollment> getEnrollmentsByClassId(int classId) {
        // TODO: Implement get enrollments by class ID from database
        return null;
    }
    
    // DTO operations for JOIN queries and display
    public List<EnrollmentDTO> getAllEnrollmentDTOs() {
        // TODO: Implement complex JOIN query
        // SELECT e.*, s.name as student_name, s.email as student_email,
        //        c.class_id, co.title as course_title, u.name as teacher_name
        // FROM enrollments e
        // JOIN students s ON e.student_id = s.student_id
        // JOIN users u ON s.user_id = u.user_id
        // JOIN classes c ON e.class_id = c.class_id
        // JOIN courses co ON c.course_id = co.course_id
        // JOIN teachers t ON c.teacher_id = t.teacher_id
        // JOIN users tu ON t.user_id = tu.user_id
        return null;
    }
    
    public List<EnrollmentDTO> getEnrollmentDTOsByStudentId(int studentId) {
        // TODO: Implement JOIN query by student ID
        return null;
    }
    
    public List<EnrollmentDTO> getEnrollmentDTOsByClassId(int classId) {
        // TODO: Implement JOIN query by class ID
        return null;
    }
    
    public List<EnrollmentDTO> getPendingEnrollmentDTOs() {
        // TODO: Implement JOIN query for pending enrollments
        return null;
    }
}
