package models;

public class Enrollment {
    private int enrollmentId;
    private int studentId;
    private int classId;
    private String status;
    private java.util.Date enrolledAt;
    
    // Constructors
    public Enrollment() {}
    
    public Enrollment(int enrollmentId, int studentId, int classId, String status) {
        this.enrollmentId = enrollmentId;
        this.studentId = studentId;
        this.classId = classId;
        this.status = status;
        this.enrolledAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public java.util.Date getEnrolledAt() { return enrolledAt; }
    public void setEnrolledAt(java.util.Date enrolledAt) { this.enrolledAt = enrolledAt; }
}
