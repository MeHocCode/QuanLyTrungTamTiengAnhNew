<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Details</title>
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
                    <h1 class="h4">Course Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="course?action=list" class="btn btn-sm btn-outline-secondary">Back to Courses</a>
                        </div>
                        <div class="btn-group">
                            <a href="course?action=edit&id=${course.courseId}" class="btn btn-sm btn-warning">Edit Course</a>
                            <a href="class?action=create&courseId=${course.courseId}" class="btn btn-sm btn-primary">Create Class</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Course Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Course ID:</strong> #${course.courseId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Title:</strong> ${course.title}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Price:</strong> $${course.price}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Duration:</strong> ${course.durationWeeks} weeks
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Level:</strong> ${course.level}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${course.status == 'ACTIVE' ? 'success' : 'secondary'}">${course.status}</span>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Description:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${course.description}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Prerequisites:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${course.prerequisites}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Course Statistics</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Total Classes:</strong> ${course.totalClasses}
                                </div>
                                <div class="mb-3">
                                    <strong>Active Classes:</strong> ${course.activeClasses}
                                </div>
                                <div class="mb-3">
                                    <strong>Total Students:</strong> ${course.totalStudents}
                                </div>
                                <div class="mb-3">
                                    <strong>Created Date:</strong> ${course.createdAt}
                                </div>
                                
                                <div class="d-grid gap-2 mt-3">
                                    <a href="class?action=list&courseId=${course.courseId}" class="btn btn-primary w-100">View Classes</a>
                                    <a href="enrollment?action=list&courseId=${course.courseId}" class="btn btn-info w-100">View Enrollments</a>
                                    <a href="course?action=edit&id=${course.courseId}" class="btn btn-warning w-100">Edit Course</a>
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
