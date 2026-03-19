<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Result Details</title>
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
                    <h1 class="h4">Test Result Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="testresult?action=list" class="btn btn-sm btn-outline-secondary">Back to Results</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Test Performance</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Result ID:</strong> #${result.resultId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Test Date:</strong> ${result.testDate}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Student:</strong> ${result.studentName}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Mock Test:</strong> ${result.testTitle}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Score:</strong> ${result.score}%
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Grade:</strong> 
                                        <span class="badge bg-${result.letterGrade == 'A' ? 'success' : result.letterGrade == 'B' ? 'info' : result.letterGrade == 'C' ? 'warning' : 'danger'}">${result.letterGrade}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Correct Answers:</strong> ${result.correctAnswers}/${result.totalQuestions}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Time Taken:</strong> ${result.timeTaken}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Performance Analysis:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        <c:if test="${result.score >= 80}">
                                            <p class="text-success">Excellent performance! Student has mastered the material.</p>
                                        </c:if>
                                        <c:if test="${result.score >= 60 && result.score < 80}">
                                            <p class="text-info">Good performance with room for improvement.</p>
                                        </c:if>
                                        <c:if test="${result.score < 60}">
                                            <p class="text-warning">Needs improvement. Additional practice recommended.</p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="student?action=detail&id=${result.studentId}" class="btn btn-info w-100">View Student</a>
                                    <a href="mocktest?action=detail&id=${result.testId}" class="btn btn-primary w-100">View Test</a>
                                    <a href="testresult?action=download&id=${result.resultId}" class="btn btn-success w-100">Download Result</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Answer Details -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Answer Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>Question</th>
                                                <th>Your Answer</th>
                                                <th>Correct Answer</th>
                                                <th>Result</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${result.answers}" var="answer">
                                                <tr class="${answer.correct == true ? 'table-success' : 'table-danger'}">
                                                    <td>${answer.questionNumber}</td>
                                                    <td>${answer.userAnswer}</td>
                                                    <td>${answer.correctAnswer}</td>
                                                    <td>
                                                        <span class="badge bg-${answer.correct == true ? 'success' : 'danger'}">${answer.correct == true ? 'Correct' : 'Incorrect'}</span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
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
