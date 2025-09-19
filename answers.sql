-- Drop the database if it exists to ensure a clean start.
-- A professional move for local development and clean-slate thinking.
DROP DATABASE IF EXISTS ed_tech_db;
CREATE DATABASE ed_tech_db;
USE ed_tech_db;

-- 1. Instructors Table
-- The core entity for content creation. An instructor is a person.
-- We keep `Email` unique for account integrity.
-- This is a solid starting point for building out user management roles.
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Bio TEXT
);

-- 2. Students Table
-- The other core user entity. A student is also a person.
-- Unique `Email` ensures each user has a single account.
-- `JoinDate` is a key metric for user engagement analytics.
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    JoinDate DATE NOT NULL
);

-- 3. Courses Table
-- The main product of the platform. Each course has a unique ID.
-- This table has a one-to-many relationship with `Instructors`
-- because one instructor can create many courses.
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    InstructorID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- 4. Enrollments Table
-- This is the junction table that handles the many-to-many relationship between
-- `Students` and `Courses`. A student can enroll in many courses, and a
-- course can have many students. This is the most critical link.
-- `EnrollmentDate` tracks when a student joined a course, and `Progress`
-- is a crucial metric for tracking user activity.
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Progress DECIMAL(5, 2) DEFAULT 0.00, -- Tracks completion percentage
    UNIQUE (StudentID, CourseID), -- Prevents a student from enrolling in the same course twice
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 5. Lessons Table
-- This table is for structuring content within a course. It has a one-to-many
-- relationship with `Courses` because a course has many lessons.
-- `LessonNumber` is useful for maintaining a logical flow.
CREATE TABLE Lessons (
    LessonID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    LessonNumber INT NOT NULL,
    Content TEXT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 6. Assignments Table
-- This table is for managing coursework. It has a one-to-many relationship with
-- `Courses`, as each course can have multiple assignments.
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    DueDate DATE NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 7. Submissions Table
-- The junction table for the many-to-many relationship between `Students` and `Assignments`.
-- A student can submit many assignments, and an assignment will have many submissions.
-- This table tracks the student's submission and their grade.
CREATE TABLE Submissions (
    SubmissionID INT PRIMARY KEY AUTO_INCREMENT,
    AssignmentID INT NOT NULL,
    StudentID INT NOT NULL,
    SubmissionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    SubmissionContent TEXT,
    Grade DECIMAL(5, 2),
    UNIQUE (AssignmentID, StudentID), -- A student can only submit an assignment once
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
