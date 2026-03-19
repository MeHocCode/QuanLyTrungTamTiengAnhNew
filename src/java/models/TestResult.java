package models;

public class TestResult {
    private int resultId;
    private int testId;
    private int studentId;
    private int score;
    private String answersJson;
    private java.util.Date completedAt;
    private java.util.Date createdAt;
    
    // Constructors
    public TestResult() {}
    
    public TestResult(int resultId, int testId, int studentId, int score, String answersJson) {
        this.resultId = resultId;
        this.testId = testId;
        this.studentId = studentId;
        this.score = score;
        this.answersJson = answersJson;
        this.completedAt = new java.util.Date();
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getResultId() { return resultId; }
    public void setResultId(int resultId) { this.resultId = resultId; }
    
    public int getTestId() { return testId; }
    public void setTestId(int testId) { this.testId = testId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
    
    public String getAnswersJson() { return answersJson; }
    public void setAnswersJson(String answersJson) { this.answersJson = answersJson; }
    
    public java.util.Date getCompletedAt() { return completedAt; }
    public void setCompletedAt(java.util.Date completedAt) { this.completedAt = completedAt; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
