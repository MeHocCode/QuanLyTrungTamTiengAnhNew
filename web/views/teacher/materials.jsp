<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Materials</title>
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
                    <h1 class="h4">Materials</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="material?action=upload" class="btn btn-sm btn-outline-secondary">Upload Material</a>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Type</th>
                                <th>Class</th>
                                <th>Upload Date</th>
                                <th>File Size</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${materials}" var="material">
                                <tr>
                                    <td>${material.materialId}</td>
                                    <td>${material.title}</td>
                                    <td>
                                        <span class="badge bg-${material.type == 'DOCUMENT' ? 'info' : material.type == 'VIDEO' ? 'success' : material.type == 'AUDIO' ? 'warning' : 'primary'}">${material.type}</span>
                                    </td>
                                    <td>${material.className}</td>
                                    <td>${material.uploadDate}</td>
                                    <td>${material.fileSize}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="material?action=download&id=${material.materialId}" class="btn btn-sm btn-primary">Download</a>
                                            <a href="material?action=edit&id=${material.materialId}" class="btn btn-sm btn-warning">Edit</a>
                                            <a href="material?action=delete&id=${material.materialId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
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
