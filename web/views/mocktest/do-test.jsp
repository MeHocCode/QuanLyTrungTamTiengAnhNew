<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Mock Test</title>
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
                    <h1 class="h4">Mock Test</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <div class="timer">
                                <strong>Time Remaining:</strong> <span id="timer">${durationMinutes}:00</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Test Header -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">${test.title}</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-8">
                                <p><strong>Course:</strong> ${test.courseTitle}</p>
                                <p><strong>Questions:</strong> ${test.questionCount}</p>
                                <p><strong>Duration:</strong> ${test.durationMinutes} minutes</p>
                            </div>
                            <div class="col-md-4">
                                <div class="progress mb-2">
                                    <div class="progress-bar" id="progressBar" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                        <span id="progressText">0%</span>
                                    </div>
                                </div>
                                <small class="text-muted">Question <span id="currentQuestion">1</span> of ${test.questionCount}</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Test Form -->
                <form method="post" action="mocktest?action=submit" id="testForm">
                    <input type="hidden" name="testId" value="${test.testId}">
                    <input type="hidden" name="startTime" value="${startTime}">
                    
                    <!-- Questions Container -->
                    <div id="questionsContainer">
                        <c:forEach items="${questions}" var="question" varStatus="status">
                            <div class="question-card card mb-4" id="question-${status.index + 1}" style="${status.index == 0 ? '' : 'display: none;'}">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Question ${status.index + 1}</h6>
                                </div>
                                <div class="card-body">
                                    <p class="mb-3">${question.questionText}</p>
                                    
                                    <c:if test="${question.type == 'MULTIPLE_CHOICE'}">
                                        <div class="options">
                                            <c:forEach items="${question.options}" var="option" varStatus="optionStatus">
                                                <div class="form-check mb-2">
                                                    <input class="form-check-input" type="radio" name="answer_${question.questionId}" id="answer_${question.questionId}_${optionStatus.index}" value="${option}" required>
                                                    <label class="form-check-label" for="answer_${question.questionId}_${optionStatus.index}">
                                                        ${option}
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${question.type == 'TRUE_FALSE'}">
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="answer_${question.questionId}" id="answer_${question.questionId}_true" value="true" required>
                                            <label class="form-check-label" for="answer_${question.questionId}_true">
                                                True
                                            </label>
                                        </div>
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="answer_${question.questionId}" id="answer_${question.questionId}_false" value="false" required>
                                            <label class="form-check-label" for="answer_${question.questionId}_false">
                                                False
                                            </label>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${question.type == 'SHORT_ANSWER'}">
                                        <div class="mb-3">
                                            <textarea class="form-control" name="answer_${question.questionId}" rows="3" placeholder="Enter your answer..." required></textarea>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Navigation Buttons -->
                    <div class="d-flex justify-content-between mb-4">
                        <button type="button" class="btn btn-secondary" id="prevBtn" onclick="previousQuestion()" disabled>Previous</button>
                        <button type="button" class="btn btn-primary" id="nextBtn" onclick="nextQuestion()">Next</button>
                        <button type="button" class="btn btn-success" id="submitBtn" onclick="submitTest()" style="display: none;">Submit Test</button>
                    </div>

                    <!-- Question Navigation -->
                    <div class="card">
                        <div class="card-header">
                            <h6 class="card-title mb-0">Quick Navigation</h6>
                        </div>
                        <div class="card-body">
                            <div class="question-nav">
                                <c:forEach items="${questions}" var="question" varStatus="status">
                                    <button type="button" class="btn btn-sm btn-outline-primary m-1" onclick="goToQuestion(${status.index + 1})" id="nav-btn-${status.index + 1}">
                                        ${status.index + 1}
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
    </div>
    
    <script>
        let currentQuestionIndex = 1;
        const totalQuestions = ${test.questionCount};
        let timerInterval;
        let timeLeft = ${durationMinutes} * 60; // Convert to seconds
        
        // Timer functionality
        function startTimer() {
            timerInterval = setInterval(function() {
                timeLeft--;
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                document.getElementById('timer').textContent = 
                    minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
                
                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    submitTest();
                }
            }, 1000);
        }
        
        // Question navigation
        function showQuestion(index) {
            // Hide all questions
            for (let i = 1; i <= totalQuestions; i++) {
                document.getElementById('question-' + i).style.display = 'none';
            }
            
            // Show current question
            document.getElementById('question-' + index).style.display = 'block';
            
            // Update navigation buttons
            document.getElementById('prevBtn').disabled = (index === 1);
            document.getElementById('nextBtn').style.display = (index === totalQuestions) ? 'none' : 'inline-block';
            document.getElementById('submitBtn').style.display = (index === totalQuestions) ? 'inline-block' : 'none';
            
            // Update progress
            updateProgress();
        }
        
        function nextQuestion() {
            if (currentQuestionIndex < totalQuestions) {
                currentQuestionIndex++;
                showQuestion(currentQuestionIndex);
            }
        }
        
        function previousQuestion() {
            if (currentQuestionIndex > 1) {
                currentQuestionIndex--;
                showQuestion(currentQuestionIndex);
            }
        }
        
        function goToQuestion(index) {
            currentQuestionIndex = index;
            showQuestion(currentQuestionIndex);
        }
        
        function updateProgress() {
            const progress = (currentQuestionIndex / totalQuestions) * 100;
            document.getElementById('progressBar').style.width = progress + '%';
            document.getElementById('progressText').textContent = Math.round(progress) + '%';
            document.getElementById('currentQuestion').textContent = currentQuestionIndex;
            
            // Update navigation buttons
            for (let i = 1; i <= totalQuestions; i++) {
                const btn = document.getElementById('nav-btn-' + i);
                if (i <= currentQuestionIndex) {
                    btn.classList.remove('btn-outline-primary');
                    btn.classList.add('btn-primary');
                } else {
                    btn.classList.remove('btn-primary');
                    btn.classList.add('btn-outline-primary');
                }
            }
        }
        
        function submitTest() {
            if (confirm('Are you sure you want to submit the test? You cannot change your answers after submission.')) {
                clearInterval(timerInterval);
                document.getElementById('testForm').submit();
            }
        }
        
        // Start timer when page loads
        window.onload = function() {
            startTimer();
            showQuestion(1);
        };
        
        // Prevent page refresh/close
        window.addEventListener('beforeunload', function(e) {
            if (timeLeft > 0) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
