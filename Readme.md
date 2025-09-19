**Ed-Tech Platform Database Schema**

Project Objective
This project provides a foundational database schema for a modern ed-tech platform. The design prioritizes scalability, data integrity, and a clear representation of the core business logic: managing the relationships between students, instructors, and course content.

The schema is built to support a range of functionalities, including course enrollment, progress tracking, and assignment management, providing a robust backend for a future-proof application.

Database Design Philosophy
The design adheres to the principles of database normalization, specifically targeting Third Normal Form (3NF) to minimize data redundancy and prevent anomalies. Key design decisions include:

Primary Keys: Each table has a unique primary key to ensure every record can be uniquely identified.

Foreign Keys: Relationships are enforced using foreign keys, guaranteeing referential integrity and preventing orphaned records.

Junction Tables: A many-to-many relationship between students and courses is handled via the Enrollments table. Similarly, the relationship between students and assignments is managed by the Submissions table. This approach is fundamental to a clean, scalable design.

Schema Overview
The database is composed of the following tables:

Instructors: Stores information about the content creators.

Students: Stores information about the learners.

Courses: The core content entity, linked to a specific Instructor.

Enrollments: A junction table linking Students to Courses, tracking EnrollmentDate and Progress.

Lessons: Structures the content within a Course.

Assignments: Manages coursework for a Course.

Submissions: A junction table linking Students to Assignments, tracking submission details and grades.

Technical Stack
Database: MySQL

Setup and Usage
To set up this database, follow these steps:

Ensure you have a MySQL server and client (like MySQL Workbench) installed.

Open the answers.sql file provided in this repository.

Execute the entire script. This will drop the database if it already exists, create a new one named ed_tech_db, and then create all the necessary tables with their respective constraints.

The database is now ready for use by your application.

Potential Future Enhancements
Add a Reviews table to allow students to leave feedback on Courses.

Implement a user authentication system, possibly integrating with a separate Users table that links to both Instructors and Students.

Expand the Lessons table to include a variety of content types (e.g., video URLs, quizzes).
