package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class PaymentController extends HttpServlet {
    
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
            case "pay":
                pay(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }
    
    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement payment listing
    }
    
    private void form(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement payment form
    }
    
    private void pay(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement payment processing
    }
}
