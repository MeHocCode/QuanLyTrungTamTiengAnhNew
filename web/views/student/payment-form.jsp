<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Payment</title>
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
                    <h1 class="h4">Make Payment</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="payment?action=list" class="btn btn-sm btn-outline-secondary">Back to Payments</a>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Payment Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Course:</strong> ${enrollment.courseTitle}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Class:</strong> ${enrollment.className}
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Amount Due:</strong> $${enrollment.price}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Due Date:</strong> ${enrollment.dueDate}
                                    </div>
                                </div>
                                
                                <div class="alert alert-info">
                                    <strong>Payment Information:</strong> Please complete your payment to continue accessing this course.
                                </div>
                            </div>
                        </div>
                        
                        <form method="post" action="payment?action=process" class="card mt-3">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Payment Method</h5>
                            </div>
                            <div class="card-body">
                                <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">
                                
                                <div class="mb-3">
                                    <label for="amount" class="form-label">Payment Amount</label>
                                    <input type="number" class="form-control" id="amount" name="amount" value="${enrollment.price}" readonly>
                                    <small class="form-text text-muted">Amount cannot be modified</small>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="method" class="form-label">Payment Method</label>
                                    <select class="form-select" id="method" name="method" required>
                                        <option value="">Select payment method</option>
                                        <option value="CREDIT_CARD">Credit Card</option>
                                        <option value="DEBIT_CARD">Debit Card</option>
                                        <option value="BANK_TRANSFER">Bank Transfer</option>
                                        <option value="CASH">Cash</option>
                                        <option value="PAYPAL">PayPal</option>
                                    </select>
                                </div>
                                
                                <div id="cardDetails" style="display: none;">
                                    <div class="mb-3">
                                        <label for="cardNumber" class="form-label">Card Number</label>
                                        <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19">
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="expiryDate" class="form-label">Expiry Date</label>
                                            <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY" maxlength="5">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="cvv" class="form-label">CVV</label>
                                            <input type="text" class="form-control" id="cvv" name="cvv" placeholder="123" maxlength="4">
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="cardholderName" class="form-label">Cardholder Name</label>
                                        <input type="text" class="form-control" id="cardholderName" name="cardholderName" placeholder="John Doe">
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="notes" class="form-label">Additional Notes (Optional)</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Enter any additional notes..."></textarea>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Process Payment</button>
                                    <a href="payment?action=list" class="btn btn-secondary">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        document.getElementById('method').addEventListener('change', function() {
            const cardDetails = document.getElementById('cardDetails');
            const method = this.value;
            
            if (method === 'CREDIT_CARD' || method === 'DEBIT_CARD') {
                cardDetails.style.display = 'block';
            } else {
                cardDetails.style.display = 'none';
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
