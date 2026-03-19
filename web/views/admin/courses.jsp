<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Courses Management - English Center</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Courses Management</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/admin/students.jsp">Students</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/admin/teachers.jsp">Teachers</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/admin/courses.jsp">Courses</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/admin/classes.jsp">Classes</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutController">Logout</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <section class="courses-management">
                <div class="section-header">
                    <h2>All Courses</h2>
                    <button class="btn btn-primary" onclick="showAddCourseModal()">Add New Course</button>
                </div>
                
                <div class="search-filter">
                    <input type="text" id="searchInput" placeholder="Search courses...">
                    <select id="filterSelect">
                        <option value="">All Courses</option>
                        <option value="BEGINNER">Beginner</option>
                        <option value="INTERMEDIATE">Intermediate</option>
                        <option value="ADVANCED">Advanced</option>
                        <option value="PUBLISHED">Published</option>
                        <option value="DRAFT">Draft</option>
                    </select>
                </div>
                
                <div class="courses-table">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Level</th>
                                <th>Price</th>
                                <th>Duration</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- TODO: Display courses list -->
                            <tr>
                                <td colspan="8">No courses found.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
        
        <!-- TODO: Add Course Modal -->
        <div id="addCourseModal" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close" onclick="hideAddCourseModal()">&times;</span>
                <h3>Add New Course</h3>
                <form id="addCourseForm">
                    <!-- TODO: Add course form fields -->
                </form>
            </div>
        </div>
        
        <footer>
            <p>&copy; 2024 English Center Management System</p>
        </footer>
    </div>
    
    <script>
        // TODO: Implement JavaScript functionality
        function showAddCourseModal() {
            document.getElementById('addCourseModal').style.display = 'block';
        }
        
        function hideAddCourseModal() {
            document.getElementById('addCourseModal').style.display = 'none';
        }
    </script>
</body>
</html>
