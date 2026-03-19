package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class TeacherController extends HttpServlet {
    
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
            case "create":
                create(request, response);
                break;
            case "update":
                update(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            default:
                list(request, response);
                break;
        }
    }
    
    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement teacher listing
    }
    
    private void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement teacher detail view
    }
    
    private void form(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement teacher form
    }
    
    private void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement teacher creation
    }
    
    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement teacher update
    }
    
    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement teacher deletion
    }
}
