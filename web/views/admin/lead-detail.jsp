<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lead Details - Admin Dashboard</title>
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
                    <h1 class="h4">Lead Details</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="lead?action=list" class="btn btn-sm btn-outline-secondary">Back to Leads</a>
                        </div>
                        <div class="btn-group">
                            <a href="lead?action=edit&id=${lead.id}" class="btn btn-sm btn-warning">Edit Lead</a>
                            <c:if test="${lead.status == 'NEW' || lead.status == 'CONTACTED'}">
                                <a href="lead?action=contact&id=${lead.id}" class="btn btn-sm btn-success">Contact</a>
                            </c:if>
                            <c:if test="${lead.status == 'QUALIFIED'}">
                                <a href="lead?action=convert&id=${lead.id}" class="btn btn-sm btn-primary">Convert to Student</a>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Lead Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Lead ID:</strong> #${lead.id}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Status:</strong> 
                                        <span class="badge bg-${lead.status == 'NEW' ? 'primary' : lead.status == 'CONTACTED' ? 'info' : lead.status == 'QUALIFIED' ? 'success' : lead.status == 'CONVERTED' ? 'warning' : 'secondary'}">${lead.status}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Name:</strong> ${lead.name}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Email:</strong> ${lead.email}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Phone:</strong> ${lead.phone}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Created Date:</strong> ${lead.createdAt}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-12">
                                        <strong>Notes:</strong>
                                        <div class="mt-2 p-3 bg-light rounded">
                                            ${lead.note}
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-12">
                                        <strong>Contact History:</strong>
                                        <div class="mt-2">
                                            <c:if test="${empty contactHistory}">
                                                <p class="text-muted">No contact history available</p>
                                            </c:if>
                                            <c:if test="${!empty contactHistory}">
                                                <div class="list-group">
                                                    <c:forEach items="${contactHistory}" var="contact">
                                                        <div class="list-group-item">
                                                            <div class="d-flex justify-content-between">
                                                                <div>
                                                                    <h6 class="mb-1">Contact on ${contact.contactDate}</h6>
                                                                    <p class="mb-1">${contact.notes}</p>
                                                                </div>
                                                                <small class="text-muted">By ${contact.contactedBy}</small>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <c:if test="${lead.status == 'NEW'}">
                                        <a href="lead?action=contact&id=${lead.id}" class="btn btn-success w-100">Mark as Contacted</a>
                                    </c:if>
                                    <c:if test="${lead.status == 'CONTACTED'}">
                                        <a href="lead?action=qualify&id=${lead.id}" class="btn btn-info w-100">Mark as Qualified</a>
                                    </c:if>
                                    <c:if test="${lead.status == 'QUALIFIED'}">
                                        <a href="lead?action=convert&id=${lead.id}" class="btn btn-primary w-100">Convert to Student</a>
                                    </c:if>
                                    <a href="lead?action=edit&id=${lead.id}" class="btn btn-warning w-100">Edit Lead</a>
                                    <a href="mailto:${lead.email}" class="btn btn-outline-primary w-100">Send Email</a>
                                    <a href="tel:${lead.phone}" class="btn btn-outline-success w-100">Call</a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card mt-3">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Add Contact Note</h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="lead?action=add-contact">
                                    <input type="hidden" name="leadId" value="${lead.id}">
                                    <div class="mb-3">
                                        <label for="contactNotes" class="form-label">Contact Notes</label>
                                        <textarea class="form-control" id="contactNotes" name="contactNotes" rows="3" placeholder="Enter contact notes..."></textarea>
                                    </div>
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary">Add Note</button>
                                        <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                                    </div>
                                </form>
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
