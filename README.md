🎵 Elf School of Music and Performing Arts Database

📖 Project Overview

This project implements a relational database schema for the Elf School of Music and Performing Arts. The schema is designed to manage:

Music departments (e.g., Strings, Choir, Percussion).

Teachers and the classes they instruct.

Students and their profiles.

Enrollment records (students taking multiple classes).


The database is normalized and demonstrates One-to-One, One-to-Many, and Many-to-Many relationships with proper constraints.


---

📂 Files Included

elf_school.sql → Contains the full database schema (CREATE DATABASE, CREATE TABLE statements, constraints).



---

🏗️ Database Schema

1. MusicDepartment

Represents the school’s departments (e.g., Strings, Choir, Percussion).

CREATE TABLE MusicDepartment (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

department_id: Unique identifier.

name: Department name (unique).


Relationships:

One-to-Many with Teacher.

One-to-Many with Class.



---

2. Teacher

Holds teacher information. Each teacher belongs to one department.

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES MusicDepartment(department_id)
        ON DELETE CASCADE
);

teacher_id: Unique identifier.

name: Teacher’s name.

email: Unique email.

department_id: References MusicDepartment.


Relationships:

Many teachers → One department.

One teacher → Many classes.



---

3. Class

Represents a music class taught at the school.

CREATE TABLE Class (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    department_id INT NOT NULL,
    teacher_id INT,
    FOREIGN KEY (department_id) REFERENCES MusicDepartment(department_id)
        ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
        ON DELETE SET NULL
);

class_id: Unique identifier.

title: Class name (e.g., Harp 101).

credits: Credit value.

department_id: References MusicDepartment.

teacher_id: References Teacher.


Relationships:

Many classes → One department.

One class → One teacher.

Many-to-Many with Student (via Enrollment).



---

4. Student

Stores student information.

CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

student_id: Unique identifier.

name: Student name.

email: Unique email.


Relationships:

One-to-One with StudentProfile.

Many-to-Many with Class (via Enrollment).



---

5. StudentProfile

Extra details about students. Each student has one profile.

CREATE TABLE StudentProfile (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT UNIQUE NOT NULL,
    dob DATE NOT NULL,
    main_instrument VARCHAR(100),
    address VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE
);

profile_id: Unique identifier.

student_id: References Student (unique).

dob: Date of birth.

main_instrument: Primary instrument played.

address: Contact address.


Relationships:

One-to-One with Student.



---

6. Enrollment

Junction table for the many-to-many relationship between students and classes.

CREATE TABLE Enrollment (
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, class_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
        ON DELETE CASCADE
);

student_id: References Student.

class_id: References Class.

enrollment_date: When the student enrolled.


Relationships:

Many students ↔ Many classes.



---

🔗 Relationships Summary

One-to-One: Student ↔ StudentProfile

One-to-Many: MusicDepartment ↔ Teacher, MusicDepartment ↔ Class

Many-to-Many: Student ↔ Class (via Enrollment)



---

🚀 How to Use

1. Open MySQL Workbench (or any SQL client).


2. Run the script elf_school.sql.


3. The database ElfSchoolDB will be created.


4. Start adding data using INSERT statements (students, teachers, classes, etc.).

