<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mock Test</title>
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
                    <h1 class="h4">Mock Test: ${test.title}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <span class="badge bg-info">Time Remaining: <span id="timeRemaining">${test.durationMinutes}:00</span></span>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <form method="post" action="mocktest?action=submit" id="testForm">
                            <input type="hidden" name="testId" value="${test.testId}">
                            
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Test Instructions</h5>
                                </div>
                                <div class="card-body">
                                    <p>${test.description}</p>
                                    <div class="alert alert-info">
                                        <strong>Important:</strong> This test has ${test.questionCount} questions and must be completed within ${test.durationMinutes} minutes.
                                    </div>
                                </div>
                            </div>
                            
                            <div id="questionsContainer">
                                <!-- Questions will be loaded here via JavaScript -->
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                                <button type="submit" class="btn btn-primary">Submit Test</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        // Sample questions data (in real app, this would come from backend)
        const questions = [
            {
                id: 1,
                question: "What is the correct past tense of 'go'?",
                options: ["went", "goed", "gone", "going"],
                type: "multiple_choice"
            },
            {
                id: 2,
                question: "Choose the correct article: '___ apple'",
                options: ["A", "An", "The", "No article needed"],
                type: "multiple_choice"
            },
            {
                id: 3,
                question: "Complete the sentence: I ___ to school every day.",
                options: ["go", "goes", "going", "went"],
                type: "multiple_choice"
            }
        ];
        
        let currentQuestion = 0;
        let timeRemaining = ${test.durationMinutes} * 60; // Convert to seconds
        
        function displayQuestion() {
            const container = document.getElementById('questionsContainer');
            const question = questions[currentQuestion];
            
            let html = `
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Question ${currentQuestion + 1} of ${questions.length}</h5>
                    </div>
                    <div class="card-body">
                        <p class="mb-3"><strong>${question.question}</strong></p>
                        <div class="list-group">
            `;
            
            question.options.forEach((option, index) => {
                html += `
                    <div class="list-group-item">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="question_${question.id}" id="q${question.id}_opt${index}" value="${option}">
                            <label class="form-check-label" for="q${question.id}_opt${index}">
                                ${String.fromCharCode(65 + index)}. ${option}
                            </label>
                        </div>
                    </div>
                `;
            });
            
            html += `
                        </div>
                    </div>
                </div>
            `;
            
            container.innerHTML = html;
        }
        
        function nextQuestion() {
            if (currentQuestion < questions.length - 1) {
                currentQuestion++;
                displayQuestion();
            }
        }
        
        function previousQuestion() {
            if (currentQuestion > 0) {
                currentQuestion--;
                displayQuestion();
            }
        }
        
        function updateTimer() {
            const minutes = Math.floor(timeRemaining / 60);
            const seconds = timeRemaining % 60;
            document.getElementById('timeRemaining').textContent = 
                `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
            
            if (timeRemaining <= 0) {
                document.getElementById('testForm').submit();
            }
            
            timeRemaining--;
        }
        
        // Initialize
        displayQuestion();
        setInterval(updateTimer, 1000);
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
