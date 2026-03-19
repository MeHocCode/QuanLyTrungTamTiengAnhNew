package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubmissionController extends HttpServlet {
    
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
            case "form":
                form(request, response);
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
            case "submit":
                submit(request, response);
                break;
            case "grade":
                grade(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }
    
    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement submission listing
    }
    
    private void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement submission detail view
    }
    
    private void form(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement submission form
    }
    
    private void submit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement assignment submission
    }
    
    private void grade(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement submission grading
    }
}
