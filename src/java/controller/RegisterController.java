package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import service.RegisterService;

public class RegisterController extends HttpServlet {
    
    private RegisterService registerService;
    
    @Override
    public void init() throws ServletException {
        registerService = new RegisterService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/Home.jsp");
            return;
        }
        
        // Forward to registration page
        request.getRequestDispatcher("/Register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String userType = request.getParameter("userType"); // Should always be "student"
            
            // Validate input
            String error = validateRegistrationInput(username, email, phone, password, confirmPassword, userType);
            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.getRequestDispatcher("/Register.jsp").forward(request, response);
                return;
            }
            
            // Create student user only
            User user = registerService.createStudentUser(username, email, password, phone);
            
            // Register user
            if (registerService.registerUser(user)) {
                // Registration successful
                request.setAttribute("success", "Registration successful! Please login to continue.");
                response.sendRedirect(request.getContextPath() + "/Login.jsp?success=Registration successful! Please login to continue.");
            } else {
                // Registration failed
                request.setAttribute("error", "Registration failed. Please try again.");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.getRequestDispatcher("/Register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
        }
    }
    
    private String validateRegistrationInput(String username, String email, 
                                          String phone, String password, String confirmPassword, 
                                          String userType) {
        
        // Check required fields
        if (username == null || username.trim().isEmpty()) {
            return "Username is required";
        }
        
        if (email == null || email.trim().isEmpty()) {
            return "Email is required";
        }
        
        if (phone == null || phone.trim().isEmpty()) {
            return "Phone number is required";
        }
        
        if (password == null || password.trim().isEmpty()) {
            return "Password is required";
        }
        
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            return "Please confirm your password";
        }
        
        // Validate username
        if (username.length() < 3 || username.length() > 50) {
            return "Username must be between 3 and 50 characters";
        }
        
        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            return "Invalid email format";
        }
        
        // Validate phone format (basic)
        if (!phone.matches("[0-9\\-\\+\\s]+")) {
            return "Invalid phone number format";
        }
        
        // Validate password
        if (password.length() < 6) {
            return "Password must be at least 6 characters long";
        }
        
        // Check password confirmation
        if (!password.equals(confirmPassword)) {
            return "Passwords do not match";
        }
        
        // Ensure user type is student
        if (!"student".equals(userType)) {
            return "Invalid user type. Only student registration is allowed.";
        }
        
        return null; // No validation errors
    }
    
    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
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
}
