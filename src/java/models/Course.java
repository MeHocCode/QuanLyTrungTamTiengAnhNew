package models;

public class Course {
    private int courseId;
    private String title;
    private String description;
    private String level;
    private double price;
    private String type;
    private int durationWeeks;
    private String published;
    private java.util.Date createdAt;
    
    // Constructors
    public Course() {}
    
    public Course(int courseId, String title, String description, String level, double price, String type, int durationWeeks, String published) {
        this.courseId = courseId;
        this.title = title;
        this.description = description;
        this.level = level;
        this.price = price;
        this.type = type;
        this.durationWeeks = durationWeeks;
        this.published = published;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public int getDurationWeeks() { return durationWeeks; }
    public void setDurationWeeks(int durationWeeks) { this.durationWeeks = durationWeeks; }
    
    public String getPublished() { return published; }
    public void setPublished(String published) { this.published = published; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
