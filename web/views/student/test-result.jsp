<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                <%@ include file="../includes/student-sidebar.jsp" %>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">Test Result</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="mocktest?action=list" class="btn btn-sm btn-outline-secondary">Back to Tests</a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Test Performance</h5>
                            </div>
                            <div class="card-body text-center">
                                <div class="row mb-4">
                                    <div class="col-md-4">
                                        <h3 class="text-primary">${result.score}%</h3>
                                        <p class="text-muted">Score</p>
                                    </div>
                                    <div class="col-md-4">
                                        <h3 class="text-success">${result.correctAnswers}/${result.totalQuestions}</h3>
                                        <p class="text-muted">Correct Answers</p>
                                    </div>
                                    <div class="col-md-4">
                                        <h3 class="text-info">${result.timeTaken}</h3>
                                        <p class="text-muted">Time Taken</p>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <h4>Grade: <span class="badge bg-${result.letterGrade == 'A' ? 'success' : result.letterGrade == 'B' ? 'info' : result.letterGrade == 'C' ? 'warning' : 'danger'}">${result.letterGrade}</span></h4>
                                </div>
                                
                                <div class="progress mb-4" style="height: 25px;">
                                    <div class="progress-bar bg-${result.score >= 80 ? 'success' : result.score >= 60 ? 'warning' : 'danger'}" style="width: ${result.score}%">
                                        ${result.score}%
                                    </div>
                                </div>
                                
                                <div class="alert alert-${result.score >= 70 ? 'success' : 'warning'}">
                                    <c:if test="${result.score >= 80}">
                                        <strong>Excellent!</strong> You have mastered this material. Keep up the great work!
                                    </c:if>
                                    <c:if test="${result.score >= 70 && result.score < 80}">
                                        <strong>Good Job!</strong> You have a solid understanding. Review areas for improvement.
                                    </c:if>
                                    <c:if test="${result.score >= 60 && result.score < 70}">
                                        <strong>Pass!</strong> You met the minimum requirements. Consider additional practice.
                                    </c:if>
                                    <c:if test="${result.score < 60}">
                                        <strong>Needs Improvement!</strong> Please review the material and consider retaking the test.
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card mt-4">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Detailed Results</h5>
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
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <a href="mocktest?action=list" class="btn btn-primary">View More Tests</a>
                            <c:if test="${result.score < 70}">
                                <a href="mocktest?action=retake&id=${result.testId}" class="btn btn-warning">Retake Test</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
