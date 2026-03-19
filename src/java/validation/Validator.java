package validation;

import java.util.regex.Pattern;

public class Validator {
    
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@(.+)$"
    );
    
    // Phone validation pattern
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^[+]?[0-9]{10,15}$"
    );
    
    public static boolean isValidEmail(String email) {
        // TODO: Implement email validation
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }
    
    public static boolean isValidPhone(String phone) {
        // TODO: Implement phone validation
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }
    
    public static boolean isValidPassword(String password) {
        // TODO: Implement password validation (minimum 8 characters, at least one uppercase, one lowercase, one digit)
        return password != null && password.length() >= 8;
    }
    
    public static boolean isNotEmpty(String value) {
        // TODO: Implement non-empty validation
        return value != null && !value.trim().isEmpty();
    }
    
    public static boolean isValidDate(String date) {
        // TODO: Implement date validation
        return date != null && !date.trim().isEmpty();
    }
    
    public static boolean isValidNumber(String number) {
        // TODO: Implement number validation
        try {
            Double.parseDouble(number);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
