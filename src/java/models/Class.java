package models;

public class Class {
    private int classId;
    private int courseId;
    private int teacherId;
    private java.util.Date startDate;
    private java.util.Date endDate;
    private int maxSize;
    private String scheduleJson;
    private String locationOrLink;
    private String status;
    private java.util.Date createdAt;
    
    // Constructors
    public Class() {}
    
    public Class(int classId, int courseId, int teacherId, java.util.Date startDate, java.util.Date endDate, int maxSize, String scheduleJson, String locationOrLink, String status) {
        this.classId = classId;
        this.courseId = courseId;
        this.teacherId = teacherId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.maxSize = maxSize;
        this.scheduleJson = scheduleJson;
        this.locationOrLink = locationOrLink;
        this.status = status;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
    
    public java.util.Date getStartDate() { return startDate; }
    public void setStartDate(java.util.Date startDate) { this.startDate = startDate; }
    
    public java.util.Date getEndDate() { return endDate; }
    public void setEndDate(java.util.Date endDate) { this.endDate = endDate; }
    
    public int getMaxSize() { return maxSize; }
    public void setMaxSize(int maxSize) { this.maxSize = maxSize; }
    
    public String getScheduleJson() { return scheduleJson; }
    public void setScheduleJson(String scheduleJson) { this.scheduleJson = scheduleJson; }
    
    public String getLocationOrLink() { return locationOrLink; }
    public void setLocationOrLink(String locationOrLink) { this.locationOrLink = locationOrLink; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
