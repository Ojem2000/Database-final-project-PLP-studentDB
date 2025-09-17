-- ===================================================
-- DATABASE: Student Records Management System
-- ===================================================
-- This script creates a database for managing students,
-- instructors, courses, enrollments, and grades.
-- It also inserts sample data (6 departments, 30 students,
-- 10 instructors, and 10 courses).
-- ===================================================

-- Create new database
CREATE DATABASE StudentRecordsDB;
USE StudentRecordsDB;

-- ===================================================
-- TABLE: Departments
-- Each student, instructor, and course belongs to a department
-- ===================================================
CREATE TABLE Departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY, -- unique ID
    dept_name VARCHAR(100) NOT NULL UNIQUE  -- department name
);

-- ===================================================
-- TABLE: Students
-- Stores personal details of students
-- ===================================================
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY, -- unique student ID
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,                         -- date of birth
    gender ENUM('Male','Female','Other') NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,        -- must be unique
    phone VARCHAR(20) UNIQUE,                  -- optional but unique
    dept_id INT NOT NULL,                      -- linked to Departments
    CONSTRAINT fk_student_department FOREIGN KEY (dept_id)
        REFERENCES Departments(dept_id) ON DELETE CASCADE
);

-- ===================================================
-- TABLE: Instructors
-- Stores instructor details
-- ===================================================
CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY, -- unique instructor ID
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,           -- must be unique
    hire_date DATE NOT NULL,
    dept_id INT NOT NULL,                         -- linked to Departments
    CONSTRAINT fk_instructor_department FOREIGN KEY (dept_id)
        REFERENCES Departments(dept_id) ON DELETE CASCADE
);

-- ===================================================
-- TABLE: Courses
-- Each course belongs to a department and is taught by an instructor
-- ===================================================
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,  -- unique course ID
    course_code VARCHAR(10) NOT NULL UNIQUE,   -- e.g., CSE101
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),  -- must be positive
    dept_id INT NOT NULL,                      -- linked to Departments
    instructor_id INT NOT NULL,                -- linked to Instructors
    CONSTRAINT fk_course_department FOREIGN KEY (dept_id)
        REFERENCES Departments(dept_id) ON DELETE CASCADE,
    CONSTRAINT fk_course_instructor FOREIGN KEY (instructor_id)
        REFERENCES Instructors(instructor_id) ON DELETE CASCADE
);

-- ===================================================
-- TABLE: Enrollments
-- Many-to-Many relationship between Students and Courses
-- ===================================================
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY, -- unique enrollment ID
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(20) NOT NULL,                -- e.g., Fall, Spring
    year YEAR NOT NULL,
    CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id)
        REFERENCES Students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id)
        REFERENCES Courses(course_id) ON DELETE CASCADE,
    CONSTRAINT uc_student_course UNIQUE (student_id, course_id, semester, year)
);

-- ===================================================
-- TABLE: Grades
-- One-to-One relationship with Enrollments
-- ===================================================
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY, -- unique grade ID
    enrollment_id INT NOT NULL UNIQUE,       -- linked to Enrollments
    grade CHAR(2) CHECK (grade IN ('A','B','C','D','F','I','W')), -- allowed values
    CONSTRAINT fk_grade_enrollment FOREIGN KEY (enrollment_id)
        REFERENCES Enrollments(enrollment_id) ON DELETE CASCADE
);

-- ===================================================
-- INSERT DATA: Departments
-- ===================================================
INSERT INTO Departments (dept_name) VALUES 
('Computer Science'),
('Mathematics'),
('Physics'),
('Biology'),
('Business'),
('History');

