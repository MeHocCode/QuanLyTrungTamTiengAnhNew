package service;

import java.util.List;
import models.Grade;
import models.Submission;
import dal.GradeDAO;
import dal.SubmissionDAO;

public class GradeService {
    
    private GradeDAO gradeDAO;
    private SubmissionDAO submissionDAO;
    
    public GradeService() {
        this.gradeDAO = new GradeDAO();
        this.submissionDAO = new SubmissionDAO();
    }
    
    public List<Grade> getAllGrades() {
        // TODO: Implement get all grades with business logic
        return gradeDAO.getAllGrades();
    }
    
    public Grade getGradeById(int gradeId) {
        // TODO: Implement get grade by ID with validation
        return gradeDAO.getGradeById(gradeId);
    }
    
    public boolean createGrade(Grade grade) {
        // TODO: Implement grade creation with business validation
        // 1. Validate grade exists
        // 2. Validate submission exists and belongs to student
        // 3. Validate score range (0-100)
        // 4. Create grade record
        if (grade.getScore() < 0 || grade.getScore() > 100) {
            return false; // Invalid score
        }
        
        Submission submission = submissionDAO.getSubmissionById(grade.getSubmissionId());
        if (submission == null) {
            return false; // Submission doesn't exist
        }
        
        return gradeDAO.createGrade(grade);
    }
    
    public boolean updateGrade(Grade grade) {
        // TODO: Implement grade update with business validation
        // 1. Validate grade exists
        // 2. Validate score range
        // 3. Update grade record
        if (grade.getScore() < 0 || grade.getScore() > 100) {
            return false; // Invalid score
        }
        
        Grade existingGrade = gradeDAO.getGradeById(grade.getGradeId());
        if (existingGrade == null) {
            return false; // Grade doesn't exist
        }
        
        return gradeDAO.updateGrade(grade);
    }
    
    public boolean deleteGrade(int gradeId) {
        // TODO: Implement grade deletion with validation
        Grade grade = gradeDAO.getGradeById(gradeId);
        if (grade == null) {
            return false; // Grade doesn't exist
        }
        
        return gradeDAO.deleteGrade(gradeId);
    }
    
    public List<Grade> getGradesByStudentId(int studentId) {
        // TODO: Implement get grades by student ID
        return gradeDAO.getGradesByStudentId(studentId);
    }
    
    public List<Grade> getGradesBySubmissionId(int submissionId) {
        // TODO: Implement get grades by submission ID
        return gradeDAO.getGradesBySubmissionId(submissionId);
    }
}
