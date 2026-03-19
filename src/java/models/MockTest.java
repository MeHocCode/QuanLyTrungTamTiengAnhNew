package models;

public class MockTest {
    private int testId;
    private int classId;
    private String title;
    private String questionsJson;
    private java.util.Date createdAt;
    
    // Constructors
    public MockTest() {}
    
    public MockTest(int testId, int classId, String title, String questionsJson) {
        this.testId = testId;
        this.classId = classId;
        this.title = title;
        this.questionsJson = questionsJson;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getTestId() { return testId; }
    public void setTestId(int testId) { this.testId = testId; }
    
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getQuestionsJson() { return questionsJson; }
    public void setQuestionsJson(String questionsJson) { this.questionsJson = questionsJson; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
