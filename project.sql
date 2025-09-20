-- Create Database
CREATE DATABASE ElfSchoolDB;
USE ElfSchoolDB;

-- Music Departments (e.g., Strings, Percussion, Choir)
CREATE TABLE MusicDepartment (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Teachers (each belongs to a department)
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES MusicDepartment(department_id)
        ON DELETE CASCADE
);

-- Classes (e.g., Harp 101, Elven Choir, Drum Magic)
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

-- Students
CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Student Profiles (extra details, One-to-One with Student)
CREATE TABLE StudentProfile (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT UNIQUE NOT NULL,
    dob DATE NOT NULL,
    main_instrument VARCHAR(100),
    address VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE
);

-- Enrollment (Many-to-Many: Students ↔ Classes)
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
