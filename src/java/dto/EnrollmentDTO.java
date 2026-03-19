package dto;

public class EnrollmentDTO {
    private int enrollmentId;
    private int studentId;
    private String studentName;
    private String studentEmail;
    private int classId;
    private String className;
    private String courseTitle;
    private String teacherName;
    private String status;
    private java.util.Date enrolledAt;
    private java.util.Date startDate;
    private java.util.Date endDate;
    
    // Constructors
    public EnrollmentDTO() {}
    
    public EnrollmentDTO(int enrollmentId, int studentId, String studentName, String studentEmail,
                         int classId, String className, String courseTitle, String teacherName,
                         String status, java.util.Date enrolledAt, java.util.Date startDate, java.util.Date endDate) {
        this.enrollmentId = enrollmentId;
        this.studentId = studentId;
        this.studentName = studentName;
        this.studentEmail = studentEmail;
        this.classId = classId;
        this.className = className;
        this.courseTitle = courseTitle;
        this.teacherName = teacherName;
        this.status = status;
        this.enrolledAt = enrolledAt;
        this.startDate = startDate;
        this.endDate = endDate;
    }
    
    // Getters and Setters
    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }
    
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
    
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public java.util.Date getEnrolledAt() { return enrolledAt; }
    public void setEnrolledAt(java.util.Date enrolledAt) { this.enrolledAt = enrolledAt; }
    
    public java.util.Date getStartDate() { return startDate; }
    public void setStartDate(java.util.Date startDate) { this.startDate = startDate; }
    
    public java.util.Date getEndDate() { return endDate; }
    public void setEndDate(java.util.Date endDate) { this.endDate = endDate; }
}
