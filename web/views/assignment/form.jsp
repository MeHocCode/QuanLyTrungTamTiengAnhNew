<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Assignment</title>
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
                    <h1 class="h4">Create Assignment</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="assignment?action=list" class="btn btn-sm btn-outline-secondary">Back to Assignments</a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <form method="post" action="assignment?action=create" class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">New Assignment</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="title" class="form-label">Assignment Title</label>
                                        <input type="text" class="form-control" id="title" name="title" required placeholder="Enter assignment title...">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="classId" class="form-label">Class</label>
                                        <select class="form-select" id="classId" name="classId" required>
                                            <option value="">Select a class</option>
                                            <c:forEach items="${classes}" var="class">
                                                <option value="${class.classId}">${class.className} - ${class.courseTitle}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="dueDate" class="form-label">Due Date</label>
                                        <input type="datetime-local" class="form-control" id="dueDate" name="dueDate" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="maxScore" class="form-label">Maximum Score</label>
                                        <input type="number" class="form-control" id="maxScore" name="maxScore" min="1" required placeholder="Enter maximum score...">
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" required placeholder="Enter assignment description..."></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="instructions" class="form-label">Instructions</label>
                                    <textarea class="form-control" id="instructions" name="instructions" rows="4" placeholder="Enter assignment instructions..."></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="ACTIVE">Active</option>
                                        <option value="DRAFT">Draft</option>
                                        <option value="CLOSED">Closed</option>
                                    </select>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Create Assignment</button>
                                    <a href="assignment?action=list" class="btn btn-secondary">Cancel</a>
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
