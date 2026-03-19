<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications</title>
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
                    <h1 class="h4">Notifications</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="markAllAsRead()">Mark All as Read</button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th>Message</th>
                                <th>From</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${notifications}" var="notification">
                                <tr class="${notification.readFlag == 'UNREAD' ? 'table-primary' : ''}">
                                    <td>
                                        <span class="badge bg-${notification.type == 'INFO' ? 'info' : notification.type == 'WARNING' ? 'warning' : notification.type == 'SUCCESS' ? 'success' : 'danger'}">${notification.type}</span>
                                    </td>
                                    <td>${notification.message}</td>
                                    <td>${notification.fromUser}</td>
                                    <td>${notification.createdAt}</td>
                                    <td>
                                        <span class="badge bg-${notification.readFlag == 'READ' ? 'secondary' : 'primary'}">${notification.readFlag}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="notification?action=detail&id=${notification.notificationId}" class="btn btn-sm btn-info">View</a>
                                            <c:if test="${notification.readFlag == 'UNREAD'}">
                                                <a href="notification?action=mark-read&id=${notification.notificationId}" class="btn btn-sm btn-success">Mark as Read</a>
                                            </c:if>
                                            <a href="notification?action=delete&id=${notification.notificationId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
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
    
    <script>
        function markAllAsRead() {
            if (confirm('Mark all notifications as read?')) {
                window.location.href = 'notification?action=mark-all-read';
            }
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
