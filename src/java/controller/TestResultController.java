package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.TestResult;
import service.TestResultService;

public class TestResultController extends HttpServlet {
    
    private TestResultService testResultService;
    
    public TestResultController() {
        this.testResultService = new TestResultService();
    }
    
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
        // TODO: Implement test result listing
        // Get all test results or filter by student/test
        List<TestResult> testResults = testResultService.getAllTestResults();
        request.setAttribute("testResults", testResults);
        request.getRequestDispatcher("/views/testresult/list.jsp").forward(request, response);
    }
    
    private void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement test result detail view
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            TestResult testResult = testResultService.getTestResultById(id);
            request.setAttribute("testResult", testResult);
        }
        request.getRequestDispatcher("/views/testresult/detail.jsp").forward(request, response);
    }
    
    private void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement test result creation
        // Get parameters from request
        String testIdParam = request.getParameter("testId");
        String studentIdParam = request.getParameter("studentId");
        String scoreParam = request.getParameter("score");
        String answersJson = request.getParameter("answersJson");
        
        try {
            if (testIdParam != null && studentIdParam != null && scoreParam != null) {
                int testId = Integer.parseInt(testIdParam);
                int studentId = Integer.parseInt(studentIdParam);
                int score = Integer.parseInt(scoreParam);
                
                TestResult testResult = new TestResult();
                testResult.setTestId(testId);
                testResult.setStudentId(studentId);
                testResult.setScore(score);
                testResult.setAnswersJson(answersJson);
                
                boolean success = testResultService.createTestResult(testResult);
                if (success) {
                    response.sendRedirect("testresult?action=list&success=true");
                } else {
                    request.setAttribute("error", "Failed to create test result");
                    request.getRequestDispatcher("/views/testresult/form.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Missing required parameters");
                request.getRequestDispatcher("/views/testresult/form.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format");
            request.getRequestDispatcher("/views/testresult/form.jsp").forward(request, response);
        }
    }
    
    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement test result update
        String idParam = request.getParameter("id");
        String scoreParam = request.getParameter("score");
        String answersJson = request.getParameter("answersJson");
        
        try {
            if (idParam != null && scoreParam != null) {
                int id = Integer.parseInt(idParam);
                int score = Integer.parseInt(scoreParam);
                
                TestResult testResult = testResultService.getTestResultById(id);
                if (testResult != null) {
                    testResult.setScore(score);
                    testResult.setAnswersJson(answersJson);
                    
                    boolean success = testResultService.updateTestResult(testResult);
                    if (success) {
                        response.sendRedirect("testresult?action=list&success=true");
                    } else {
                        request.setAttribute("error", "Failed to update test result");
                        request.setAttribute("testResult", testResult);
                        request.getRequestDispatcher("/views/testresult/form.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Test result not found");
                    response.sendRedirect("testresult?action=list");
                }
            } else {
                request.setAttribute("error", "Missing required parameters");
                response.sendRedirect("testresult?action=list");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format");
            response.sendRedirect("testresult?action=list");
        }
    }
    
    private void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Implement test result deletion
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                boolean success = testResultService.deleteTestResult(id);
                
                if (success) {
                    response.sendRedirect("testresult?action=list&success=true");
                } else {
                    request.setAttribute("error", "Failed to delete test result");
                    response.sendRedirect("testresult?action=list");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid ID format");
                response.sendRedirect("testresult?action=list");
            }
        } else {
            request.setAttribute("error", "Missing ID parameter");
            response.sendRedirect("testresult?action=list");
        }
    }
}
