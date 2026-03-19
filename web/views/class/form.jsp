<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Class</title>
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
                    <h1 class="h4">Create Class</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="class?action=list" class="btn btn-sm btn-outline-secondary">Back to Classes</a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <form method="post" action="class?action=create" class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">New Class</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="className" class="form-label">Class Name</label>
                                        <input type="text" class="form-control" id="className" name="className" required placeholder="Enter class name...">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="courseId" class="form-label">Course</label>
                                        <select class="form-select" id="courseId" name="courseId" required>
                                            <option value="">Select a course</option>
                                            <c:forEach items="${courses}" var="course">
                                                <option value="${course.courseId}">${course.title}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="teacherId" class="form-label">Teacher</label>
                                        <select class="form-select" id="teacherId" name="teacherId" required>
                                            <option value="">Select a teacher</option>
                                            <c:forEach items="${teachers}" var="teacher">
                                                <option value="${teacher.teacherId}">${teacher.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="maxStudents" class="form-label">Maximum Students</label>
                                        <input type="number" class="form-control" id="maxStudents" name="maxStudents" min="1" required placeholder="Enter maximum students...">
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="startDate" class="form-label">Start Date</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="endDate" class="form-label">End Date</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="schedule" class="form-label">Schedule</label>
                                        <input type="text" class="form-control" id="schedule" name="schedule" placeholder="e.g., Mon-Wed-Fri 9:00-11:00">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="room" class="form-label">Room</label>
                                        <input type="text" class="form-control" id="room" name="room" placeholder="Enter room number...">
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter class description..."></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="PLANNED">Planned</option>
                                        <option value="ONGOING">Ongoing</option>
                                        <option value="COMPLETED">Completed</option>
                                        <option value="CANCELLED">Cancelled</option>
                                    </select>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Create Class</button>
                                    <a href="class?action=list" class="btn btn-secondary">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
