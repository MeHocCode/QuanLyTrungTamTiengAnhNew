<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments - EduLingo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/student/dashboard">
                                <i class="bi bi-house-fill"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/student/courses">
                                <i class="bi bi-book"></i> My Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/student/assignments">
                                <i class="bi bi-file-earmark-text"></i> Assignments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/student/classes">
                                <i class="bi bi-people"></i> My Classes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/student/grades">
                                <i class="bi bi-graph-up"></i> Grades
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/student/profile">
                                <i class="bi bi-person"></i> Profile
                            </a>
                        </li>
                    </ul>
                    
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Quick Actions</span>
                    </h6>
                    <ul class="nav flex-column mb-2">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/student/enroll">
                                <i class="bi bi-plus-circle"></i> Enroll Course
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/Logout">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">Assignments</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <input type="text" class="form-control form-control-sm" placeholder="Search assignments..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchAssignments()">Search</button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Class</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Submitted</th>
                                <th>Score</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${assignments}" var="assignment">
                                <tr>
                                    <td>${assignment.title}</td>
                                    <td>${assignment.className}</td>
                                    <td>${assignment.dueDate}</td>
                                    <td>
                                        <span class="badge bg-${assignment.status == 'ACTIVE' ? 'success' : assignment.status == 'CLOSED' ? 'secondary' : 'warning'}">${assignment.status}</span>
                                    </td>
                                    <td>
                                        <c:if test="${assignment.submitted == true}">
                                            <span class="badge bg-info">Submitted</span>
                                        </c:if>
                                        <c:if test="${assignment.submitted == false}">
                                            <span class="badge bg-warning">Not Submitted</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${assignment.score != null}">
                                            ${assignment.score}/${assignment.maxScore}
                                        </c:if>
                                        <c:if test="${assignment.score == null}">
                                            Not graded
                                        </c:if>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="assignment?action=detail&id=${assignment.assignmentId}" class="btn btn-sm btn-info">View</a>
                                            <c:if test="${assignment.submitted == false}">
                                                <a href="submission?action=create&assignmentId=${assignment.assignmentId}" class="btn btn-sm btn-primary">Submit</a>
                                            </c:if>
                                            <c:if test="${assignment.submitted == true}">
                                                <a href="submission?action=detail&assignmentId=${assignment.assignmentId}" class="btn btn-sm btn-success">View Submission</a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        function searchAssignments() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'assignment?action=list';
            } else {
                window.location.href = 'assignment?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchAssignments();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
