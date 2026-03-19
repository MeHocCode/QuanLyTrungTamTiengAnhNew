package service;

import dal.UserDAO;
import java.util.List;
import models.User;

public class UserService {
    
    private UserDAO userDAO;
    
    public UserService() {
        this.userDAO = new UserDAO();
    }
    
    public User authenticate(String email, String password) {
        // TODO: Implement user authentication with business logic
        // 1. Validate email format
        // 2. Check if user exists and is active
        // 3. Verify password
        // 4. Return user object if valid
        if (email == null || email.trim().isEmpty()) {
            return null;
        }
        
        if (!isValidEmail(email)) {
            return null;
        }
        
        return userDAO.authenticate(email, password);
    }
    
    public boolean createUser(User user) {
        // TODO: Implement user creation with business validation
        // 1. Validate email format and uniqueness
        // 2. Validate password strength
        // 3. Validate role exists
        // 4. Create user record
        if (!isValidEmail(user.getEmail())) {
            return false;
        }
        
        if (isEmailRegistered(user.getEmail())) {
            return false; // Email already exists
        }
        
        // Validate role using enum instead of roleId
        if (user.getRole() == null) {
            return false; // Invalid role
        }
        
        try {
            userDAO.createAccount(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean updateUser(User user) {
        // TODO: Implement user update with business validation
        // 1. Validate user exists
        // 2. Validate email format (if changed)
        // 3. Validate role exists (if changed)
        // 4. Update user record
        User existingUser = userDAO.findById(user.getUserId());
        if (existingUser == null) {
            return false; // User doesn't exist
        }
        
        if (!user.getEmail().equals(existingUser.getEmail())) {
            if (!isValidEmail(user.getEmail())) {
                return false;
            }
            if (isEmailRegistered(user.getEmail())) {
                return false; // Email already exists
            }
        }
        
        // Validate role using enum instead of roleId
        if (user.getRole() == null) {
            return false; // Invalid role
        }
        
        try {
            userDAO.update(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    public boolean deleteUser(int userId) {
        // TODO: Implement user deletion with validation
        User user = userDAO.findById(userId);
        if (user == null) {
            return false; // User doesn't exist
        }
        
        try {
            userDAO.delete(userId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    public User getUserById(int userId) {
        // TODO: Implement get user by ID
        return userDAO.findById(userId);
    }
    
    public User getUserByEmail(String email) {
        // TODO: Implement get user by email
        return userDAO.findByEmail(email);
    }
    
    public List<User> getAllUsers() {
        // TODO: Implement get all users
        return userDAO.getAllUsers();
    }
    
    public boolean isEmailRegistered(String email) {
        // TODO: Check if email already exists
        User user = userDAO.findByEmail(email);
        return user != null;
    }
    
    private boolean isValidEmail(String email) {
        // TODO: Implement email validation
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
}
