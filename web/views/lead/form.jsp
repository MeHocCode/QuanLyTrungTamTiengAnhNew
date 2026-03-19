<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - English Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header text-center">
                        <h3 class="mb-0">Contact English Center</h3>
                    </div>
                    <div class="card-body">
                        <form method="post" action="lead?action=create">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="firstName" class="form-label">First Name</label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" required placeholder="Enter first name...">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" required placeholder="Enter last name...">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" required placeholder="Enter your email...">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" required placeholder="Enter your phone number...">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="courseInterest" class="form-label">Course Interest</label>
                                <select class="form-select" id="courseInterest" name="courseInterest" required>
                                    <option value="">Select a course</option>
                                    <option value="beginner">Beginner English</option>
                                    <option value="intermediate">Intermediate English</option>
                                    <option value="advanced">Advanced English</option>
                                    <option value="business">Business English</option>
                                    <option value="ielts">IELTS Preparation</option>
                                    <option value="conversation">Conversation Practice</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" name="message" rows="4" placeholder="Tell us about your learning goals..."></textarea>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="preferredSchedule" class="form-label">Preferred Schedule</label>
                                        <select class="form-select" id="preferredSchedule" name="preferredSchedule">
                                            <option value="">Select schedule</option>
                                            <option value="morning">Morning (8AM - 12PM)</option>
                                            <option value="afternoon">Afternoon (12PM - 5PM)</option>
                                            <option value="evening">Evening (5PM - 9PM)</option>
                                            <option value="weekend">Weekend</option>
                                            <option value="flexible">Flexible</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="hearAbout" class="form-label">How did you hear about us?</label>
                                        <select class="form-select" id="hearAbout" name="hearAbout">
                                            <option value="">Select one</option>
                                            <option value="google">Google Search</option>
                                            <option value="facebook">Facebook</option>
                                            <option value="friend">Friend Referral</option>
                                            <option value="advertisement">Advertisement</option>
                                            <option value="other">Other</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="newsletter" name="newsletter">
                                <label class="form-check-label" for="newsletter">Send me course updates and special offers</label>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Submit Inquiry</button>
                            </div>
                            
                            <div class="text-center mt-3">
                                <small class="text-muted">We'll contact you within 24 hours to discuss your learning needs.</small>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Contact Information -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Contact Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Address</h6>
                                <p>123 English Street<br>City, Country 12345</p>
                            </div>
                            <div class="col-md-6">
                                <h6>Phone & Email</h6>
                                <p><strong>Phone:</strong> +1 234 567 8900<br>
                                <strong>Email:</strong> info@englishcenter.com</p>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <h6>Business Hours</h6>
                                <p>Monday - Friday: 8:00 AM - 8:00 PM<br>
                                Saturday: 9:00 AM - 6:00 PM<br>
                                Sunday: 10:00 AM - 4:00 PM</p>
                            </div>
                            <div class="col-md-6">
                                <h6>Follow Us</h6>
                                <div class="d-flex gap-2">
                                    <a href="#" class="btn btn-sm btn-outline-primary">Facebook</a>
                                    <a href="#" class="btn btn-sm btn-outline-info">Twitter</a>
                                    <a href="#" class="btn btn-sm btn-outline-danger">Instagram</a>
                                </div>
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
