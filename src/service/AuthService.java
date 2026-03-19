package service;

import dal.UserDAO;
import models.User;

public class AuthService {
    
    private UserDAO userDAO;
    
    public AuthService() {
        this.userDAO = new UserDAO();
    }
    
    public User authenticate(String email, String password) {
        // TODO: Implement authentication logic
        // 1. Validate email and password not null/empty
        // 2. Hash password and compare with database
        // 3. Return user object if valid, null if invalid
        return userDAO.authenticate(email, password);
    }
    
    public boolean isEmailRegistered(String email) {
        // TODO: Check if email already exists in database
        User user = userDAO.findByEmail(email);
        return user != null;
    }
    
    public User getUserByEmail(String email) {
        // TODO: Get user by email
        return userDAO.findByEmail(email);
    }
    
    public boolean validatePassword(String password) {
        // TODO: Implement password validation rules
        // - Minimum length: 8 characters
        // - Contains at least one uppercase letter
        // - Contains at least one lowercase letter
        // - Contains at least one number
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUpper = !password.equals(password.toLowerCase());
        boolean hasLower = !password.equals(password.toUpperCase());
        boolean hasDigit = password.matches(".*\\d.*");
        
        return hasUpper && hasLower && hasDigit;
    }
}
