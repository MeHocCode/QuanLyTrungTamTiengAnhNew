package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import models.Role;

public class DashboardStudentController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is student
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp?error=Please login to access student dashboard");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != Role.student) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp?error=You don't have permission to access student dashboard");
            return;
        }
        
        // Set user data for dashboard
        request.setAttribute("userName", user.getName());
        request.setAttribute("userRole", user.getRole().toString());
        
        // Forward to student dashboard JSP
        request.getRequestDispatcher("/views/student/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
