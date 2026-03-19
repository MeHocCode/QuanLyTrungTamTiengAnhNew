package service;

import dal.UserDAO;
import models.Role;
import models.User;

public class LoginService {
    
    private UserDAO userDAO;
    
    public LoginService() {
        this.userDAO = new UserDAO();
    }
    
    public User authenticate(String email, String password) {
        try {
            // Get user by email
            User user = userDAO.findByEmail(email);
            
            if (user != null && "ACTIVE".equals(user.getActive())) {
                // Verify password using the stored hash
                if (PasswordService.verifyPassword(password, user.getPasswordHash())) {
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean validatePassword(String email, String password) {
        User user = userDAO.findByEmail(email);
        if (user != null) {
            return PasswordService.verifyPassword(password, user.getPasswordHash());
        }
        return false;
    }
    
    public String getUserRole(String email) {
        User user = userDAO.findByEmail(email);
        if (user != null && user.getRole() != null) {
            return user.getRole().toString();
        }
        return null;
    }
    
    public Role getUserRoleEnum(String email) {
        User user = userDAO.findByEmail(email);
        if (user != null) {
            return user.getRole();
        }
        return null;
    }
}
