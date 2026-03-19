package service;

import java.util.regex.Pattern;
import models.User;
import models.Student;
import models.Teacher;
import models.Course;
import models.Class;

public class ValidationService {
    
    // Email validation
    public boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return Pattern.matches(emailRegex, email);
    }
    
    // Password validation
    public boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUpper = !password.equals(password.toLowerCase());
        boolean hasLower = !password.equals(password.toUpperCase());
        boolean hasDigit = password.matches(".*\\d.*");
        
        return hasUpper && hasLower && hasDigit;
    }
    
    // Phone validation
    public boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return true; // Phone is optional
        }
        
        // Remove spaces, dashes, parentheses
        String cleanPhone = phone.replaceAll("[\\s\\-\\(\\)]", "");
        
        // Check if it's a valid phone number (10-15 digits)
        return cleanPhone.matches("\\d{10,15}");
    }
    
    // Name validation
    public boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        
        // Name should be 2-50 characters, letters and spaces only
        String trimmedName = name.trim();
        return trimmedName.length() >= 2 && 
               trimmedName.length() <= 50 && 
               trimmedName.matches("^[a-zA-Z\\s]+$");
    }
    
    // User validation
    public void validateUser(User user) throws ValidationException {
        if (!isValidName(user.getName())) {
            throw new ValidationException("Name must be 2-50 characters and contain only letters");
        }
        
        if (!isValidEmail(user.getEmail())) {
            throw new ValidationException("Invalid email format");
        }
        
        if (!isValidPhone(user.getPhone())) {
            throw new ValidationException("Invalid phone number format");
        }
    }
    
}
