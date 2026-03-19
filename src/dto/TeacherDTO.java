package dto;

public class TeacherDTO {
    private int teacherId;
    private int userId;
    private String name;
    private String email;
    private String phone;
    private String expertise;
    private int experienceYears;
    private String qualification;
    private String active;
    
    // Constructors
    public TeacherDTO() {}
    
    public TeacherDTO(int teacherId, int userId, String name, String email, String phone, 
                     String expertise, int experienceYears, String qualification, String active) {
        this.teacherId = teacherId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.expertise = expertise;
        this.experienceYears = experienceYears;
        this.qualification = qualification;
        this.active = active;
    }
    
    // Getters and Setters
    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getExpertise() { return expertise; }
    public void setExpertise(String expertise) { this.expertise = expertise; }
    
    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }
    
    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }
    
    public String getActive() { return active; }
    public void setActive(String active) { this.active = active; }
}
