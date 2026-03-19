-- Chuyển sang master để tránh lỗi "database in use"
USE master;
GO

-- Nếu database tồn tại thì xóa
IF EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = 'QuanLyTrungTamTiengAnhDB'
)
BEGIN
    ALTER DATABASE QuanLyTrungTamTiengAnhDB 
    SET SINGLE_USER 
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE QuanLyTrungTamTiengAnhDB;
END
GO

-- Tạo lại database mới
CREATE DATABASE QuanLyTrungTamTiengAnhDB;
GO

USE QuanLyTrungTamTiengAnhDB;
GO
-- =========================
-- USERS
-- =========================
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    name NVARCHAR(100) NOT NULL,

    email NVARCHAR(150) NOT NULL UNIQUE,
    -- email dùng làm định danh đăng nhập

    password_hash NVARCHAR(255) NOT NULL,
    -- mật khẩu đã hash (bcrypt, SHA, ...)

    role NVARCHAR(20) NOT NULL DEFAULT 'student',
    -- admin, teacher, student

    phone NVARCHAR(20),

    active NVARCHAR(10) DEFAULT 'ACTIVE',
    -- ACTIVE: tài khoản hoạt động
    -- INACTIVE: tài khoản bị khóa

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- STUDENTS
-- =========================
CREATE TABLE students (
    user_id INT PRIMARY KEY,
    -- Khóa chính, liên kết trực tiếp tới users(user_id)

    date_of_birth DATE,

    address NVARCHAR(255),

    parent_name NVARCHAR(100),
    -- tên phụ huynh (nếu học sinh nhỏ tuổi)

    parent_phone NVARCHAR(20),

    level NVARCHAR(50),
    -- BEGINNER, INTERMEDIATE, ADVANCED, IELTS...

    CONSTRAINT fk_students_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- =========================
-- TEACHERS
-- =========================
CREATE TABLE teachers (
    user_id INT PRIMARY KEY,
    -- Khóa chính, liên kết trực tiếp tới users(user_id)

    expertise NVARCHAR(255),
    -- chuyên môn: IELTS, TOEIC, Grammar...

    experience_years INT,

    qualification NVARCHAR(255),
    -- bằng cấp: Bachelor, Master, IELTS 8.0...

    CONSTRAINT fk_teachers_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- =========================
-- COURSES
-- =========================
CREATE TABLE courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    title NVARCHAR(255) NOT NULL,

    description NVARCHAR(MAX),

    level NVARCHAR(50),
    -- BEGINNER, INTERMEDIATE, ADVANCED

    price DECIMAL(10,2),

    type NVARCHAR(20) DEFAULT 'OFFLINE',
    -- ONLINE, OFFLINE, HYBRID

    duration_weeks INT,

    published NVARCHAR(20) DEFAULT 'DRAFT',
    -- DRAFT: chưa công khai
    -- PUBLISHED: đã công khai

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CLASSES
-- =========================
CREATE TABLE classes (
    class_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    course_id INT NOT NULL,

    teacher_id INT,

    start_date DATE NOT NULL,

    end_date DATE,

    max_size INT,

    schedule_json TEXT,
    -- ví dụ:
    -- {"mon":"18:00","wed":"18:00"}

    location_or_link NVARCHAR(255),
    -- phòng học hoặc link zoom

    status NVARCHAR(20) DEFAULT 'PLANNED',
    -- PLANNED, ONGOING, COMPLETED, CANCELLED

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_classes_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_classes_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(user_id)
        ON DELETE SET NULL
);

-- =========================
-- ENROLLMENTS
-- =========================
CREATE TABLE enrollments (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    student_id INT NOT NULL,

    class_id INT NOT NULL,

    status NVARCHAR(20) DEFAULT 'PENDING',
    -- PENDING: student vừa đăng ký
    -- APPROVED: admin duyệt
    -- REJECTED: admin từ chối
    -- CANCELLED: student hủy

    enrolled_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id)
        REFERENCES students(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_enrollments_class
        FOREIGN KEY (class_id)
        REFERENCES classes(class_id)
        ON DELETE CASCADE,

    CONSTRAINT unique_enrollment UNIQUE (student_id, class_id)
);

-- =========================
-- PAYMENTS
-- =========================
CREATE TABLE payments (
    pay_id INT IDENTITY(1,1) PRIMARY KEY,

    enrollment_id INT NOT NULL,

    amount DECIMAL(10,2),

    method NVARCHAR(50) DEFAULT 'BANK_TRANSFER',
    -- CASH, BANK_TRANSFER, MOMO, VNPAY

    status NVARCHAR(20) DEFAULT 'PENDING',
    -- PENDING, PAID, FAILED

    paid_at DATETIME,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payments_enrollment
        FOREIGN KEY (enrollment_id)
        REFERENCES enrollments(enrollment_id)
        ON DELETE CASCADE
);

-- =========================
-- MATERIALS
-- =========================
CREATE TABLE materials (
    material_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    class_id INT NOT NULL,

    uploaded_by INT NOT NULL,

    filename NVARCHAR(255),

    url NVARCHAR(255),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_materials_class
        FOREIGN KEY (class_id)
        REFERENCES classes(class_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_materials_teachers
        FOREIGN KEY (uploaded_by)
        REFERENCES teachers(user_id)
        ON DELETE CASCADE
);

-- =========================
-- ASSIGNMENTS
-- =========================
CREATE TABLE assignments (
    assignment_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    class_id INT NOT NULL,

    teacher_id INT NOT NULL,

    title NVARCHAR(255),

    description NVARCHAR(MAX),

    start_date DATETIME NOT NULL,

    end_date DATETIME,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_assignments_class
        FOREIGN KEY (class_id)
        REFERENCES classes(class_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_assignments_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(user_id)
        ON DELETE CASCADE
);

-- =========================
-- SUBMISSIONS
-- =========================
CREATE TABLE submissions (
    submission_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    assignment_id INT NOT NULL,

    student_id INT NOT NULL,

    file_url NVARCHAR(255),

    submitted_at DATETIME,

    grade DECIMAL(5,2),

    feedback NVARCHAR(MAX),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_submissions_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES assignments(assignment_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_submissions_student
        FOREIGN KEY (student_id)
        REFERENCES students(user_id)
        ON DELETE NO ACTION,

    CONSTRAINT unique_submission UNIQUE (assignment_id, student_id)
);

-- =========================
-- MOCK TESTS
-- =========================
CREATE TABLE mock_tests (
    test_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    class_id INT,

    title NVARCHAR(255),

    questions_json TEXT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_mock_tests_class
        FOREIGN KEY (class_id)
        REFERENCES classes(class_id)
        ON DELETE SET NULL
);

-- =========================
-- TEST RESULTS
-- =========================
CREATE TABLE test_results (
    result_id INT IDENTITY(1,1) PRIMARY KEY,
    -- ID tự động tăng

    test_id INT NOT NULL,

    student_id INT NOT NULL,

    score DECIMAL(5,2),

    details NVARCHAR(MAX),

    taken_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_test_results_test
        FOREIGN KEY (test_id)
        REFERENCES mock_tests(test_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_test_results_student
        FOREIGN KEY (student_id)
        REFERENCES students(user_id)
        ON DELETE CASCADE
);

-- =========================
-- LEADS
-- =========================
CREATE TABLE leads (
    id INT IDENTITY(1,1) PRIMARY KEY,

    name NVARCHAR(100),

    phone NVARCHAR(20),

    email NVARCHAR(150),

    note NVARCHAR(MAX),

    status NVARCHAR(20) DEFAULT 'NEW',
    -- NEW, CONTACTED, CONVERTED

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- NOTIFICATIONS
-- =========================
CREATE TABLE notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,

    user_id INT NOT NULL,

    type NVARCHAR(50),
    -- PAYMENT, ENROLLMENT, CLASS, ASSIGNMENT, SYSTEM

    message NVARCHAR(MAX),

    read_flag NVARCHAR(10) DEFAULT 'UNREAD',
    -- UNREAD, READ

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notifications_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);