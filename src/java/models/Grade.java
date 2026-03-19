package models;

public class Grade {
    private int gradeId;
    private int submissionId;
    private double score;
    private String feedback;
    private java.util.Date gradedAt;
    private int gradedBy;
    
    // Constructors
    public Grade() {}
    
    public Grade(int gradeId, int submissionId, double score, String feedback, int gradedBy) {
        this.gradeId = gradeId;
        this.submissionId = submissionId;
        this.score = score;
        this.feedback = feedback;
        this.gradedBy = gradedBy;
        this.gradedAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getGradeId() { return gradeId; }
    public void setGradeId(int gradeId) { this.gradeId = gradeId; }
    
    public int getSubmissionId() { return submissionId; }
    public void setSubmissionId(int submissionId) { this.submissionId = submissionId; }
    
    public double getScore() { return score; }
    public void setScore(double score) { this.score = score; }
    
    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }
    
    public java.util.Date getGradedAt() { return gradedAt; }
    public void setGradedAt(java.util.Date gradedAt) { this.gradedAt = gradedAt; }
    
    public int getGradedBy() { return gradedBy; }
    public void setGradedBy(int gradedBy) { this.gradedBy = gradedBy; }
}
