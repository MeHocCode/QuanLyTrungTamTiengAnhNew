package models;

public class Teacher {
    private int userId;
    private String expertise;
    private int experienceYears;
    private String qualification;
    
    // Constructors
    public Teacher() {}
    
    public Teacher(int userId, String expertise, int experienceYears, String qualification) {
        this.userId = userId;
        this.expertise = expertise;
        this.experienceYears = experienceYears;
        this.qualification = qualification;
    }
    
    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getExpertise() { return expertise; }
    public void setExpertise(String expertise) { this.expertise = expertise; }
    
    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }
    
    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }
}
