package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LeadController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "form";
        }
        
        switch (action) {
            case "form":
                form(request, response);
                break;
            case "success":
                success(request, response);
                break;
            default:
                form(request, response);
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
            default:
                form(request, response);
                break;
        }
    }
    
    private void form(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement lead form
    }
    
    private void success(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement lead success page
    }
    
    private void submit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement lead submission
    }
}
