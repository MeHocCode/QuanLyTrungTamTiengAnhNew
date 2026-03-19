package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import models.Role;

public class DashboardTeacherController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is teacher
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp?error=Please login to access teacher dashboard");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (user.getRole() != Role.teacher) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp?error=You don't have permission to access teacher dashboard");
            return;
        }
        
        // Set user data for dashboard
        request.setAttribute("userName", user.getName());
        request.setAttribute("userRole", user.getRole().toString());
        
        // Forward to teacher dashboard JSP
        request.getRequestDispatcher("/views/teacher/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
