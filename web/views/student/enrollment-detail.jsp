<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enrollment Details</title>
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
                    <h1 class="h4">Enrollment Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="enrollment?action=list" class="btn btn-sm btn-outline-secondary">Back to Enrollments</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Enrollment Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Enrollment ID:</strong> #${enrollment.enrollmentId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${enrollment.status == 'ACTIVE' ? 'success' : 'warning'}">${enrollment.status}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Course:</strong> ${enrollment.courseTitle}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Class:</strong> ${enrollment.className}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Enrollment Date:</strong> ${enrollment.enrolledAt}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Payment Status:</strong> 
                                        <span class="badge bg-${enrollment.paymentStatus == 'PAID' ? 'success' : 'danger'}">${enrollment.paymentStatus}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Teacher:</strong> ${enrollment.teacherName}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Price:</strong> $${enrollment.price}
                                    </div>
                                </div>
                                
                                <c:if test="${enrollment.paymentStatus != 'PAID'}">
                                    <div class="alert alert-warning mt-3">
                                        <strong>Payment Required:</strong> Please complete your payment to continue accessing this course.
                                        <div class="mt-2">
                                            <a href="payment?action=form&enrollmentId=${enrollment.enrollmentId}" class="btn btn-success">Make Payment</a>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <c:if test="${enrollment.paymentStatus == 'PAID'}">
                                    <div class="alert alert-success mt-3">
                                        <strong>Payment Completed:</strong> Your enrollment is fully paid and active.
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="class?action=detail&id=${enrollment.classId}" class="btn btn-info w-100">View Class</a>
                                    <a href="assignment?action=list&classId=${enrollment.classId}" class="btn btn-primary w-100">View Assignments</a>
                                    <a href="material?action=list&classId=${enrollment.classId}" class="btn btn-success w-100">View Materials</a>
                                    <c:if test="${enrollment.paymentStatus != 'PAID'}">
                                        <a href="payment?action=form&enrollmentId=${enrollment.enrollmentId}" class="btn btn-warning w-100">Make Payment</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
