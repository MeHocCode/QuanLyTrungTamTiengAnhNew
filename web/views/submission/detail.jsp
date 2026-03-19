<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submission Details</title>
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
                    <h1 class="h4">Submission Details</h1>
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
                                <h5 class="card-title mb-0">Submission Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Submission ID:</strong> #${submission.submissionId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${submission.status == 'SUBMITTED' ? 'info' : 'success'}">${submission.status}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Student:</strong> ${submission.studentName}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Email:</strong> ${submission.studentEmail}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Assignment:</strong> ${submission.assignmentTitle}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Class:</strong> ${submission.className}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Submit Date:</strong> ${submission.submitDate}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Due Date:</strong> ${submission.dueDate}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Submission Content:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${submission.content}
                                    </div>
                                </div>
                                
                                <c:if test="${submission.fileName != null}">
                                    <div class="mb-3">
                                        <strong>Attached File:</strong>
                                        <div class="mt-2">
                                            <a href="submission?action=download&id=${submission.submissionId}" class="btn btn-sm btn-success">
                                                <i class="bi bi-download"></i> Download ${submission.fileName}
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <c:if test="${submission.feedback != null}">
                                    <div class="mb-3">
                                        <strong>Teacher Feedback:</strong>
                                        <div class="mt-2 p-3 bg-info text-white rounded">
                                            ${submission.feedback}
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Grading Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Score:</strong>
                                    <div class="mt-1">
                                        <c:if test="${submission.score != null}">
                                            <span class="badge bg-success">${submission.score}/${submission.maxScore}</span>
                                        </c:if>
                                        <c:if test="${submission.score == null}">
                                            <span class="badge bg-warning">Not graded</span>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Graded Date:</strong>
                                    <div class="mt-1">${submission.gradedAt}</div>
                                </div>
                                
                                <div class="d-grid gap-2 mt-3">
                                    <a href="student?action=detail&id=${submission.studentId}" class="btn btn-info w-100">View Student</a>
                                    <a href="assignment?action=detail&id=${submission.assignmentId}" class="btn btn-primary w-100">View Assignment</a>
                                    <c:if test="${submission.status == 'SUBMITTED'}">
                                        <a href="grade?action=form&id=${submission.submissionId}" class="btn btn-success w-100">Grade Submission</a>
                                    </c:if>
                                    <c:if test="${submission.status == 'SUBMITTED'}">
                                        <a href="submission?action=edit&id=${submission.submissionId}" class="btn btn-warning w-100">Edit Submission</a>
                                    </c:if>
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
