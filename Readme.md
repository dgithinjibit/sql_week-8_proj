**Ed-Tech Platform Database Schema**

Project Objective
This project provides a foundational database schema for a modern ed-tech platform. The design prioritizes scalability, data integrity, and a clear representation of the core business logic: managing the relationships between students, instructors, and course content.

The schema is built to support a range of functionalities, including course enrollment, progress tracking, and assignment management, providing a robust backend for a future-proof application.

Database Design Philosophy
The design adheres to the principles of database normalization, specifically targeting Third Normal Form (3NF) to minimize data redundancy and prevent anomalies. Key design decisions include:

*Primary Keys*: Each table has a unique primary key to ensure every record can be uniquely identified.

*Foreign Keys*: Relationships are enforced using foreign keys, guaranteeing referential integrity and preventing orphaned records.

*Junction Tables*: A many-to-many relationship between students and courses is handled via the Enrollments table. Similarly, the relationship between students and assignments is managed by the Submissions table. This approach is fundamental to a clean, scalable design.

**Schema Overview**
The database is composed of the following tables:

*Users*: A unified table for both students and instructors, ensuring a single source of truth for user data.

*Instructors*: Holds role-specific information for instructors.

*Students*: Holds role-specific information for students.

*Courses*: The core content entity, linked to a specific Instructor.

*Enrollments*: A junction table linking Students to Courses, tracking EnrollmentDate and Progress.

*Lessons*: Structures the content within a Course, now designed to support various content types.

Assignments: Manages coursework for a Course.

*Submissions*: A junction table linking Students to Assignments, tracking submission details and grades.

**Technical Stack**
Database: MySQL

Setup and Usage
To set up this database locally, follow these steps:

Prerequisites
Ensure you have a MySQL server running on your machine. You can install it from mysql.com. A client like MySQL Workbench, DBeaver, or the command-line client is also required.

Get the SQL File
Locate the answers.sql file provided in this repository.

Execute the Script
Using MySQL Workbench:
Open MySQL Workbench and connect to your local server.

Click File -> Open SQL Script and navigate to the answers.sql file.

With the script open, click the lightning bolt icon (Execute) to run the entire script.

**Using Command Line**:
Open your terminal or command prompt.

Navigate to the directory containing the answers.sql file.

Run the following command, replacing [username] with your MySQL username (you will be prompted for your password):

mysql -u [username] -p < answers.sql

**Verification**
The script will create the ed_tech_db database and all its tables. You can verify this in your MySQL client by checking the Schemas panel for the new database and expanding it to see the list of tables (e.g., Instructors, Students, Courses, etc.).

The database is now ready for your application to connect to it.
