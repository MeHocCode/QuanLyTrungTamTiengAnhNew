package models;

public class Lead {
    private int id;
    private String name;
    private String phone;
    private String email;
    private String note;
    private String status;
    private java.util.Date createdAt;
    
    // Constructors
    public Lead() {}
    
    public Lead(int id, String name, String phone, String email, String note, String status) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.note = note;
        this.status = status;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
