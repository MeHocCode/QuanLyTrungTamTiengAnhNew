<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enrollment Management - EduLingo</title>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="bi bi-house-fill"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="bi bi-people"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/courses">
                                <i class="bi bi-book"></i> Courses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/classes">
                                <i class="bi bi-building"></i> Classes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/teachers">
                                <i class="bi bi-person-badge"></i> Teachers
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/students">
                                <i class="bi bi-mortarboard"></i> Students
                            </a>
                        </li>
                    </ul>
                    
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Management</span>
                    </h6>
                    <ul class="nav flex-column mb-2">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/assignments">
                                <i class="bi bi-file-earmark-text"></i> Assignments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/enrollments">
                                <i class="bi bi-person-check"></i> Enrollments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                                <i class="bi bi-graph-up"></i> Reports
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/settings">
                                <i class="bi bi-gear"></i> Settings
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
                    <h1 class="h4">Enrollment Management</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="${pageContext.request.contextPath}/admin/enrollment?action=create" class="btn btn-sm btn-outline-secondary">New Enrollment</a>
                        </div>
                        <div class="btn-group">
                            <input type="text" class="form-control form-control-sm" placeholder="Search enrollments..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchEnrollments()">Search</button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Student</th>
                                <th>Class</th>
                                <th>Course</th>
                                <th>Enrollment Date</th>
                                <th>Status</th>
                                <th>Payment Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <tr>
                                    <td>${enrollment.enrollmentId}</td>
                                    <td>${enrollment.studentName}</td>
                                    <td>${enrollment.className}</td>
                                    <td>${enrollment.courseTitle}</td>
                                    <td>${enrollment.enrolledAt}</td>
                                    <td>
                                        <span class="badge bg-${enrollment.status == 'ACTIVE' ? 'success' : 'warning'}">${enrollment.status}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${enrollment.paymentStatus == 'PAID' ? 'success' : 'danger'}">${enrollment.paymentStatus}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="enrollment?action=detail&id=${enrollment.enrollmentId}" class="btn btn-sm btn-info">View</a>
                                            <a href="enrollment?action=edit&id=${enrollment.enrollmentId}" class="btn btn-sm btn-warning">Edit</a>
                                            <c:if test="${enrollment.paymentStatus != 'PAID'}">
                                                <a href="enrollment?action=payment&id=${enrollment.enrollmentId}" class="btn btn-sm btn-success">Payment</a>
                                            </c:if>
                                            <a href="enrollment?action=delete&id=${enrollment.enrollmentId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <nav aria-label="Enrollment pagination">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="enrollment?action=list&page=${currentPage - 1}">Previous</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <li class="page-item ${currentPage == page ? 'active' : ''}">
                                <a class="page-link" href="enrollment?action=list&page=${page}">${page}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="enrollment?action=list&page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
                </nav>
            </main>
        </div>
    </div>
    
    <script>
        function searchEnrollments() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'enrollment?action=list';
            } else {
                window.location.href = 'enrollment?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchEnrollments();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
