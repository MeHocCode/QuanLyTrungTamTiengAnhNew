<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade Details</title>
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
                    <h1 class="h4">Grade Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="grade?action=list" class="btn btn-sm btn-outline-secondary">Back to Grades</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Grade Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Assignment:</strong> ${grade.assignmentTitle}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Class:</strong> ${grade.className}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Score:</strong> ${grade.score}/${grade.maxScore}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Percentage:</strong> ${grade.scorePercentage}%
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Letter Grade:</strong> 
                                        <span class="badge bg-${grade.letterGrade == 'A' ? 'success' : grade.letterGrade == 'B' ? 'info' : grade.letterGrade == 'C' ? 'warning' : 'danger'}">${grade.letterGrade}</span>
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Graded Date:</strong> ${grade.gradedDate}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Submit Date:</strong> ${grade.submitDate}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Teacher:</strong> ${grade.teacherName}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Teacher Feedback:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${grade.feedback}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Performance</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Performance Level:</strong>
                                    <div class="mt-2">
                                        <div class="progress">
                                            <div class="progress-bar bg-${grade.scorePercentage >= 80 ? 'success' : grade.scorePercentage >= 60 ? 'warning' : 'danger'}" style="width: ${grade.scorePercentage}%"></div>
                                        </div>
                                        <small class="text-muted">${grade.scorePercentage}% Complete</small>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Grade Analysis:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        <c:if test="${grade.scorePercentage >= 90}">
                                            <p class="text-success">Excellent performance! Keep up the great work.</p>
                                        </c:if>
                                        <c:if test="${grade.scorePercentage >= 80 && grade.scorePercentage < 90}">
                                            <p class="text-info">Good performance with room for improvement.</p>
                                        </c:if>
                                        <c:if test="${grade.scorePercentage >= 70 && grade.scorePercentage < 80}">
                                            <p class="text-warning">Satisfactory performance. Consider reviewing areas for improvement.</p>
                                        </c:if>
                                        <c:if test="${grade.scorePercentage < 70}">
                                            <p class="text-danger">Needs improvement. Please seek additional help.</p>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <a href="submission?action=detail&id=${grade.submissionId}" class="btn btn-primary w-100">View Submission</a>
                                    <a href="assignment?action=detail&id=${grade.assignmentId}" class="btn btn-info w-100">View Assignment</a>
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
