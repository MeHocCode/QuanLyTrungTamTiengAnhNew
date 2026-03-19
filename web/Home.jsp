<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduLingo - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/Home.jsp">
                <strong>EduLingo</strong>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/Home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#courses">Courses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/Login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/Register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="jumbotron bg-primary text-white py-5 mb-4">
        <div class="container text-center">
            <h1 class="display-4 fw-bold">Welcome to EduLingo</h1>
            <p class="lead">Learn English with experienced teachers and modern teaching methods</p>
            <p class="mt-4">
                <a class="btn btn-light btn-lg" href="${pageContext.request.contextPath}/Register.jsp" role="button">Get Started</a>
                <a class="btn btn-outline-light btn-lg ms-2" href="#courses" role="button">View Courses</a>
            </p>
        </div>
    </div>

    <!-- Features Section -->
    <div class="container mb-5">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h3 class="card-title">Expert Teachers</h3>
                        <p class="card-text">Learn from certified English teachers with years of experience</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h3 class="card-title">Flexible Schedule</h3>
                        <p class="card-text">Choose from morning, evening, and weekend classes</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h3 class="card-title">Modern Methods</h3>
                        <p class="card-text">Interactive learning with digital resources and activities</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Courses Section -->
    <section id="courses" class="bg-light py-5">
        <div class="container">
            <h2 class="text-center mb-4">Our Courses</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Beginner English</h5>
                            <p class="card-text">Basic grammar, vocabulary, and conversation skills</p>
                            <a href="${pageContext.request.contextPath}/Register.jsp" class="btn btn-primary">Enroll Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Intermediate English</h5>
                            <p class="card-text">Improve your fluency and comprehension</p>
                            <a href="${pageContext.request.contextPath}/Register.jsp" class="btn btn-primary">Enroll Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Advanced English</h5>
                            <p class="card-text">Master complex grammar and professional communication</p>
                            <a href="${pageContext.request.contextPath}/Register.jsp" class="btn btn-primary">Enroll Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h2>About EduLingo</h2>
                    <p>We are dedicated to providing high-quality English education to students of all levels. Our experienced teachers use modern teaching methods to help you achieve your language learning goals.</p>
                    <p>Whether you're a beginner or looking to improve your advanced skills, we have the right course for you.</p>
                </div>
                <div class="col-md-6">
                    <h3>Why Choose Us?</h3>
                    <ul>
                        <li>Experienced and certified teachers</li>
                        <li>Small class sizes for personalized attention</li>
                        <li>Modern facilities and equipment</li>
                        <li>Flexible scheduling options</li>
                        <li>Affordable pricing</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="bg-light py-5">
        <div class="container">
            <h2 class="text-center mb-4">Contact Us</h2>
            <div class="row">
                <div class="col-md-6">
                    <h4>Get in Touch</h4>
                    <p><strong>Address:</strong> 123 English Street, City, Country</p>
                    <p><strong>Phone:</strong> +1 234 567 8900</p>
                    <p><strong>Email:</strong> info@englishcenter.com</p>
                </div>
                <div class="col-md-6">
                    <h4>Business Hours</h4>
                    <p>Monday - Friday: 8:00 AM - 8:00 PM</p>
                    <p>Saturday: 9:00 AM - 6:00 PM</p>
                    <p>Sunday: 10:00 AM - 4:00 PM</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2024 English Center. All rights reserved.</p>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
