<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management - Admin Dashboard</title>
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
                    <h1 class="h4">Payment Management</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="payment?action=create" class="btn btn-sm btn-outline-secondary">Record Payment</a>
                        </div>
                        <div class="btn-group">
                            <input type="text" class="form-control form-control-sm" placeholder="Search payments..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchPayments()">Search</button>
                        </div>
                    </div>
                </div>

                <!-- Payment Statistics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <h5 class="card-title">Total Revenue</h5>
                                <h2>${totalRevenue}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <h5 class="card-title">This Month</h5>
                                <h2>${monthlyRevenue}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <h5 class="card-title">Pending</h5>
                                <h2>${pendingPayments}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <h5 class="card-title">Overdue</h5>
                                <h2>${overduePayments}</h2>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Student</th>
                                <th>Course</th>
                                <th>Amount</th>
                                <th>Method</th>
                                <th>Status</th>
                                <th>Payment Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${payments}" var="payment">
                                <tr>
                                    <td>${payment.payId}</td>
                                    <td>${payment.studentName}</td>
                                    <td>${payment.courseTitle}</td>
                                    <td>$${payment.amount}</td>
                                    <td>${payment.method}</td>
                                    <td>
                                        <span class="badge bg-${payment.status == 'PAID' ? 'success' : payment.status == 'PENDING' ? 'warning' : 'danger'}">${payment.status}</span>
                                    </td>
                                    <td>${payment.paidAt}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="payment?action=detail&id=${payment.payId}" class="btn btn-sm btn-info">View</a>
                                            <c:if test="${payment.status == 'PENDING'}">
                                                <a href="payment?action=approve&id=${payment.payId}" class="btn btn-sm btn-success">Approve</a>
                                                <a href="payment?action=reject&id=${payment.payId}" class="btn btn-sm btn-danger">Reject</a>
                                            </c:if>
                                            <a href="payment?action=delete&id=${payment.payId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <nav aria-label="Payment pagination">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="payment?action=list&page=${currentPage - 1}">Previous</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <li class="page-item ${currentPage == page ? 'active' : ''}">
                                <a class="page-link" href="payment?action=list&page=${page}">${page}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="payment?action=list&page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
                </nav>
            </main>
        </div>
    </div>
    
    <script>
        function searchPayments() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'payment?action=list';
            } else {
                window.location.href = 'payment?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchPayments();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
