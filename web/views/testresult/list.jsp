<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Results</title>
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
                    <h1 class="h4">Test Results</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group">
                            <input type="text" class="form-control form-control-sm" placeholder="Search results..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchResults()">Search</button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Student</th>
                                <th>Mock Test</th>
                                <th>Score</th>
                                <th>Grade</th>
                                <th>Test Date</th>
                                <th>Time Taken</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${results}" var="result">
                                <tr>
                                    <td>${result.resultId}</td>
                                    <td>${result.studentName}</td>
                                    <td>${result.testTitle}</td>
                                    <td>${result.score}%</td>
                                    <td>
                                        <span class="badge bg-${result.letterGrade == 'A' ? 'success' : result.letterGrade == 'B' ? 'info' : result.letterGrade == 'C' ? 'warning' : 'danger'}">${result.letterGrade}</span>
                                    </td>
                                    <td>${result.testDate}</td>
                                    <td>${result.timeTaken}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="testresult?action=detail&id=${result.resultId}" class="btn btn-sm btn-info">View</a>
                                            <a href="testresult?action=download&id=${result.resultId}" class="btn btn-sm btn-success">Download</a>
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
        function searchResults() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'testresult?action=list';
            } else {
                window.location.href = 'testresult?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchResults();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
