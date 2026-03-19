<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Enrollments</title>
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
                    <h1 class="h4">My Enrollments</h1>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Course</th>
                                <th>Class</th>
                                <th>Enrollment Date</th>
                                <th>Status</th>
                                <th>Payment Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${enrollments}" var="enrollment">
                                <tr>
                                    <td>${enrollment.courseTitle}</td>
                                    <td>${enrollment.className}</td>
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
                                            <c:if test="${enrollment.paymentStatus != 'PAID'}">
                                                <a href="payment?action=form&enrollmentId=${enrollment.enrollmentId}" class="btn btn-sm btn-success">Make Payment</a>
                                            </c:if>
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
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
