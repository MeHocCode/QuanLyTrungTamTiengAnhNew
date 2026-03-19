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

                <div class="row">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Enrollment Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Enrollment ID:</strong> #${enrollment.enrollmentId}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Student:</strong> ${enrollment.studentName}
                                    </div>
                                </div>
                                
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
                                        <strong>Enrollment Date:</strong> ${enrollment.enrolledAt}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Payment Status:</strong> 
                                        <span class="badge bg-${enrollment.paymentStatus == 'PAID' ? 'success' : 'danger'}">${enrollment.paymentStatus}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <strong>Course Price:</strong> $${enrollment.price}
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Amount Due:</strong> $${enrollment.price - enrollment.paidAmount}
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <form method="post" action="payment?action=process" class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Payment Information</h5>
                            </div>
                            <div class="card-body">
                                <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">
                                <input type="hidden" name="amount" value="${enrollment.price - enrollment.paidAmount}">
                                
                                <div class="mb-3">
                                    <label for="paymentMethod" class="form-label">Payment Method</label>
                                    <select class="form-select" id="paymentMethod" name="paymentMethod" required onchange="togglePaymentFields()">
                                        <option value="">Select payment method</option>
                                        <option value="CREDIT_CARD">Credit Card</option>
                                        <option value="DEBIT_CARD">Debit Card</option>
                                        <option value="BANK_TRANSFER">Bank Transfer</option>
                                        <option value="CASH">Cash</option>
                                        <option value="PAYPAL">PayPal</option>
                                    </select>
                                </div>
                                
                                <!-- Credit/Debit Card Fields -->
                                <div id="cardFields" style="display: none;">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="cardNumber" class="form-label">Card Number</label>
                                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="cardHolder" class="form-label">Card Holder Name</label>
                                            <input type="text" class="form-control" id="cardHolder" name="cardHolder" placeholder="John Doe">
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <label for="expiryDate" class="form-label">Expiry Date</label>
                                            <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="cvv" class="form-label">CVV</label>
                                            <input type="text" class="form-control" id="cvv" name="cvv" placeholder="123">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Bank Transfer Fields -->
                                <div id="bankFields" style="display: none;">
                                    <div class="alert alert-info">
                                        <h6>Bank Transfer Details:</h6>
                                        <p><strong>Bank:</strong> English Center Bank<br>
                                        <strong>Account:</strong> 1234567890<br>
                                        <strong>Routing:</strong> 987654321<br>
                                        <strong>Reference:</strong> Enrollment #${enrollment.enrollmentId}</p>
                                    </div>
                                    <div class="mb-3">
                                        <label for="transactionId" class="form-label">Transaction ID</label>
                                        <input type="text" class="form-control" id="transactionId" name="transactionId" placeholder="Enter transaction ID">
                                    </div>
                                </div>
                                
                                <!-- Cash Fields -->
                                <div id="cashFields" style="display: none;">
                                    <div class="alert alert-warning">
                                        <h6>Cash Payment Instructions:</h6>
                                        <p>Please visit our office to make cash payment. Bring this enrollment ID: #${enrollment.enrollmentId}</p>
                                        <p><strong>Office Hours:</strong> Monday - Friday: 8:00 AM - 8:00 PM<br>
                                        <strong>Address:</strong> 123 English Street, City, Country</p>
                                    </div>
                                </div>
                                
                                <!-- PayPal Fields -->
                                <div id="paypalFields" style="display: none;">
                                    <div class="alert alert-info">
                                        <h6>PayPal Payment:</h6>
                                        <p>You will be redirected to PayPal to complete your payment.</p>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="notes" class="form-label">Notes (Optional)</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Add any notes about this payment..."></textarea>
                                </div>
                                
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary">Process Payment</button>
                                    <a href="payment?action=list" class="btn btn-secondary">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Payment Summary</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Course Price:</strong>
                                    <div class="text-end">$${enrollment.price}</div>
                                </div>
                                <div class="mb-3">
                                    <strong>Already Paid:</strong>
                                    <div class="text-end text-success">$${enrollment.paidAmount}</div>
                                </div>
                                <div class="mb-3">
                                    <strong>Amount Due:</strong>
                                    <div class="text-end text-danger">$${enrollment.price - enrollment.paidAmount}</div>
                                </div>
                                <hr>
                                <div class="mb-3">
                                    <strong>Total Payment:</strong>
                                    <div class="text-end h4 text-primary">$${enrollment.price - enrollment.paidAmount}</div>
                                </div>
                                
                                <div class="alert alert-info">
                                    <small><strong>Note:</strong> Payment processing may take a few minutes. You will receive a confirmation email once the payment is complete.</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        function togglePaymentFields() {
            const method = document.getElementById('paymentMethod').value;
            
            // Hide all payment fields
            document.getElementById('cardFields').style.display = 'none';
            document.getElementById('bankFields').style.display = 'none';
            document.getElementById('cashFields').style.display = 'none';
            document.getElementById('paypalFields').style.display = 'none';
            
            // Show relevant fields based on payment method
            if (method === 'CREDIT_CARD' || method === 'DEBIT_CARD') {
                document.getElementById('cardFields').style.display = 'block';
            } else if (method === 'BANK_TRANSFER') {
                document.getElementById('bankFields').style.display = 'block';
            } else if (method === 'CASH') {
                document.getElementById('cashFields').style.display = 'block';
            } else if (method === 'PAYPAL') {
                document.getElementById('paypalFields').style.display = 'block';
            }
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
