<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lead Management - Admin Dashboard</title>
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
                    <h1 class="h4">Lead Management</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="lead?action=create" class="btn btn-sm btn-outline-secondary">Add Lead</a>
                        </div>
                        <div class="btn-group">
                            <input type="text" class="form-control form-control-sm" placeholder="Search leads..." id="searchInput">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="searchLeads()">Search</button>
                        </div>
                    </div>
                </div>

                <!-- Lead Statistics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <h5 class="card-title">Total Leads</h5>
                                <h2>${totalLeads}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <h5 class="card-title">New This Month</h5>
                                <h2>${newLeads}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <h5 class="card-title">Qualified</h5>
                                <h2>${qualifiedLeads}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <h5 class="card-title">Converted</h5>
                                <h2>${convertedLeads}</h2>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Created Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${leads}" var="lead">
                                <tr>
                                    <td>${lead.id}</td>
                                    <td>${lead.name}</td>
                                    <td>${lead.email}</td>
                                    <td>${lead.phone}</td>
                                    <td>
                                        <span class="badge bg-${lead.status == 'NEW' ? 'primary' : lead.status == 'CONTACTED' ? 'info' : lead.status == 'QUALIFIED' ? 'success' : lead.status == 'CONVERTED' ? 'warning' : 'secondary'}">${lead.status}</span>
                                    </td>
                                    <td>${lead.createdAt}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="lead?action=detail&id=${lead.id}" class="btn btn-sm btn-info">View</a>
                                            <a href="lead?action=edit&id=${lead.id}" class="btn btn-sm btn-warning">Edit</a>
                                            <c:if test="${lead.status == 'NEW' || lead.status == 'CONTACTED'}">
                                                <a href="lead?action=contact&id=${lead.id}" class="btn btn-sm btn-success">Contact</a>
                                            </c:if>
                                            <c:if test="${lead.status == 'QUALIFIED'}">
                                                <a href="lead?action=convert&id=${lead.id}" class="btn btn-sm btn-primary">Convert</a>
                                            </c:if>
                                            <a href="lead?action=delete&id=${lead.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <nav aria-label="Lead pagination">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="lead?action=list&page=${currentPage - 1}">Previous</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <li class="page-item ${currentPage == page ? 'active' : ''}">
                                <a class="page-link" href="lead?action=list&page=${page}">${page}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="lead?action=list&page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
                </nav>
            </main>
        </div>
    </div>
    
    <script>
        function searchLeads() {
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm.trim() === '') {
                window.location.href = 'lead?action=list';
            } else {
                window.location.href = 'lead?action=list&search=' + encodeURIComponent(searchTerm);
            }
        }
        
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchLeads();
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
