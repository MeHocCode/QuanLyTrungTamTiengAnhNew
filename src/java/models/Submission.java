package models;

public class Submission {
    private int submissionId;
    private int assignmentId;
    private int studentId;
    private String fileUrl;
    private java.util.Date submittedAt;
    private java.util.Date createdAt;
    private double grade;
    private String feedback;
    
    // Constructors
    public Submission() {}
    
    public Submission(int submissionId, int assignmentId, int studentId, String fileUrl) {
        this.submissionId = submissionId;
        this.assignmentId = assignmentId;
        this.studentId = studentId;
        this.fileUrl = fileUrl;
        this.submittedAt = new java.util.Date();
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getSubmissionId() { return submissionId; }
    public void setSubmissionId(int submissionId) { this.submissionId = submissionId; }
    
    public int getAssignmentId() { return assignmentId; }
    public void setAssignmentId(int assignmentId) { this.assignmentId = assignmentId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }
    
    public java.util.Date getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(java.util.Date submittedAt) { this.submittedAt = submittedAt; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
    
    public double getGrade() { return grade; }
    public void setGrade(double grade) { this.grade = grade; }
    
    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }
}
