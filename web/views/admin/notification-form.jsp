<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Notification - Admin Dashboard</title>
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
                    <h1 class="h4">Create Notification</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="notification?action=list" class="btn btn-sm btn-outline-secondary">Back to Notifications</a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <form method="post" action="notification?action=create" class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">New Notification</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="type" class="form-label">Notification Type</label>
                                    <select class="form-select" id="type" name="type" required>
                                        <option value="">Select type</option>
                                        <option value="INFO">Information</option>
                                        <option value="WARNING">Warning</option>
                                        <option value="SUCCESS">Success</option>
                                        <option value="ERROR">Error</option>
                                        <option value="ANNOUNCEMENT">Announcement</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="message" class="form-label">Message</label>
                                    <textarea class="form-control" id="message" name="message" rows="4" required placeholder="Enter notification message..."></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="targetUsers" class="form-label">Target Users</label>
                                    <select class="form-select" id="targetUsers" name="targetUsers" multiple>
                                        <option value="ALL">All Users</option>
                                        <option value="ADMIN">Admins Only</option>
                                        <option value="TEACHER">Teachers Only</option>
                                        <option value="STUDENT">Students Only</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="scheduleSend" class="form-label">Schedule Send</label>
                                    <input type="datetime-local" class="form-control" id="scheduleSend" name="scheduleSend">
                                    <small class="form-text text-muted">Leave empty to send immediately</small>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Send Notification</button>
                                    <a href="notification?action=list" class="btn btn-secondary">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Notification Templates</h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group">
                                    <a href="#" onclick="useTemplate('info')" class="list-group-item list-group-item-action">
                                        System Maintenance Notice
                                        <small class="text-muted">Information type</small>
                                    </a>
                                    <a href="#" onclick="useTemplate('warning')" class="list-group-item list-group-item-action">
                                        Payment Reminder
                                        <small class="text-muted">Warning type</small>
                                    </a>
                                    <a href="#" onclick="useTemplate('announcement')" class="list-group-item list-group-item-action">
                                        New Course Announcement
                                        <small class="text-muted">Announcement type</small>
                                    </a>
                                    <a href="#" onclick="useTemplate('holiday')" class="list-group-item list-group-item-action">
                                        Holiday Notice
                                        <small class="text-muted">Information type</small>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        function useTemplate(type) {
            const templates = {
                'info': 'System will be under maintenance from 10:00 PM to 12:00 AM tonight. Please save your work and log out.',
                'warning': 'Your monthly payment is due in 3 days. Please ensure payment is made to avoid service interruption.',
                'announcement': 'We are excited to announce our new Advanced English course starting next month!',
                'holiday': 'The center will be closed on [date] for the holiday. Classes will resume on [date].'
            };
            
            document.getElementById('message').value = templates[type] || '';
            
            // Set appropriate type
            if (type === 'warning') {
                document.getElementById('type').value = 'WARNING';
            } else if (type === 'announcement') {
                document.getElementById('type').value = 'ANNOUNCEMENT';
            } else {
                document.getElementById('type').value = 'INFO';
            }
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
