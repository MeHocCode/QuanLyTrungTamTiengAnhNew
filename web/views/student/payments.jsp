<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payments</title>
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
                    <h1 class="h4">My Payments</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="payment?action=form" class="btn btn-sm btn-outline-secondary">Make New Payment</a>
                        </div>
                    </div>
                </div>

                <!-- Payment Statistics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <h5 class="card-title">Total Paid</h5>
                                <h2>$${totalPaid}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <h5 class="card-title">Pending</h5>
                                <h2>$${pendingAmount}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <h5 class="card-title">This Month</h5>
                                <h2>$${monthlyPayments}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <h5 class="card-title">Total Transactions</h5>
                                <h2>${totalTransactions}</h2>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Course</th>
                                <th>Amount</th>
                                <th>Method</th>
                                <th>Status</th>
                                <th>Payment Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${payments}" var="payment">
                                <tr>
                                    <td>#${payment.payId}</td>
                                    <td>${payment.courseTitle}</td>
                                    <td>$${payment.amount}</td>
                                    <td>${payment.method}</td>
                                    <td>
                                        <span class="badge bg-${payment.status == 'PAID' ? 'success' : payment.status == 'PENDING' ? 'warning' : 'danger'}">${payment.status}</span>
                                    </td>
                                    <td>${payment.paidAt}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="payment?action=detail&id=${payment.payId}" class="btn btn-sm btn-info">View</a>
                                            <c:if test="${payment.status == 'PENDING'}">
                                                <a href="payment?action=complete&id=${payment.payId}" class="btn btn-sm btn-success">Complete</a>
                                            </c:if>
                                            <a href="payment?action=invoice&id=${payment.payId}" class="btn btn-sm btn-primary">Invoice</a>
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
