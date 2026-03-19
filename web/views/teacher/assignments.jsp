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
                            <a class="nav-link" href="${pageContext.request.contextPath}/teacher/dashboard">
                                <i class="bi bi-house-fill"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/teacher/profile">
                                <i class="bi bi-person"></i> My Profile
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/teacher/classes">
                                <i class="bi bi-building"></i> My Classes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/teacher/assignments">
                                <i class="bi bi-file-earmark-text"></i> Assignments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/teacher/materials">
                                <i class="bi bi-folder"></i> Materials
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/teacher/students">
                                <i class="bi bi-people"></i> Students
                            </a>
                        </li>
                    </ul>
                    
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Quick Actions</span>
                    </h6>
                    <ul class="nav flex-column mb-2">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/teacher/create-class">
                                <i class="bi bi-plus-circle"></i> Create Class
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/teacher/create-assignment">
                                <i class="bi bi-plus-square"></i> Create Assignment
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
                            <a href="${pageContext.request.contextPath}/teacher/assignment?action=create" class="btn btn-sm btn-outline-secondary">Create Assignment</a>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Class</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Submissions</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${assignments}" var="assignment">
                                <tr>
                                    <td>${assignment.assignmentId}</td>
                                    <td>${assignment.title}</td>
                                    <td>${assignment.className}</td>
                                    <td>${assignment.dueDate}</td>
                                    <td>
                                        <span class="badge bg-${assignment.status == 'ACTIVE' ? 'success' : assignment.status == 'CLOSED' ? 'secondary' : 'warning'}">${assignment.status}</span>
                                    </td>
                                    <td>${assignment.submissionCount}/${assignment.studentCount}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="assignment?action=detail&id=${assignment.assignmentId}" class="btn btn-sm btn-info">View</a>
                                            <a href="assignment?action=edit&id=${assignment.assignmentId}" class="btn btn-sm btn-warning">Edit</a>
                                            <a href="submission?action=list&assignmentId=${assignment.assignmentId}" class="btn btn-sm btn-primary">Submissions</a>
                                            <a href="assignment?action=delete&id=${assignment.assignmentId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
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
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
