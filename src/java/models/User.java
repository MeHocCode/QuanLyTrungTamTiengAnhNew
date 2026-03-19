package models;

public class User {
    private int userId;
    private String name;
    private String email;
    private String passwordHash;
    private Role role;
    private String phone;
    private String active;
    private java.util.Date createdAt;
    
    // Constructors
    public User() {}
    
    public User(int userId, String name, String email, String passwordHash, Role role, String phone, String active) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.phone = phone;
        this.active = active;
        this.createdAt = new java.util.Date();
    }
    
    // Constructor for backward compatibility with roleId
    public User(int userId, String name, String email, String passwordHash, int roleId, String phone, String active) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = Role.fromRoleId(roleId);
        this.phone = phone;
        this.active = active;
        this.createdAt = new java.util.Date();
    }
    
    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    
    // Backward compatibility methods
    public int getRoleId() { 
        return role != null ? role.getRoleId() : 0; 
    }
    
    public void setRoleId(int roleId) { 
        this.role = Role.fromRoleId(roleId); 
    }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getActive() { return active; }
    public void setActive(String active) { this.active = active; }
    
    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
}
