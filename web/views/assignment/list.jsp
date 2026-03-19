<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments</title>
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
                    <h1 class="h4">Assignments</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="assignment?action=create" class="btn btn-sm btn-outline-secondary">Create Assignment</a>
                        </div>
                        <div class="btn-group">
                            <input type="text" class="form-control form-control-sm" placeholder="Search assignments..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchAssignments()">Search</button>
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
                                <th>Teacher</th>
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
                                    <td>${assignment.teacherName}</td>
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
