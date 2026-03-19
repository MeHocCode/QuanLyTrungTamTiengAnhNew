<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mock Test Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                <%@ include file="../includes/admin-sidebar.jsp" %>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">Mock Test Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="mocktest?action=list" class="btn btn-sm btn-outline-secondary">Back to Mock Tests</a>
                        </div>
                        <div class="btn-group">
                            <a href="mocktest?action=edit&id=${test.testId}" class="btn btn-sm btn-warning">Edit Test</a>
                            <a href="testresult?action=list&testId=${test.testId}" class="btn btn-sm btn-primary">View Results</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Test Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Test ID:</strong> #${test.testId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Title:</strong> ${test.title}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Course:</strong> ${test.courseTitle}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${test.status == 'ACTIVE' ? 'success' : 'secondary'}">${test.status}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Duration:</strong> ${test.durationMinutes} minutes
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Questions:</strong> ${test.questionCount}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Created Date:</strong> ${test.createdAt}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Updated Date:</strong> ${test.updatedAt}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Description:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${test.description}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Instructions:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${test.instructions}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Test Statistics</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Total Attempts:</strong> ${test.totalAttempts}
                                </div>
                                <div class="mb-3">
                                    <strong>Average Score:</strong> ${test.averageScore}%
                                </div>
                                <div class="mb-3">
                                    <strong>Pass Rate:</strong> ${test.passRate}%
                                </div>
                                <div class="mb-3">
                                    <strong>Best Score:</strong> ${test.bestScore}%
                                </div>
                                
                                <div class="d-grid gap-2 mt-3">
                                    <a href="testresult?action=list&testId=${test.testId}" class="btn btn-primary w-100">View Results</a>
                                    <a href="mocktest?action=edit&id=${test.testId}" class="btn btn-warning w-100">Edit Test</a>
                                    <a href="course?action=detail&id=${test.courseId}" class="btn btn-info w-100">View Course</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Questions Preview -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Questions Preview</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>Question #</th>
                                                <th>Type</th>
                                                <th>Question Text</th>
                                                <th>Correct Answer</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${questions}" var="question">
                                                <tr>
                                                    <td>${question.questionNumber}</td>
                                                    <td>
                                                        <span class="badge bg-${question.type == 'MULTIPLE_CHOICE' ? 'primary' : 'info'}">${question.type}</span>
                                                    </td>
                                                    <td>${question.questionText}</td>
                                                    <td>${question.correctAnswer}</td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="question?action=edit&id=${question.questionId}" class="btn btn-sm btn-warning">Edit</a>
                                                            <a href="question?action=delete&id=${question.questionId}" class="btn btn-sm btn-danger">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <div class="mt-3">
                                    <a href="question?action=create&testId=${test.testId}" class="btn btn-primary">Add Question</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
