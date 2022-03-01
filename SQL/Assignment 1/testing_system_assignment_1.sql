create database testing_system_assignment_1;
use testing_system_assignment_1;

CREATE TABLE Department (
    DepartmentID INT NOT NULL AUTO_INCREMENT,
    DepartmentName VARCHAR(50),
    PRIMARY KEY (DepartmentID)
);

CREATE TABLE `Position` (
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
    PRIMARY KEY (AccountID),
    FOREIGN KEY (DepartmentID)
        REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID)
        REFERENCES `Position` (PositionID)
);

CREATE TABLE `Group` (
    GroupID INT NOT NULL AUTO_INCREMENT,
    GroupName VARCHAR(100),
    CreatorID INT NOT NULL,
    CreateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Group PRIMARY KEY (GroupID , CreatorID)
);

CREATE TABLE GroupAccount (
    GroupID INT NOT NULL AUTO_INCREMENT,
    AccountID INT NOT NULL,
    JoinDate DATETIME,
    PRIMARY KEY (GroupID),
    FOREIGN KEY (AccountID)
        REFERENCES Account (AccountID)
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
    PRIMARY KEY (QuestionID),
    FOREIGN KEY (CategoryID)
        REFERENCES categoryQuestion (CategoryID),
    FOREIGN KEY (TypeID)
        REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CreatorID)
        REFERENCES `Group` (CreatorID)
);

CREATE TABLE answer (
    AnswerID INT NOT NULL AUTO_INCREMENT,
    Content VARCHAR(255),
    QuestionID INT NOT NULL,
    isCorrect BOOLEAN,
    PRIMARY KEY (AnswerID),
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID)
);

CREATE TABLE Exam (
    ExamID INT NOT NULL AUTO_INCREMENT,
    Code CHAR(10),
    Title VARCHAR(150),
    CategoryID INT NOT NULL,
    Duration VARCHAR(100),
    CreatorID INT NOT NULL,
    CreateDate DATETIME,
    PRIMARY KEY (ExamID)
);

CREATE TABLE ExamQuestion (
    ExamID INT NOT NULL,
    QuestionID INT NOT NULL,
    PRIMARY KEY (ExamID),
    FOREIGN KEY (CategoryID)
        REFERENCES categoryQuestion (CategoryID),
    FOREIGN KEY (CreatorID)
        REFERENCES `Group` (CreatorID)
); 


