<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enroll in Course - EduLingo</title>
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
                    <h1 class="h4">Enroll in Course</h1>
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

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Select Course to Enroll</h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/student/enroll">
                                    <div class="mb-3">
                                        <label for="courseSelect" class="form-label">Choose Course</label>
                                        <select class="form-select" id="courseSelect" name="courseId" required>
                                            <option value="">Select a course...</option>
                                            <c:forEach items="${availableCourses}" var="course">
                                                <option value="${course.courseId}">${course.title} - $${course.price} (${course.durationWeeks} weeks)</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="classSelect" class="form-label">Choose Class Schedule</label>
                                        <select class="form-select" id="classSelect" name="classId" required>
                                            <option value="">Select a class...</option>
                                        </select>
                                        <small class="form-text text-muted">Classes will appear after selecting a course</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="notes" class="form-label">Additional Notes (Optional)</label>
                                        <textarea class="form-control" id="notes" name="notes" rows="3" 
                                                  placeholder="Any special requirements or questions..."></textarea>
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                                        <button type="submit" class="btn btn-primary">Submit Enrollment</button>
                                        <a href="${pageContext.request.contextPath}/student/courses" class="btn btn-outline-secondary">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Enrollment Information</h5>
                            </div>
                            <div class="card-body">
                                <h6>How to Enroll:</h6>
                                <ol class="small">
                                    <li>Select a course from the dropdown</li>
                                    <li>Choose your preferred class schedule</li>
                                    <li>Add any additional notes if needed</li>
                                    <li>Submit your enrollment request</li>
                                    <li>Wait for admin approval</li>
                                </ol>
                                
                                <hr>
                                
                                <h6>Enrollment Status:</h6>
                                <ul class="small">
                                    <li><span class="badge bg-warning">Pending</span> - Waiting for approval</li>
                                    <li><span class="badge bg-success">Approved</span> - Enrollment confirmed</li>
                                    <li><span class="badge bg-danger">Rejected</span> - Enrollment denied</li>
                                </ul>
                                
                                <hr>
                                
                                <h6>Need Help?</h6>
                                <p class="small text-muted">
                                    Contact our support team for assistance with enrollment or course information.
                                </p>
                                <a href="#" class="btn btn-sm btn-outline-primary">Contact Support</a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Load classes when course is selected
        document.getElementById('courseSelect').addEventListener('change', function() {
            const courseId = this.value;
            const classSelect = document.getElementById('classSelect');
            
            // Clear existing options
            classSelect.innerHTML = '<option value="">Select a class...</option>';
            
            if (courseId) {
                // Load classes for selected course (this would typically be an AJAX call)
                // For now, we'll use a simple approach with available data
                loadClassesForCourse(courseId);
            }
        });
        
        function loadClassesForCourse(courseId) {
            // This would typically be an AJAX call to get classes for the selected course
            // For demonstration, we'll show some sample classes
            const sampleClasses = [
                {id: 1, name: 'Morning Class - Mon/Wed/Fri', schedule: '9:00 AM - 11:00 AM', enrolled: 15, max: 20},
                {id: 2, name: 'Evening Class - Tue/Thu', schedule: '6:00 PM - 8:00 PM', enrolled: 18, max: 20},
                {id: 3, name: 'Weekend Class - Sat/Sun', schedule: '10:00 AM - 12:00 PM', enrolled: 12, max: 20}
            ];
            
            const classSelect = document.getElementById('classSelect');
            
            sampleClasses.forEach(cls => {
                const option = document.createElement('option');
                option.value = cls.id;
                option.textContent = `${cls.name} - ${cls.schedule} (${cls.enrolled}/${cls.max} enrolled)`;
                
                if (cls.enrolled >= cls.max) {
                    option.disabled = true;
                    option.textContent += ' - FULL';
                }
                
                classSelect.appendChild(option);
            });
        }
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const courseId = document.getElementById('courseSelect').value;
            const classId = document.getElementById('classSelect').value;
            
            if (!courseId || !classId) {
                e.preventDefault();
                alert('Please select both a course and a class.');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>
