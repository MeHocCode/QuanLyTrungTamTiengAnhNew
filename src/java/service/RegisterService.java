package service;

import dal.UserDAO;
import java.util.regex.Pattern;
import models.Role;
import models.User;

public class RegisterService {
    
    private UserDAO userDAO;
    
    public RegisterService() {
        this.userDAO = new UserDAO();
    }
    
    public boolean registerUser(User user) {
        try {
            // Validate registration data first
            if (!validateRegistrationData(user)) {
                return false;
            }
            
            // Check if email already exists
            if (isEmailExists(user.getEmail())) {
                return false;
            }
            
            // Hash the password
            String hashedPassword = PasswordService.hashPassword(user.getPasswordHash());
            user.setPasswordHash(hashedPassword);
            
            // Set default values
            user.setActive("ACTIVE");
            user.setCreatedAt(new java.util.Date());
            
            // Create user
            userDAO.createAccount(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean isEmailExists(String email) {
        User existingUser = userDAO.findByEmail(email);
        return existingUser != null;
    }
    
    public boolean validateRegistrationData(User user) {
        if (user == null) {
            return false;
        }
        
        // Validate name
        if (user.getName() == null || user.getName().trim().isEmpty() || user.getName().length() < 2 || user.getName().length() > 50) {
            return false;
        }
        
        // Validate email
        if (!isValidEmail(user.getEmail())) {
            return false;
        }
        
        // Validate password
        if (user.getPasswordHash() == null || user.getPasswordHash().length() < 6) {
            return false;
        }
        
        // Validate phone
        if (user.getPhone() != null && !isValidPhone(user.getPhone())) {
            return false;
        }
        
        // Validate role
        if (user.getRoleId() < 1 || user.getRoleId() > 3) {
            return false;
        }
        
        return true;
    }
    
    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }
    
    private boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return true; // Phone is optional
        }
        
        // Remove all non-digit characters
        String phoneDigits = phone.replaceAll("[^0-9]", "");
        
        // Check if phone has valid length (10-15 digits)
        return phoneDigits.length() >= 10 && phoneDigits.length() <= 15;
    }
    
    public User createStudentUser(String username, String email, String password, String phone) {
        User user = new User();
        user.setName(username);
        user.setEmail(email);
        user.setPasswordHash(password);
        user.setPhone(phone);
        user.setRole(Role.student);
        return user;
    }
    
    public User createTeacherUser(String firstName, String lastName, String email, String password, String phone) {
        User user = new User();
        user.setName(firstName + " " + lastName);
        user.setEmail(email);
        user.setPasswordHash(password);
        user.setPhone(phone);
        user.setRole(Role.teacher);
        return user;
    }
}
