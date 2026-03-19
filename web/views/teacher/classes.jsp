<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Classes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                <%@ include file="../includes/teacher-sidebar.jsp" %>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">My Classes</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="class?action=create" class="btn btn-sm btn-outline-secondary">Add Class</a>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Class Name</th>
                                <th>Course</th>
                                <th>Students</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${classes}" var="class">
                                <tr>
                                    <td>${class.classId}</td>
                                    <td>${class.className}</td>
                                    <td>${class.courseTitle}</td>
                                    <td>${class.studentCount}/${class.maxStudents}</td>
                                    <td>${class.startDate}</td>
                                    <td>${class.endDate}</td>
                                    <td>
                                        <span class="badge bg-${class.status == 'ONGOING' ? 'success' : class.status == 'PLANNED' ? 'primary' : class.status == 'COMPLETED' ? 'info' : 'secondary'}">${class.status}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="class?action=detail&id=${class.classId}" class="btn btn-sm btn-info">View</a>
                                            <a href="class?action=edit&id=${class.classId}" class="btn btn-sm btn-warning">Edit</a>
                                            <a href="assignment?action=list&classId=${class.classId}" class="btn btn-sm btn-primary">Assignments</a>
                                            <a href="material?action=list&classId=${class.classId}" class="btn btn-sm btn-success">Materials</a>
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
