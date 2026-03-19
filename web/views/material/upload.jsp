<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Material</title>
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
                    <h1 class="h4">Upload Material</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="material?action=list" class="btn btn-sm btn-outline-secondary">Back to Materials</a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <form method="post" action="material?action=upload" enctype="multipart/form-data" class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">New Material</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="title" class="form-label">Material Title</label>
                                        <input type="text" class="form-control" id="title" name="title" required placeholder="Enter material title...">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="type" class="form-label">Material Type</label>
                                        <select class="form-select" id="type" name="type" required>
                                            <option value="">Select type</option>
                                            <option value="DOCUMENT">Document</option>
                                            <option value="VIDEO">Video</option>
                                            <option value="IMAGE">Image</option>
                                            <option value="AUDIO">Audio</option>
                                            <option value="LINK">Link</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="classId" class="form-label">Class</label>
                                        <select class="form-select" id="classId" name="classId" required>
                                            <option value="">Select a class</option>
                                            <c:forEach items="${classes}" var="class">
                                                <option value="${class.classId}">${class.className} - ${class.courseTitle}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="file" class="form-label">File</label>
                                        <input type="file" class="form-control" id="file" name="file" required>
                                        <small class="form-text text-muted">Select file to upload</small>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" placeholder="Enter material description..."></textarea>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Upload Material</button>
                                    <a href="material?action=list" class="btn btn-secondary">Cancel</a>
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
