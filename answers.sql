-- Drop the database if it exists to ensure a clean start.
-- A professional move for local development and clean-slate thinking.
DROP DATABASE IF EXISTS ed_tech_db;
CREATE DATABASE ed_tech_db;
USE ed_tech_db;

-- 1. Users Table
-- A single source of truth for all user accounts.
-- This is a key step towards building a robust authentication system.
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL, -- Storing a hash, not the plain password
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    UserType ENUM('student', 'instructor') NOT NULL,
    JoinDate DATE NOT NULL
);

-- 2. Instructors Table
-- Role-specific details for instructors.
-- This table is linked back to the `Users` table.
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    Bio TEXT,
    FOREIGN KEY (InstructorID) REFERENCES Users(UserID)
);

-- 3. Students Table
-- Role-specific details for students.
-- This table is linked back to the `Users` table.
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FOREIGN KEY (StudentID) REFERENCES Users(UserID)
);

-- 4. Courses Table
-- The main product of the platform, with a foreign key to the `Instructors` table.
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    InstructorID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- 5. Enrollments Table
-- The junction table for the many-to-many relationship between `Students` and `Courses`.
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Progress DECIMAL(5, 2) DEFAULT 0.00,
    UNIQUE (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 6. Lessons Table
-- Now includes fields for handling different content types, making the platform more versatile.
CREATE TABLE Lessons (
    LessonID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    LessonNumber INT NOT NULL,
    ContentType ENUM('video', 'text', 'quiz') NOT NULL,
    ContentURL TEXT,
    Content TEXT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 7. Assignments Table
-- Manages coursework for a Course.
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    DueDate DATE NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 8. Submissions Table
-- The junction table for the many-to-many relationship between `Students` and `Assignments`.
CREATE TABLE Submissions (
    SubmissionID INT PRIMARY KEY AUTO_INCREMENT,
    AssignmentID INT NOT NULL,
    StudentID INT NOT NULL,
    SubmissionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    SubmissionContent TEXT,
    Grade DECIMAL(5, 2),
    UNIQUE (AssignmentID, StudentID),
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Indexing for Performance
-- Creating indexes on foreign keys is a critical optimization step for production databases.
CREATE INDEX idx_courses_instructorid ON Courses (InstructorID);
CREATE INDEX idx_enrollments_studentid ON Enrollments (StudentID);
CREATE INDEX idx_enrollments_courseid ON Enrollments (CourseID);
CREATE INDEX idx_lessons_courseid ON Lessons (CourseID);
CREATE INDEX idx_assignments_courseid ON Assignments (CourseID);
CREATE INDEX idx_submissions_assignmentid ON Submissions (AssignmentID);
CREATE INDEX idx_submissions_studentid ON Submissions (StudentID);

-- Sample Data Insertion
-- Let's populate the database with sample data to make it immediately usable.

-- Users
INSERT INTO Users (Email, PasswordHash, FirstName, LastName, UserType, JoinDate) VALUES
('alice@example.com', 'hashed_password_1', 'Alice', 'Smith', 'instructor', '2023-01-10'),
('bob@example.com', 'hashed_password_2', 'Bob', 'Johnson', 'student', '2023-01-15'),
('charlie@example.com', 'hashed_password_3', 'Charlie', 'Brown', 'student', '2023-02-20'),
('david@example.com', 'hashed_password_4', 'David', 'Miller', 'instructor', '2023-03-05');

-- Instructors and Students
INSERT INTO Instructors (InstructorID, Bio) VALUES
(1, 'A seasoned instructor in web development and data science.'),
(4, 'An expert in blockchain and decentralized systems.');

INSERT INTO Students (StudentID) VALUES
(2),
(3);

-- Courses
INSERT INTO Courses (Title, Description, InstructorID) VALUES
('Introduction to Python', 'A beginner-friendly course on Python programming.', 1),
('Web Development with Node.js', 'Learn to build dynamic web applications with Node.js and Express.', 1),
('Blockchain Fundamentals', 'An introduction to the core concepts of blockchain technology.', 4);

-- Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Progress) VALUES
(2, 1, '2023-01-20', 75.50),
(2, 2, '2023-02-01', 25.00),
(3, 1, '2023-02-25', 90.00),
(3, 3, '2023-03-10', 5.00);

-- Lessons
INSERT INTO Lessons (CourseID, Title, LessonNumber, ContentType, ContentURL, Content) VALUES
(1, 'Introduction to Variables', 1, 'video', 'https://example.com/python-lesson-1-video', NULL),
(1, 'Control Flow', 2, 'text', NULL, 'Control flow statements in Python include `if`, `elif`, and `else`.'),
(2, 'Setting up the Server', 1, 'video', 'https://example.com/nodejs-lesson-1-video', NULL),
(3, 'What is a Hash?', 1, 'quiz', NULL, '{"questions": ["What is a hash?", "How are they used in blockchain?"]}');

-- Assignments
INSERT INTO Assignments (CourseID, Title, Description, DueDate) VALUES
(1, 'Python Final Project', 'Build a small command-line application in Python.', '2023-04-15'),
(2, 'API Design', 'Design and implement a RESTful API using Node.js.', '2023-05-01');

-- Submissions
INSERT INTO Submissions (AssignmentID, StudentID, SubmissionContent, Grade) VALUES
(1, 2, 'My Python final project submission.', 95.00),
(1, 3, 'Here is my code for the final project.', 88.00);
