package dal;

import java.util.List;
import models.Submission;

public class SubmissionDAO {
    
    public List<Submission> getAllSubmissions() {
        // TODO: Implement get all submissions from database
        return null;
    }
    
    public Submission getSubmissionById(int id) {
        // TODO: Implement get submission by ID from database
        return null;
    }
    
    public boolean submitAssignment(Submission submission) {
        // TODO: Implement assignment submission in database
        return false;
    }
    
    public boolean gradeSubmission(int submissionId, int score, String feedback) {
        // TODO: Implement submission grading in database
        return false;
    }
    
    public List<Submission> getSubmissionsByAssignmentId(int assignmentId) {
        // TODO: Implement get submissions by assignment ID from database
        return null;
    }
    
    public List<Submission> getSubmissionsByStudentId(int studentId) {
        // TODO: Implement get submissions by student ID from database
        return null;
    }
}
