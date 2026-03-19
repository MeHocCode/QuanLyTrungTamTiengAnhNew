package service;

import java.util.List;
import models.Submission;

public class SubmissionService {
    
    public List<Submission> getAllSubmissions() {
        // TODO: Implement get all submissions
        return null;
    }
    
    public Submission getSubmissionById(int id) {
        // TODO: Implement get submission by ID
        return null;
    }
    
    public boolean submitAssignment(Submission submission) {
        // TODO: Implement assignment submission
        return false;
    }
    
    public boolean gradeSubmission(int submissionId, int score, String feedback) {
        // TODO: Implement submission grading
        return false;
    }
    
    public List<Submission> getSubmissionsByAssignmentId(int assignmentId) {
        // TODO: Implement get submissions by assignment ID
        return null;
    }
    
    public List<Submission> getSubmissionsByStudentId(int studentId) {
        // TODO: Implement get submissions by student ID
        return null;
    }
}
