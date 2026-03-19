package models;

public class MockTest {
    private int testId;
    private int courseId;
    private int teacherId;
    private String title;
    private String description;
    private String questionsJson;
    private int durationMinutes;
    private double passingScore;
    private boolean isActive;
    private java.util.Date createdAt;
    
    // Constructors
    public MockTest() {}
    
    public MockTest(int testId, int courseId, int teacherId, String title, String description, 
                     String questionsJson, int durationMinutes, double passingScore, boolean isActive) {
        this.testId = testId;
        this.courseId = courseId;
        this.teacherId = teacherId;
        this.title = title;
        this.description = description;
        this.questionsJson = questionsJson;
        this.durationMinutes = durationMinutes;
        this.passingScore = passingScore;
        this.isActive = isActive;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getTestId() { return testId; }
    public void setTestId(int testId) { this.testId = testId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getQuestionsJson() { return questionsJson; }
    public void setQuestionsJson(String questionsJson) { this.questionsJson = questionsJson; }
    
    public int getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(int durationMinutes) { this.durationMinutes = durationMinutes; }
    
    public double getPassingScore() { return passingScore; }
    public void setPassingScore(double passingScore) { this.passingScore = passingScore; }
    
    public boolean getIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
