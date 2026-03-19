<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Details - EduLingo</title>
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
                    <h1 class="h4">Course Details</h1>
                    <a href="${pageContext.request.contextPath}/student/courses" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left"></i> Back to Courses
                    </a>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty course}">
                        <div class="text-center py-5">
                            <i class="bi bi-exclamation-triangle display-1 text-warning"></i>
                            <h4 class="mt-3 text-warning">Course not found</h4>
                            <p class="text-muted">The course you're looking for doesn't exist or has been removed.</p>
                            <a href="${pageContext.request.contextPath}/student/courses" class="btn btn-primary">Browse Courses</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Course Information -->
                        <div class="row mb-4">
                            <div class="col-md-8">
                                <div class="card">
                                    <div class="card-body">
                                        <h2 class="card-title">${empty course.title ? 'Untitled Course' : course.title}</h2>
                                        <p class="card-text">${empty course.description ? 'No description available' : course.description}</p>
                                        
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <strong>Level:</strong> 
                                                <span class="badge bg-primary">${empty course.level ? 'Beginner' : course.level}</span>
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Duration:</strong> 
                                                <span class="badge bg-success">${empty course.durationWeeks ? '0 weeks' : course.durationWeeks + ' weeks'}</span>
                                            </div>
                                        </div>
                                        
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <strong>Teacher:</strong> ${empty course.teacherName ? 'Not assigned' : course.teacherName}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Price:</strong> 
                                                <span class="text-primary fw-bold">$${empty course.price ? '0' : course.price}</span>
                                            </div>
                                        </div>
                                        
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <strong>Schedule:</strong> ${empty course.schedule ? 'Flexible' : course.schedule}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Category:</strong> ${empty course.category ? 'General' : course.category}
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <strong>Course Content:</strong>
                                            <p class="mt-2">${empty course.content ? 'Course content will be available soon.' : course.content}</p>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <strong>Learning Objectives:</strong>
                                            <ul class="mt-2">
                                                <c:choose>
                                                    <c:when test="${empty course.objectives}">
                                                        <li>Basic language skills</li>
                                                        <li>Communication practice</li>
                                                        <li>Cultural understanding</li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${course.objectives}" var="objective">
                                                            <li>${objective}</li>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Course Summary</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between">
                                                <span>Available Slots:</span>
                                                <strong>${empty course.availableSlots ? '0' : course.availableSlots}</strong>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between">
                                                <span>Total Slots:</span>
                                                <strong>${empty course.maxStudents ? '0' : course.maxStudents}</strong>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between">
                                                <span>Start Date:</span>
                                                <strong>${empty course.startDate ? 'TBD' : course.startDate}</strong>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between">
                                                <span>End Date:</span>
                                                <strong>${empty course.endDate ? 'TBD' : course.endDate}</strong>
                                            </div>
                                        </div>
                                        
                                        <hr>
                                        
                                        <div class="d-grid gap-2">
                                            <a href="${pageContext.request.contextPath}/student/enroll?courseId=${empty course.courseId ? '0' : course.courseId}" 
                                               class="btn btn-success">Enroll in Course</a>
                                            <a href="${pageContext.request.contextPath}/student/courses" class="btn btn-outline-secondary">Browse More Courses</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Available Classes for this Course -->
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Available Classes</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty classes}">
                                        <div class="text-center py-4">
                                            <i class="bi bi-calendar-x display-4 text-muted"></i>
                                            <h5 class="mt-3 text-muted">No classes available</h5>
                                            <p class="text-muted">Classes for this course will be available soon.</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Class Name</th>
                                                        <th>Teacher</th>
                                                        <th>Schedule</th>
                                                        <th>Students</th>
                                                        <th>Start Date</th>
                                                        <th>Status</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${classes}" var="cls">
                                                        <tr>
                                                            <td>${empty cls.className ? 'Unnamed Class' : cls.className}</td>
                                                            <td>${empty cls.teacherName ? 'Not assigned' : cls.teacherName}</td>
                                                            <td>${empty cls.schedule ? 'Flexible' : cls.schedule}</td>
                                                            <td>
                                                                <span class="badge bg-info">${empty cls.enrolledStudents ? '0' : cls.enrolledStudents}/${empty cls.maxStudents ? '0' : cls.maxStudents}</span>
                                                            </td>
                                                            <td>${empty cls.startDate ? 'TBD' : cls.startDate}</td>
                                                            <td>
                                                                <span class="badge bg-${cls.status == 'ONGOING' ? 'success' : cls.status == 'PLANNED' ? 'primary' : cls.status == 'COMPLETED' ? 'secondary' : 'warning'}">
                                                                    ${empty cls.status ? 'UNKNOWN' : cls.status}
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${cls.enrolled == true}">
                                                                        <span class="badge bg-success">Enrolled</span>
                                                                    </c:when>
                                                                    <c:when test="${cls.enrolledStudents >= cls.maxStudents}">
                                                                        <span class="badge bg-danger">Full</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="${pageContext.request.contextPath}/student/enroll-class?classId=${empty cls.classId ? '0' : cls.classId}" 
                                                                           class="btn btn-primary btn-sm">Enroll</a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
