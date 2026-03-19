<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses</title>
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
                    <h1 class="h4">Available Courses</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <input type="text" class="form-control form-control-sm" placeholder="Search courses..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchCourses()">Search</button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <c:forEach items="${courses}" var="course">
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">${course.title}</h5>
                                    <p class="card-text">${course.description}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-primary fw-bold">$${course.price}</span>
                                        <small class="text-muted">${course.durationWeeks} weeks</small>
                                    </div>
                                    <div class="mt-3">
                                        <a href="course?action=detail&id=${course.courseId}" class="btn btn-primary w-100">View Details</a>
                                        <c:if test="${course.enrolled == false}">
                                            <a href="enrollment?action=enroll&courseId=${course.courseId}" class="btn btn-success w-100 mt-2">Enroll Now</a>
                                        </c:if>
                                        <c:if test="${course.enrolled == true}">
                                            <span class="badge bg-success">Enrolled</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        function searchCourses() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'course?action=list';
            } else {
                window.location.href = 'course?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchCourses();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
