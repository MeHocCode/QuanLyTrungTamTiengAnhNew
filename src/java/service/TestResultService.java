package service;

import java.util.List;
import models.TestResult;
import models.MockTest;
import models.Student;
import dal.TestResultDAO;
import dal.MockTestDAO;
import dal.StudentDAO;

public class TestResultService {
    
    private TestResultDAO testResultDAO;
    private MockTestDAO mockTestDAO;
    private StudentDAO studentDAO;
    
    public TestResultService() {
        this.testResultDAO = new TestResultDAO();
        this.mockTestDAO = new MockTestDAO();
        this.studentDAO = new StudentDAO();
    }
    
    public List<TestResult> getAllTestResults() {
        // TODO: Implement get all test results with business logic
        return testResultDAO.getAllTestResults();
    }
    
    public TestResult getTestResultById(int resultId) {
        // TODO: Implement get test result by ID with validation
        return testResultDAO.getTestResultById(resultId);
    }
    
    public boolean createTestResult(TestResult testResult) {
        // TODO: Implement test result creation with business validation
        // 1. Validate test exists
        // 2. Validate student exists
        // 3. Validate score range (0-100)
        // 4. Create test result record
        if (testResult.getScore() < 0 || testResult.getScore() > 100) {
            return false; // Invalid score
        }
        
        MockTest test = mockTestDAO.getMockTestById(testResult.getTestId());
        if (test == null) {
            return false; // Test doesn't exist
        }
        
        Student student = studentDAO.getStudentById(testResult.getStudentId());
        if (student == null) {
            return false; // Student doesn't exist
        }
        
        return testResultDAO.createTestResult(testResult);
    }
    
    public boolean updateTestResult(TestResult testResult) {
        // TODO: Implement test result update with business validation
        // 1. Validate test result exists
        // 2. Validate score range
        // 3. Update test result record
        if (testResult.getScore() < 0 || testResult.getScore() > 100) {
            return false; // Invalid score
        }
        
        TestResult existingResult = testResultDAO.getTestResultById(testResult.getResultId());
        if (existingResult == null) {
            return false; // Test result doesn't exist
        }
        
        return testResultDAO.updateTestResult(testResult);
    }
    
    public boolean deleteTestResult(int resultId) {
        // TODO: Implement test result deletion with validation
        TestResult result = testResultDAO.getTestResultById(resultId);
        if (result == null) {
            return false; // Test result doesn't exist
        }
        
        return testResultDAO.deleteTestResult(resultId);
    }
    
    public List<TestResult> getTestResultsByStudentId(int studentId) {
        // TODO: Implement get test results by student ID
        return testResultDAO.getTestResultsByStudentId(studentId);
    }
    
    public List<TestResult> getTestResultsByTestId(int testId) {
        // TODO: Implement get test results by test ID
        return testResultDAO.getTestResultsByTestId(testId);
    }
}
