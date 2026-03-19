<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Grades</title>
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
                    <h1 class="h4">My Grades</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <select class="form-select form-select-sm" id="filterSelect" onchange="filterGrades()">
                                <option value="">All Grades</option>
                                <option value="recent">Recent</option>
                                <option value="high">High Scores</option>
                                <option value="low">Low Scores</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Grade Statistics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <h5 class="card-title">Average Score</h5>
                                <h2>${averageScore}%</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <h5 class="card-title">Highest Score</h5>
                                <h2>${highestScore}%</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <h5 class="card-title">Total Assignments</h5>
                                <h2>${totalAssignments}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <h5 class="card-title">Pending</h5>
                                <h2>${pendingAssignments}</h2>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Assignment</th>
                                <th>Class</th>
                                <th>Submit Date</th>
                                <th>Score</th>
                                <th>Grade</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${grades}" var="grade">
                                <tr>
                                    <td>${grade.assignmentTitle}</td>
                                    <td>${grade.className}</td>
                                    <td>${grade.submitDate}</td>
                                    <td>
                                        <span class="badge bg-${grade.scorePercentage >= 80 ? 'success' : grade.scorePercentage >= 60 ? 'warning' : 'danger'}">${grade.score}/${grade.maxScore}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${grade.letterGrade == 'A' ? 'success' : grade.letterGrade == 'B' ? 'info' : grade.letterGrade == 'C' ? 'warning' : 'danger'}">${grade.letterGrade}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="grade?action=detail&id=${grade.gradeId}" class="btn btn-sm btn-info">View Details</a>
                                            <a href="submission?action=detail&id=${grade.submissionId}" class="btn btn-sm btn-primary">View Submission</a>
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
        function filterGrades() {
            const filter = document.getElementById('filterSelect').value;
            if (filter === '') {
                window.location.href = 'grade?action=list';
            } else {
                window.location.href = 'grade?action=list&filter=' + encodeURIComponent(filter);
            }
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
