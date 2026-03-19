<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You - English Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid vh-100 d-flex align-items-center justify-content-center">
        <div class="row w-100">
            <div class="col-md-6 mx-auto">
                <div class="card shadow text-center">
                    <div class="card-body py-5">
                        <div class="mb-4">
                            <div class="text-success mb-3">
                                <i class="bi bi-check-circle-fill" style="font-size: 4rem;"></i>
                            </div>
                            <h2 class="text-success">Thank You!</h2>
                            <p class="lead">Your inquiry has been submitted successfully.</p>
                        </div>
                        
                        <div class="mb-4">
                            <h5>What happens next?</h5>
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="bi bi-check-circle text-success"></i>
                                    We'll review your inquiry within 24 hours
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle text-success"></i>
                                    Our team will contact you by phone or email
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle text-success"></i>
                                    We'll discuss your learning goals and recommend the best course
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle text-success"></i>
                                    You'll receive a free consultation and course information
                                </li>
                            </ul>
                        </div>
                        
                        <div class="alert alert-info">
                            <strong>Important:</strong> Please check your email (including spam folder) for our response.
                        </div>
                        
                        <div class="d-grid gap-2">
                            <a href="Home.jsp" class="btn btn-primary">Return to Homepage</a>
                            <a href="Login.jsp" class="btn btn-outline-primary">Login to Account</a>
                        </div>
                        
                        <div class="mt-4">
                            <h6>Need immediate assistance?</h6>
                            <p class="mb-0">
                                <strong>Phone:</strong> +1 234 567 8900<br>
                                <strong>Email:</strong> info@englishcenter.com
                            </p>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Links -->
                <div class="card mt-4">
                    <div class="card-body">
                        <h5 class="card-title mb-3">Quick Links</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li><a href="Home.jsp">Homepage</a></li>
                                    <li><a href="Home.jsp#courses">View Courses</a></li>
                                    <li><a href="Home.jsp#about">About Us</a></li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li><a href="Register.jsp">Create Account</a></li>
                                    <li><a href="Login.jsp">Login</a></li>
                                    <li><a href="lead/form.jsp">Contact Form</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