-- ===================================================
-- INSERT DATA: Students (30 sample students)
-- ===================================================
INSERT INTO Students (first_name, last_name, dob, gender, email, phone, dept_id) VALUES
('David', 'Rodriguez', '1995-08-03', 'Female', 'david.rodriguez1@example.com', '+254742831574', 5),
('James', 'Thomas', '1995-09-19', 'Other', 'james.thomas2@example.com', '+254774049502', 3),
('Thomas', 'Williams', '2000-08-17', 'Male', 'thomas.williams3@example.com', '+254787850237', 3),
('James', 'Johnson', '1998-10-05', 'Male', 'james.johnson4@example.com', '+254729434707', 5),
('Sarah', 'Brown', '2001-02-11', 'Female', 'sarah.brown5@example.com', '+254768917403', 6),
('Michael', 'Davis', '1999-03-28', 'Other', 'michael.davis6@example.com', '+254716538912', 2),
('Elizabeth', 'Lopez', '1996-11-25', 'Female', 'elizabeth.lopez7@example.com', '+254722694731', 1),
('Charles', 'Miller', '2004-06-08', 'Male', 'charles.miller8@example.com', '+254745139820', 4),
('Robert', 'Smith', '1997-12-14', 'Female', 'robert.smith9@example.com', '+254730582419', 5),
('Linda', 'Martinez', '2003-04-09', 'Female', 'linda.martinez10@example.com', '+254765092834', 2),
('William', 'Wilson', '2002-05-22', 'Male', 'william.wilson11@example.com', '+254739284017', 1),
('Patricia', 'Taylor', '1999-07-11', 'Female', 'patricia.taylor12@example.com', '+254728930461', 3),
('Joseph', 'Anderson', '1996-01-13', 'Male', 'joseph.anderson13@example.com', '+254751349028', 6),
('Barbara', 'Jackson', '2001-09-24', 'Female', 'barbara.jackson14@example.com', '+254763028417', 4),
('Richard', 'Martin', '1997-10-18', 'Other', 'richard.martin15@example.com', '+254770583914', 2),
('Jessica', 'Gonzalez', '2000-02-26', 'Female', 'jessica.gonzalez16@example.com', '+254780194735', 5),
('Karen', 'Moore', '1998-03-30', 'Female', 'karen.moore17@example.com', '+254799048273', 1),
('Charles', 'Hernandez', '2002-12-12', 'Male', 'charles.hernandez18@example.com', '+254741290583', 3),
('Robert', 'Garcia', '2004-01-25', 'Male', 'robert.garcia19@example.com', '+254712903854', 6),
('Thomas', 'Taylor', '1999-08-14', 'Female', 'thomas.taylor20@example.com', '+254769382045', 2),
('Mary', 'Williams', '2000-09-07', 'Female', 'mary.williams21@example.com', '+254776583920', 4),
('David', 'Wilson', '1995-04-20', 'Male', 'david.wilson22@example.com', '+254755049283', 1),
('Linda', 'Anderson', '1998-11-29', 'Female', 'linda.anderson23@example.com', '+254798103948', 6),
('William', 'Lopez', '2003-07-03', 'Other', 'william.lopez24@example.com', '+254723948172', 5),
('Jessica', 'Brown', '2002-02-14', 'Female', 'jessica.brown25@example.com', '+254782901374', 3),
('Michael', 'Johnson', '1996-05-06', 'Male', 'michael.johnson26@example.com', '+254711938475', 2),
('Patricia', 'Martinez', '1997-06-16', 'Female', 'patricia.martinez27@example.com', '+254729847130', 4),
('Richard', 'Davis', '2001-03-21', 'Male', 'richard.davis28@example.com', '+254732901745', 1),
('Karen', 'Smith', '1999-12-02', 'Other', 'karen.smith29@example.com', '+254748209374', 6),
('Joseph', 'Moore', '2004-05-18', 'Male', 'joseph.moore30@example.com', '+254775029384', 5);

-- ===================================================
-- INSERT DATA: Instructors (10 sample instructors)
-- ===================================================
INSERT INTO Instructors (first_name, last_name, email, hire_date, dept_id) VALUES
('Mary', 'Anderson', 'mary.andersoni1@example.com', '2008-09-15', 2),
('John', 'Taylor', 'john.taylori2@example.com', '2012-06-21', 1),
('Jessica', 'Johnson', 'jessica.johnsoni3@example.com', '2015-11-03', 5),
('Michael', 'Garcia', 'michael.garciai4@example.com', '2004-03-28', 3),
('Patricia', 'Smith', 'patricia.smithi5@example.com', '2018-07-17', 4),
('Robert', 'Davis', 'robert.davisi6@example.com', '2007-10-11', 6),
('Sarah', 'Miller', 'sarah.milleri7@example.com', '2016-01-22', 1),
('Thomas', 'Wilson', 'thomas.wilsoni8@example.com', '2010-05-09', 2),
('Elizabeth', 'Moore', 'elizabeth.moorei9@example.com', '2013-03-19', 3),
('David', 'Brown', 'david.browni10@example.com', '2009-12-27', 5);

-- ===================================================
-- INSERT DATA: Courses (10 sample courses)
-- ===================================================
INSERT INTO Courses (course_code, course_name, credits, dept_id, instructor_id) VALUES
('CSE001', 'Introduction to Programming', 3, 1, 2),
('MAT101', 'Calculus I', 4, 2, 1),
('PHY201', 'General Physics', 3, 3, 4),
('BIO110', 'Biology Basics', 4, 4, 5),
('BUS210', 'Principles of Management', 3, 5, 3),
('HIS101', 'World History', 2, 6, 6),
('CSE102', 'Data Structures', 4, 1, 7),
('MAT202', 'Linear Algebra', 3, 2, 8),
('PHY310', 'Quantum Mechanics', 5, 3, 9),
('BUS305', 'Business Finance', 4, 5, 10);

-- ===================================================
-- ===================================================
