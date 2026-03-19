<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Courses - EduLingo</title>
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/student/courses">
                                <i class="bi bi-book"></i> My Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/student/assignments">
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
                    <h1 class="h4">Available Courses</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <input type="text" class="form-control form-control-sm" placeholder="Search courses..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchCourses()">Search</button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <c:choose>
                        <c:when test="${empty courses}">
                            <div class="col-12">
                                <div class="text-center py-5">
                                    <i class="bi bi-book display-1 text-muted"></i>
                                    <h4 class="mt-3 text-muted">No courses available</h4>
                                    <p class="text-muted">Check back later for new courses.</p>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${courses}" var="course">
                                <div class="col-md-4 mb-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title">${empty course.title ? 'Untitled Course' : course.title}</h5>
                                            <p class="card-text">${empty course.description ? 'No description available' : course.description}</p>
                                            
                                            <div class="mb-2">
                                                <span class="badge bg-primary">${empty course.level ? 'Beginner' : course.level}</span>
                                                <span class="badge bg-success">${empty course.durationWeeks ? '0 weeks' : course.durationWeeks + ' weeks'}</span>
                                            </div>
                                            
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="text-primary fw-bold">$${empty course.price ? '0' : course.price}</span>
                                                <small class="text-muted">${empty course.durationWeeks ? '0' : course.durationWeeks} weeks</small>
                                            </div>
                                        </div>
                                        <div class="card-footer bg-transparent">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <small class="text-muted">${empty course.availableSlots ? '0' : course.availableSlots} slots available</small>
                                                <div>
                                                    <a href="${pageContext.request.contextPath}/student/course-detail?id=${empty course.courseId ? '0' : course.courseId}" 
                                                       class="btn btn-primary btn-sm">View Details</a>
                                                    <c:if test="${empty course.enrolled or course.enrolled == false}">
                                                        <a href="${pageContext.request.contextPath}/student/enroll?courseId=${empty course.courseId ? '0' : course.courseId}" 
                                                           class="btn btn-success btn-sm ms-1">Enroll</a>
                                                    </c:if>
                                                    <c:if test="${course.enrolled == true}">
                                                        <span class="badge bg-success ms-1">Enrolled</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        function searchCourses() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = '${pageContext.request.contextPath}/student/courses';
            } else {
                window.location.href = '${pageContext.request.contextPath}/student/courses?search=' + encodeURIComponent(searchTerm);
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
