create database zenClass;

use zenClass;

create table Students(STUDENT_ID INTEGER PRIMARY KEY, STUDENT_NAME VARCHAR(50) NOT NULL, MOBILE VARCHAR(10) UNIQUE NOT NULL, 
	USERNAME VARCHAR(20) UNIQUE NOT NULL, PASSWORD VARCHAR(20) NOT NULL, YEARS_OF_EXPERIENCE INTEGER DEFAULT 0, 
    DEGREE VARCHAR(40) NOT NULL, YEAR_OF_PASSING INTEGER NOT NULL, CGPA FLOAT NOT NULL, COLLEGE_NAME VARCHAR(30) NOT NULL);
    
create table WorkPreferences(PREFERNCE_ID INTEGER PRIMARY KEY, STUDENT_ID INTEGER, PREFERENCE_1 VARCHAR(20), PREFERENCE_2 VARCHAR(20),
	PREFERENCE_3 VARCHAR(20), FOREIGN KEY(STUDENT_ID) REFERENCES Students(STUDENT_ID));
    
create table Roles(ROLE_ID INTEGER PRIMARY KEY, ROLE_NAME VARCHAR(20) NOT NULL UNIQUE);

create table Employees(EMPLOYEE_ID INTEGER PRIMARY KEY, EMPLOYEE_NAME VARCHAR(50) NOT NULL, MOBILE VARCHAR(10) UNIQUE NOT NULL, 
	USERNAME VARCHAR(20) UNIQUE NOT NULL, PASSWORD VARCHAR(20) NOT NULL, YEARS_OF_EXPERIENCE INTEGER DEFAULT 0, SALARY FLOAT NOT NULL, 
    ROLE_ID INTEGER, FOREIGN KEY(ROLE_ID) REFERENCES Roles(ROLE_ID));
    
create table SalaryRecords(RECORD_ID INTEGER PRIMARY KEY, EMPLOYEE_ID INTEGER, AMOUNT FLOAT, 
	CREDITED_DATE_TIME DATETIME default current_timestamp, FOREIGN KEY(EMPLOYEE_ID) REFERENCES Employees(EMPLOYEE_ID));
    
create table EmployeeLeaveRecords(LEAVE_ID INTEGER PRIMARY KEY, EMPLOYEE_ID INTEGER, NO_OF_DAYS INTEGER default 1, FROM_DATE DATE, 
	TO_DATE DATE, REASON TEXT NOT NULL, FOREIGN KEY(EMPLOYEE_ID) REFERENCES Employees(EMPLOYEE_ID));
    
create table Courses(COURSE_ID INTEGER PRIMARY KEY, COURSE_NAME VARCHAR(30) NOT NULL UNIQUE, FEES FLOAT NOT NULL, 
	DURATION_IN_MONTHS INTEGER NOT NULL, SYLLABUS TEXT NOT NULL);
    
create table Batches(BATCH_ID INTEGER PRIMARY KEY, BATCH_NAME VARCHAR(50), COURSE_ID INTEGER, COORDINATOR_ID INTEGER, STUDENT_ID INTEGER, 
	TYPE VARCHAR(10), TIMING VARCHAR(10), FOREIGN KEY(COORDINATOR_ID) REFERENCES Employees(EMPLOYEE_ID), 
    FOREIGN KEY(STUDENT_ID) REFERENCES Students(STUDENT_ID), FOREIGN KEY(COURSE_ID) REFERENCES Courses(COURSE_ID));
    
create table Sessions(SESSION_ID INTEGER PRIMARY KEY, BATCH_ID INTEGER, MEETING_LINK TEXT, PASSWORD VARCHAR(40), SESSION_DATE DATE, 
	SESSION_TIME TIME, MENTOR_ID INTEGER, TITLE VARCHAR(50), DESCRIPTION TEXT, IS_ADDITIONAL BOOLEAN DEFAULT FALSE, FOREIGN KEY(MENTOR_ID) REFERENCES Employees(EMPLOYEE_ID)
    , FOREIGN KEY(BATCH_ID) REFERENCES Batches(BATCH_ID));
    
create table Recordings(RECORDING_ID INTEGER PRIMARY KEY, SESSION_ID INTEGER, LINK VARCHAR(50) NOT NULL, PASSWORD VARCHAR(50) NOT NULL, 
	FOREIGN KEY(SESSION_ID) REFERENCES Sessions(SESSION_ID));
    
CREATE TABLE Task (
    TASK_ID INT AUTO_INCREMENT PRIMARY KEY,
    QUESTION TEXT NOT NULL,
    SESSION_ID INT,
    FOREIGN KEY (SESSION_ID) REFERENCES Sessions(SESSION_ID)
);

