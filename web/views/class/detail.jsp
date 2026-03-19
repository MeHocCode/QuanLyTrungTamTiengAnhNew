<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Class Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                <%@ include file="../includes/admin-sidebar.jsp" %>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">Class Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="class?action=list" class="btn btn-sm btn-outline-secondary">Back to Classes</a>
                        </div>
                        <div class="btn-group">
                            <a href="class?action=edit&id=${class.classId}" class="btn btn-sm btn-warning">Edit Class</a>
                            <a href="assignment?action=create&classId=${class.classId}" class="btn btn-sm btn-primary">Create Assignment</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Class Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Class ID:</strong> #${class.classId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Class Name:</strong> ${class.className}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Course:</strong> ${class.courseTitle}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Teacher:</strong> ${class.teacherName}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Start Date:</strong> ${class.startDate}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>End Date:</strong> ${class.endDate}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Students:</strong> ${class.studentCount}/${class.maxStudents}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${class.status == 'ONGOING' ? 'success' : class.status == 'PLANNED' ? 'primary' : class.status == 'COMPLETED' ? 'info' : 'secondary'}">${class.status}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Class Statistics</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Total Assignments:</strong> ${class.totalAssignments}
                                </div>
                                <div class="mb-3">
                                    <strong>Pending Submissions:</strong> ${class.pendingSubmissions}
                                </div>
                                <div class="mb-3">
                                    <strong>Materials Uploaded:</strong> ${class.materialsCount}
                                </div>
                                <div class="mb-3">
                                    <strong>Created Date:</strong> ${class.createdAt}
                                </div>
                                
                                <div class="d-grid gap-2 mt-3">
                                    <a href="assignment?action=list&classId=${class.classId}" class="btn btn-primary w-100">View Assignments</a>
                                    <a href="material?action=list&classId=${class.classId}" class="btn btn-success w-100">View Materials</a>
                                    <a href="enrollment?action=list&classId=${class.classId}" class="btn btn-info w-100">View Enrollments</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Students List -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Enrolled Students</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Enrollment Date</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${students}" var="student">
                                                <tr>
                                                    <td>${student.studentId}</td>
                                                    <td>${student.name}</td>
                                                    <td>${student.email}</td>
                                                    <td>${student.phone}</td>
                                                    <td>${student.enrolledAt}</td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="student?action=detail&id=${student.studentId}" class="btn btn-sm btn-info">View</a>
                                                            <a href="submission?action=list&studentId=${student.studentId}&classId=${class.classId}" class="btn btn-sm btn-primary">Submissions</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
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
