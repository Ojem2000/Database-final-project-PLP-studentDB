# Student Records Management System (MySQL)

## Overview
This project implements a **Relational Database Management System (RDBMS)** for managing student records using **MySQL**.  
It includes tables for **Departments, Students, Instructors, Courses, Enrollments, and Grades** with proper relationships and constraints.

The database demonstrates:
- ✅ One-to-Many (Department → Students, Department → Instructors, Department → Courses)  
- ✅ Many-to-Many (Students ↔ Courses via Enrollments)  
- ✅ One-to-One (Enrollments ↔ Grades)  

---

## Database Schema
- **Departments** – Stores department names  
- **Students** – Stores student details (30 sample students)  
- **Instructors** – Stores instructor details (10 sample instructors)  
- **Courses** – Stores course details (10 sample courses)  
- **Enrollments** – Links students to courses per semester/year  
- **Grades** – Stores grades for each enrollment  

---

## Setup Instructions

### 1. Clone Repository
```bash
git clone https://github.com/your-username/student-records-db.git
cd student-records-db
