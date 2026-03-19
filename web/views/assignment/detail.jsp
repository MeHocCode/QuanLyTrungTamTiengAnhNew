<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignment Details</title>
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
                    <h1 class="h4">Assignment Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="assignment?action=list" class="btn btn-sm btn-outline-secondary">Back to Assignments</a>
                        </div>
                        <div class="btn-group">
                            <a href="assignment?action=edit&id=${assignment.assignmentId}" class="btn btn-sm btn-warning">Edit Assignment</a>
                            <a href="submission?action=list&assignmentId=${assignment.assignmentId}" class="btn btn-sm btn-primary">View Submissions</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Assignment Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Assignment ID:</strong> #${assignment.assignmentId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Title:</strong> ${assignment.title}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Class:</strong> ${assignment.className}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Teacher:</strong> ${assignment.teacherName}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Due Date:</strong> ${assignment.dueDate}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Max Score:</strong> ${assignment.maxScore}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${assignment.status == 'ACTIVE' ? 'success' : assignment.status == 'CLOSED' ? 'secondary' : 'warning'}">${assignment.status}</span>
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Created Date:</strong> ${assignment.createdAt}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Description:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${assignment.description}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Instructions:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${assignment.instructions}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Assignment Statistics</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Total Students:</strong> ${assignment.studentCount}
                                </div>
                                <div class="mb-3">
                                    <strong>Submitted:</strong> ${assignment.submissionCount}
                                </div>
                                <div class="mb-3">
                                    <strong>Pending:</strong> ${assignment.pendingCount}
                                </div>
                                <div class="mb-3">
                                    <strong>Graded:</strong> ${assignment.gradedCount}
                                </div>
                                
                                <div class="d-grid gap-2 mt-3">
                                    <a href="submission?action=list&assignmentId=${assignment.assignmentId}" class="btn btn-primary w-100">View Submissions</a>
                                    <a href="assignment?action=edit&id=${assignment.assignmentId}" class="btn btn-warning w-100">Edit Assignment</a>
                                    <a href="class?action=detail&id=${assignment.classId}" class="btn btn-info w-100">View Class</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Submissions -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Recent Submissions</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Student</th>
                                                <th>Submit Date</th>
                                                <th>Status</th>
                                                <th>Score</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentSubmissions}" var="submission">
                                                <tr>
                                                    <td>${submission.studentName}</td>
                                                    <td>${submission.submitDate}</td>
                                                    <td>
                                                        <span class="badge bg-${submission.status == 'SUBMITTED' ? 'info' : 'success'}">${submission.status}</span>
                                                    </td>
                                                    <td>
                                                        <c:if test="${submission.score != null}">
                                                            ${submission.score}/${assignment.maxScore}
                                                        </c:if>
                                                        <c:if test="${submission.score == null}">
                                                            Not graded
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="submission?action=detail&id=${submission.submissionId}" class="btn btn-sm btn-info">View</a>
                                                            <c:if test="${submission.status == 'SUBMITTED'}">
                                                                <a href="grade?action=form&id=${submission.submissionId}" class="btn btn-sm btn-primary">Grade</a>
                                                            </c:if>
                                                        </div>
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
