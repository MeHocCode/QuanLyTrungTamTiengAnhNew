<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Teacher - Admin Dashboard</title>
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
                    <h1 class="h4">Assign Teacher to Class</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="class?action=list" class="btn btn-sm btn-outline-secondary">Back to Classes</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <form method="post" action="class?action=assign-teacher" class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Select Class and Teacher</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="classId" class="form-label">Class</label>
                                    <select class="form-select" id="classId" name="classId" required>
                                        <option value="">Select a class</option>
                                        <c:forEach items="${classes}" var="class">
                                            <option value="${class.classId}">${class.className} - ${class.courseTitle}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="teacherId" class="form-label">Teacher</label>
                                    <select class="form-select" id="teacherId" name="teacherId" required>
                                        <option value="">Select a teacher</option>
                                        <c:forEach items="${teachers}" var="teacher">
                                            <option value="${teacher.teacherId}">${teacher.name} - ${teacher.email}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="assignedDate" class="form-label">Assignment Date</label>
                                    <input type="date" class="form-control" id="assignedDate" name="assignedDate" required>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Assign Teacher</button>
                                    <a href="class?action=list" class="btn btn-secondary">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Recent Assignments</h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group">
                                    <c:forEach items="${recentAssignments}" var="assignment">
                                        <div class="list-group-item">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h6 class="mb-1">${assignment.className}</h6>
                                                <small>${assignment.teacherName} - ${assignment.assignedDate}</small>
                                            </div>
                                        </div>
                                    </c:forEach>
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
