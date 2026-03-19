package service;

import java.security.MessageDigest;
import java.util.Base64;

public class PasswordService {
    
    public static String hashPassword(String password) {
        // TODO: Implement password hashing using SHA-256
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(hash);
        } catch (Exception e) {
            // TODO: Handle hashing exception
            return null;
        }
    }
    
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        // TODO: Implement password verification
        String computedHash = hashPassword(plainPassword);
        return computedHash != null && computedHash.equals(hashedPassword);
    }
    
}
