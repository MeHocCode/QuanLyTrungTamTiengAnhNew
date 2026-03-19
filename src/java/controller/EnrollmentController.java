package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EnrollmentController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                list(request, response);
                break;
            case "detail":
                detail(request, response);
                break;
            case "enroll":
                enroll(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        switch (action) {
            case "enroll":
                enroll(request, response);
                break;
            case "approve":
                approve(request, response);
                break;
            case "reject":
                reject(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }
    
    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement enrollment listing
    }
    
    private void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement enrollment detail view
    }
    
    private void enroll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement enrollment
    }
    
    private void approve(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement enrollment approval
    }
    
    private void reject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement enrollment rejection
    }
}
