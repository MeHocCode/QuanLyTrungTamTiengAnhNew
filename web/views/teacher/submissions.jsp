<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submissions</title>
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
                    <h1 class="h4">Submissions</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <input type="text" class="form-control form-control-sm" placeholder="Search submissions..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchSubmissions()">Search</button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Student</th>
                                <th>Assignment</th>
                                <th>Submit Date</th>
                                <th>Status</th>
                                <th>Score</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${submissions}" var="submission">
                                <tr>
                                    <td>${submission.submissionId}</td>
                                    <td>${submission.studentName}</td>
                                    <td>${submission.assignmentTitle}</td>
                                    <td>${submission.submitDate}</td>
                                    <td>
                                        <span class="badge bg-${submission.status == 'SUBMITTED' ? 'info' : submission.status == 'GRADED' ? 'success' : 'warning'}">${submission.status}</span>
                                    </td>
                                    <td>
                                        <c:if test="${submission.score != null}">
                                            ${submission.score}/${submission.maxScore}
                                        </c:if>
                                        <c:if test="${submission.score == null}">
                                            Not graded
                                        </c:if>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="submission?action=detail&id=${submission.submissionId}" class="btn btn-sm btn-info">View</a>
                                            <c:if test="${submission.status == 'SUBMITTED'}">
                                                <a href="submission?action=grade&id=${submission.submissionId}" class="btn btn-sm btn-primary">Grade</a>
                                            </c:if>
                                            <a href="submission?action=download&id=${submission.submissionId}" class="btn btn-sm btn-success">Download</a>
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
        function searchSubmissions() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'submission?action=list';
            } else {
                window.location.href = 'submission?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchSubmissions();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
