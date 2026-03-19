<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Assignment</title>
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
                    <h1 class="h4">Submit Assignment</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="assignment?action=list" class="btn btn-sm btn-outline-secondary">Back to Assignments</a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Assignment Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Assignment:</strong> ${assignment.title}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Class:</strong> ${assignment.className}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Due Date:</strong> ${assignment.dueDate}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Max Score:</strong> ${assignment.maxScore}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Description:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${assignment.description}
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Instructions:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${assignment.instructions}
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <form method="post" action="submission?action=create" enctype="multipart/form-data" class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Your Submission</h5>
                            </div>
                            <div class="card-body">
                                <input type="hidden" name="assignmentId" value="${assignment.assignmentId}">
                                
                                <div class="mb-3">
                                    <label for="content" class="form-label">Content</label>
                                    <textarea class="form-control" id="content" name="content" rows="6" placeholder="Enter your submission content..." required></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="file" class="form-label">Attach File (Optional)</label>
                                    <input type="file" class="form-control" id="file" name="file">
                                    <small class="form-text text-muted">Supported formats: PDF, DOC, DOCX, PPT, PPTX, JPG, PNG</small>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Submit Assignment</button>
                                    <a href="assignment?action=detail&id=${assignment.assignmentId}" class="btn btn-secondary">Cancel</a>
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
