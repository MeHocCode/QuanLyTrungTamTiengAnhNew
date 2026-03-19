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
                <%@ include file="../includes/student-sidebar.jsp" %>
            </nav>
            
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h4">My Classes</h1>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Class</th>
                                <th>Course</th>
                                <th>Teacher</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${classes}" var="class">
                                <tr>
                                    <td>${class.className}</td>
                                    <td>${class.courseTitle}</td>
                                    <td>${class.teacherName}</td>
                                    <td>${class.startDate}</td>
                                    <td>${class.endDate}</td>
                                    <td>
                                        <span class="badge bg-${class.status == 'ONGOING' ? 'success' : class.status == 'COMPLETED' ? 'info' : 'secondary'}">${class.status}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="class?action=detail&id=${class.classId}" class="btn btn-sm btn-info">View</a>
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
