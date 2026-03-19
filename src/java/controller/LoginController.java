package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import models.Role;
import service.LoginService;

public class LoginController extends HttpServlet {
    
    private LoginService loginService;
    
    @Override
    public void init() throws ServletException {
        loginService = new LoginService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectToDashboard(user, request, response);
            return;
        }
        
        // Forward to login page
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter email and password");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Authenticate user
            User user = loginService.authenticate(email, password);
            
            if (user != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole().toString());
                session.setAttribute("userRoleEnum", user.getRole());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userId", user.getUserId());
                
                // Set session timeout (30 minutes)
                session.setMaxInactiveInterval(30 * 60);
                
                // Redirect to appropriate dashboard
                redirectToDashboard(user, request, response);
                
            } else {
                // Authentication failed
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/Login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }
    
    private void redirectToDashboard(User user, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Role userRole = user.getRole();
        
        switch (userRole) {
            case admin:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
            case teacher:
                response.sendRedirect(request.getContextPath() + "/teacher/dashboard");
                break;
            case student:
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/Home.jsp");
                break;
        }
    }
}
