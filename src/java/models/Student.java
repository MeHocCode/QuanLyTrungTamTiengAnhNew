package models;

public class Student {
    private int studentId;
    private int userId;
    private java.util.Date dateOfBirth;
    private String address;
    private String parentName;
    private String parentPhone;
    private String level;
    
    // Constructors
    public Student() {}
    
    public Student(int studentId, int userId, java.util.Date dateOfBirth, String address, String parentName, String parentPhone, String level) {
        this.studentId = studentId;
        this.userId = userId;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.parentName = parentName;
        this.parentPhone = parentPhone;
        this.level = level;
    }
    
    // Getters and Setters
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public java.util.Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(java.util.Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getParentName() { return parentName; }
    public void setParentName(String parentName) { this.parentName = parentName; }
    
    public String getParentPhone() { return parentPhone; }
    public void setParentPhone(String parentPhone) { this.parentPhone = parentPhone; }
    
    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
}
