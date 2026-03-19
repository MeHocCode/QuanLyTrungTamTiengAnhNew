package dto;

public class StudentDTO {
    private int studentId;
    private int userId;
    private String name;
    private String email;
    private String phone;
    private java.util.Date dateOfBirth;
    private String address;
    private String parentName;
    private String parentPhone;
    private String level;
    private String active;
    
    // Constructors
    public StudentDTO() {}
    
    public StudentDTO(int studentId, int userId, String name, String email, String phone,
                      java.util.Date dateOfBirth, String address, String parentName, 
                      String parentPhone, String level, String active) {
        this.studentId = studentId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.parentName = parentName;
        this.parentPhone = parentPhone;
        this.level = level;
        this.active = active;
    }
    
    // Getters and Setters
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
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
    
    public String getActive() { return active; }
    public void setActive(String active) { this.active = active; }
}