CREATE TABLE Queries (
    QUERY_ID INT PRIMARY KEY,
    CATEGORY VARCHAR(100) NOT NULL,
    LANGUAGE VARCHAR(50) NOT NULL,
    TITLE VARCHAR(255) NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    ATTACHMENTS VARCHAR(255) NOT NULL,
    STATUS VARCHAR(20) NOT NULL,
    EMPLOYEE_ID INT,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES Employees(EMPLOYEE_ID)
);

CREATE TABLE Companies (
    COMPANY_ID INT PRIMARY KEY,
    COMPANY_NAME VARCHAR(100) NOT NULL UNIQUE,
    LOCATION VARCHAR(100) NOT NULL,
    TIER INT
);

CREATE TABLE Positions (
    POSITION_ID INT PRIMARY KEY,
    COMPANY_ID INT,
    NAME VARCHAR(100) NOT NULL,
    PACKAGE DECIMAL(10, 2) NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    NO_OF_OPENINGS INT NOT NULL,
    NATURE VARCHAR(50) NOT NULL,
    FOREIGN KEY (COMPANY_ID) REFERENCES Companies(COMPANY_ID)
);

CREATE TABLE AbsenteeRecords (
    ABSENTEE_ID INT PRIMARY KEY,
    STUDENT_ID INT,
    NO_OF_DAYS INT NOT NULL,
    FROM_DATE DATE NOT NULL,
    TO_DATE DATE NOT NULL,
    REASON TEXT NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID)
);

CREATE TABLE Feedbacks(
    FEEDBACK_ID INT PRIMARY KEY,
    SESSION_ID INT,
    STUDENT_ID INT,
    CLASS_FEEDBACK TEXT NOT NULL,
    MENTOR_FEEDBACK TEXT NOT NULL,
    CLASS_RATING FLOAT NOT NULL,
    MENTOR_RATING FLOAT NOT NULL,
    KEY_TAKEAWAYS TEXT NOT NULL,
    FOREIGN KEY (SESSION_ID) REFERENCES Sessions(SESSION_ID),
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID)
);

CREATE TABLE Portfolios (
    PORTFOLIO_ID INT PRIMARY KEY,
    STUDENT_ID INT,
    PORTFOLIO_LINK VARCHAR(255) NOT NULL,
    GITHUB_LINK VARCHAR(255) NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID)
);

CREATE TABLE Projects(
    PROJECT_ID INT PRIMARY KEY,
    STUDENT_ID INT,
    PROJECT_LINK VARCHAR(255) NOT NULL,
    GITHUB_LINK VARCHAR(255) NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID)
);

ALTER TABLE Projects ADD COLUMN MARKS INT default 0;
 
CREATE TABLE MockInterviews (
    MOCK_INTERVIEW_ID INT PRIMARY KEY,
    STUDENT_ID INT,
    EMPLOYEE_ID INT,
    MARKS DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID),
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES Employees(EMPLOYEE_ID)
);

CREATE TABLE Applications (
    APPLICATION_ID INT PRIMARY KEY,
    STUDENT_ID INT,
    POSITION_ID INT,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID),
    FOREIGN KEY (POSITION_ID) REFERENCES Positions(POSITION_ID)
);

CREATE TABLE TaskSubmissions (
    SUBMISSION_ID INT PRIMARY KEY,
    STUDENT_ID INT,
    TASK_ID INT,
    GITHUB_LINK VARCHAR(255) NOT NULL,
    DEPLOY_LINK VARCHAR(255) NOT NULL,
    GRADE DECIMAL(5, 2) NOT NULL,
    EMPLOYEE_ID INT,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID),
    FOREIGN KEY (STUDENT_ID) REFERENCES Employees(EMPLOYEE_ID),
	FOREIGN KEY (TASK_ID) REFERENCES Task(TASK_ID)
);

CREATE TABLE Certifications (
    CERTIFICATION_ID INT AUTO_INCREMENT PRIMARY KEY,
    STUDENT_ID INT,
    CERTIFICATE_URL VARCHAR(100),
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID)
);

CREATE TABLE Testimonials (
    TESTIMONIAL_ID INT AUTO_INCREMENT PRIMARY KEY,
    STUDENT_ID INT,
    PHOTO VARCHAR(255) NOT NULL,
    VIDEO_URL VARCHAR(255) NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID)
);

CREATE TABLE PlacementRecords (
    PLACEMENT_RECORD_ID INT AUTO_INCREMENT PRIMARY KEY,
    STUDENT_ID INT,
    COMPANY_ID INT,
    POSITION_ID INT,
    BATCH_ID INT,
    FOREIGN KEY (STUDENT_ID) REFERENCES Students(STUDENT_ID),
    FOREIGN KEY (COMPANY_ID) REFERENCES Companies(COMPANY_ID),
    FOREIGN KEY (POSITION_ID) REFERENCES Positions(POSITION_ID),
    FOREIGN KEY (BATCH_ID) REFERENCES Batches(BATCH_ID)
);