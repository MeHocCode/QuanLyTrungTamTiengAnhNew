package models;

public class Assignment {
    private int assignmentId;
    private int classId;
    private int teacherId;
    private String title;
    private String description;
    private java.util.Date startDate;
    private java.util.Date endDate;
    private java.util.Date createdAt;
    
    // Constructors
    public Assignment() {}
    
    public Assignment(int assignmentId, int classId, int teacherId, String title, String description, java.util.Date startDate, java.util.Date endDate) {
        this.assignmentId = assignmentId;
        this.classId = classId;
        this.teacherId = teacherId;
        this.title = title;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getAssignmentId() { return assignmentId; }
    public void setAssignmentId(int assignmentId) { this.assignmentId = assignmentId; }
    
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }
    
    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public java.util.Date getStartDate() { return startDate; }
    public void setStartDate(java.util.Date startDate) { this.startDate = startDate; }
    
    public java.util.Date getEndDate() { return endDate; }
    public void setEndDate(java.util.Date endDate) { this.endDate = endDate; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
