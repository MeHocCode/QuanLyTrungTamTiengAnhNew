<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enrollment Management - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/admin-dashboard.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                <%@ include file="../includes/admin-sidebar.jsp" %>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">Enrollment Management</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="enrollment?action=create" class="btn btn-sm btn-outline-secondary">New Enrollment</a>
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
