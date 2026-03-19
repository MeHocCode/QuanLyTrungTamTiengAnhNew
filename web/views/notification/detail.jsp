<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification Details</title>
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
                    <h1 class="h4">Notification Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="notification?action=list" class="btn btn-sm btn-outline-secondary">Back to Notifications</a>
                        </div>
                        <div class="btn-group">
                            <a href="notification?action=edit&id=${notification.notificationId}" class="btn btn-sm btn-warning">Edit Notification</a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Notification Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Notification ID:</strong> #${notification.notificationId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Type:</strong> 
                                        <span class="badge bg-${notification.type == 'INFO' ? 'info' : notification.type == 'WARNING' ? 'warning' : notification.type == 'SUCCESS' ? 'success' : 'danger'}">${notification.type}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>From:</strong> ${notification.fromUser}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>To:</strong> ${notification.toUser}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Created Date:</strong> ${notification.createdAt}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${notification.readFlag == 'READ' ? 'secondary' : 'primary'}">${notification.readFlag}</span>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Message:</strong>
                                    <div class="mt-2 p-3 bg-light rounded">
                                        ${notification.message}
                                    </div>
                                </div>
                                
                                <c:if test="${notification.readAt != null}">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <strong>Read At:</strong> ${notification.readAt}
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="notification?action=edit&id=${notification.notificationId}" class="btn btn-warning w-100">Edit Notification</a>
                                    <c:if test="${notification.readFlag == 'UNREAD'}">
                                        <a href="notification?action=mark-read&id=${notification.notificationId}" class="btn btn-success w-100">Mark as Read</a>
                                    </c:if>
                                    <a href="notification?action=send&id=${notification.notificationId}" class="btn btn-primary w-100">Send Again</a>
                                    <a href="notification?action=delete&id=${notification.notificationId}" class="btn btn-danger w-100" onclick="return confirm('Are you sure?')">Delete</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recipients List -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Delivery Status</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>Recipient</th>
                                                <th>Email</th>
                                                <th>Status</th>
                                                <th>Delivered At</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recipients}" var="recipient">
                                                <tr>
                                                    <td>${recipient.name}</td>
                                                    <td>${recipient.email}</td>
                                                    <td>
                                                        <span class="badge bg-${recipient.status == 'DELIVERED' ? 'success' : recipient.status == 'FAILED' ? 'danger' : 'warning'}">${recipient.status}</span>
                                                    </td>
                                                    <td>${recipient.deliveredAt}</td>
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
