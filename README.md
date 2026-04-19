# StudentGrade-ManagementSystem
A CLI menu-based Bash application that manages students, subjects, and grades.

# Features 
- Students
  - Add Student
  - List Students
  - Update Student
  - Delete Student
 
- Subjects
  - Add Subject
  - List Subjects
  - Update Subject
  - Delete Subject

- Grades
  - Assign Grade
  - Update Grade
  - Delete Grade
  - View Grades by Student
  - View Grades by Subject

- Reports
  - Student GPA
  - Subject Statistics
  - Top Students
  - Failing Students
  - Full Grade Matrix
 
# How to Run
chmod +x sgms.sh
./sgms.sh

# Team Work Split

# Mohamed Khaled — Main Menu · Student Management · Reports & Statistics
- Main Menu (MainMenu.sh)

- Student Management (StudentManagement.sh)
  - Add, list, update, and delete students
  - Validate Student ID, name, email, and academic year
  - Manage student records in data/students/

- Reports & Statistics (Reports&Statistics.sh)
  - Student Transcript + GPA calculation
  - Subject statistics (averages, distributions)
  - Top students by GPA report
  - Failing students report
  - Full grade matrix view
  - Manage output in data/reports&statistics/

# Omar Wael — Subject Management · Grade Management
- Subject Management (SubjectManagement.sh)
  - Add, list, update, and delete subjects
  - Validate subject code format and credit hours
  - Manage subject records in data/subjects/


- Grade Management (GradeManagement.sh)
  - Assign, update, and delete grades
  - View grades by subject or by student
  - Validate score range and compute letter grades
  - Manage grade records in data/grades/
