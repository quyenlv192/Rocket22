create database testing_system_assignment_1;
use testing_system_assignment_1;

CREATE TABLE Department (
    DepartmentID INT NOT NULL AUTO_INCREMENT,
    DepartmentName VARCHAR(50),
    PRIMARY KEY (DepartmentID)
);

CREATE TABLE Position (
    PositionID INT NOT NULL AUTO_INCREMENT,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM'),
    PRIMARY KEY (PositionID)
);

CREATE TABLE Account (
    AccountID INT NOT NULL AUTO_INCREMENT,
    Email VARCHAR(255),
    Username VARCHAR(255),
    FullName VARCHAR(255),
    DepartmentID INT NOT NULL,
    PositionID INT NOT NULL,
    CreateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (AccountID)
);

CREATE TABLE `Group` (
    GroupID INT NOT NULL AUTO_INCREMENT,
    GroupName VARCHAR(100),
    CreatorID INT NOT NULL,
    CreateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (GroupID)
);

CREATE TABLE GroupAccount (
    GroupID INT NOT NULL AUTO_INCREMENT,
    AccountID INT NOT NULL,
    JoinDate DATETIME,
    CONSTRAINT PK_GroupAcount PRIMARY KEY (GroupID , AccountID)
);

CREATE TABLE TypeQuestion (
    TypeID INT NOT NULL AUTO_INCREMENT,
    TypeName ENUM('Essay', 'Multiple-Choice'),
    PRIMARY KEY (TypeID)
);

CREATE TABLE categoryQuestion (
    CategoryID INT NOT NULL AUTO_INCREMENT,
    CategoryName ENUM('Java', '.Net', 'SQL', 'Postman', 'Ruby'),
    PRIMARY KEY (CategoryID)
);

CREATE TABLE Question (
    QuestionID INT NOT NULL AUTO_INCREMENT,
    Content VARCHAR(255),
    CategoryID INT NOT NULL,
    TypeID INT NOT NULL,
    CreatorID INT NOT NULL,
    CreateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Question PRIMARY KEY (QuestionID , CategoryID , TypeID , CreatorID)
);

CREATE TABLE answer (
    AnswerID INT NOT NULL AUTO_INCREMENT,
    Content VARCHAR(255),
    QuestionID INT NOT NULL,
    isCorrect BOOLEAN,
    CONSTRAINT answer_pk PRIMARY KEY (AnswerID , QuestionID)
);

CREATE TABLE Exam (
    ExamID INT NOT NULL AUTO_INCREMENT,
    Code CHAR(10),
    Title VARCHAR(150),
    CategoryID INT NOT NULL,
    Duration VARCHAR(100),
    CreatorID INT NOT NULL,
    CreateDate DATETIME,
    CONSTRAINT exam_pk PRIMARY KEY (ExamID , CategoryID , CreatorID)
);

CREATE TABLE ExamQuestion (
    ExamID INT NOT NULL,
    QuestionID INT NOT NULL,
    CONSTRAINT exam_question_pk PRIMARY KEY (ExamID , QuestionID)
); 


