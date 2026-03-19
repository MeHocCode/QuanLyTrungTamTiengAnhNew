package models;

public enum Role {
    admin,
    teacher,
    student;
    
    // Method to get Role by roleId (for backward compatibility)
    public static Role fromRoleId(int roleId) {
        switch (roleId) {
            case 1: return admin;
            case 2: return teacher;
            case 3: return student;
            default: throw new IllegalArgumentException("Invalid roleId: " + roleId);
        }
    }
    
    // Method to get roleId from Role
    public int getRoleId() {
        switch (this) {
            case admin: return 1;
            case teacher: return 2;
            case student: return 3;
            default: return 0;
        }
    }
    
    // Method to get display name
    public String getDisplayName() {
        switch (this) {
            case admin: return "Admin";
            case teacher: return "Teacher";
            case student: return "Student";
            default: return "Unknown";
        }
    }
    
    @Override
    public String toString() {
        return name();
    }
}
