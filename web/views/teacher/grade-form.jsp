<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade Submission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                <%@ include file="../includes/teacher-sidebar.jsp" %>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">Grade Submission</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="submission?action=list" class="btn btn-sm btn-outline-secondary">Back to Submissions</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Submission Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Student:</strong> ${submission.studentName}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Assignment:</strong> ${submission.assignmentTitle}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Submit Date:</strong> ${submission.submitDate}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Max Score:</strong> ${submission.maxScore}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Content:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${submission.content}
                                    </div>
                                </div>
                                
                                <c:if test="${submission.filePath != null}">
                                    <div class="mb-3">
                                        <strong>Attached File:</strong>
                                        <div class="mt-2">
                                            <a href="submission?action=download&id=${submission.submissionId}" class="btn btn-sm btn-success">Download File</a>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Grade Submission</h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="submission?action=grade">
                                    <input type="hidden" name="submissionId" value="${submission.submissionId}">
                                    
                                    <div class="mb-3">
                                        <label for="score" class="form-label">Score</label>
                                        <input type="number" class="form-control" id="score" name="score" min="0" max="${submission.maxScore}" required placeholder="Enter score...">
                                        <small class="form-text text-muted">Max score: ${submission.maxScore}</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="feedback" class="form-label">Feedback</label>
                                        <textarea class="form-control" id="feedback" name="feedback" rows="4" placeholder="Enter feedback..."></textarea>
                                    </div>
                                    
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary">Submit Grade</button>
                                        <a href="submission?action=list" class="btn btn-secondary">Cancel</a>
                                    </div>
                                </form>
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
