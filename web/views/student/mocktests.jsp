<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mock Tests</title>
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
                    <h1 class="h4">Mock Tests</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <input type="text" class="form-control form-control-sm" placeholder="Search tests..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchTests()">Search</button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <c:forEach items="${mocktests}" var="test">
                        <div class="col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">${test.title}</h5>
                                    <p class="card-text">${test.description}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <small class="text-muted">Duration: ${test.durationMinutes} minutes</small><br>
                                            <small class="text-muted">Questions: ${test.questionCount}</small>
                                        </div>
                                        <div>
                                            <c:if test="${test.completed == false}">
                                                <a href="mocktest?action=do-test&id=${test.testId}" class="btn btn-primary">Start Test</a>
                                            </c:if>
                                            <c:if test="${test.completed == true}">
                                                <span class="badge bg-success">Completed</span><br>
                                                <a href="testresult?action=list&testId=${test.testId}" class="btn btn-info mt-2">View Results</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        function searchTests() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'mocktest?action=list';
            } else {
                window.location.href = 'mocktest?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchTests();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
