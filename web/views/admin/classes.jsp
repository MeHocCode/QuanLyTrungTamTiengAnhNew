<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Classes Management - English Center</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Classes Management</h1>
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
            <section class="classes-management">
                <div class="section-header">
                    <h2>All Classes</h2>
                    <button class="btn btn-primary" onclick="showAddClassModal()">Add New Class</button>
                </div>
                
                <div class="search-filter">
                    <input type="text" id="searchInput" placeholder="Search classes...">
                    <select id="filterSelect">
                        <option value="">All Classes</option>
                        <option value="PLANNED">Planned</option>
                        <option value="ONGOING">Ongoing</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>
                
                <div class="classes-table">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Course</th>
                                <th>Teacher</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Max Size</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- TODO: Display classes list -->
                            <tr>
                                <td colspan="8">No classes found.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
        
        <!-- TODO: Add Class Modal -->
        <div id="addClassModal" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close" onclick="hideAddClassModal()">&times;</span>
                <h3>Add New Class</h3>
                <form id="addClassForm">
                    <!-- TODO: Add class form fields -->
                </form>
            </div>
        </div>
        
        <footer>
            <p>&copy; 2024 English Center Management System</p>
        </footer>
    </div>
    
    <script>
        // TODO: Implement JavaScript functionality
        function showAddClassModal() {
            document.getElementById('addClassModal').style.display = 'block';
        }
        
        function hideAddClassModal() {
            document.getElementById('addClassModal').style.display = 'none';
        }
    </script>
</body>
</html>
