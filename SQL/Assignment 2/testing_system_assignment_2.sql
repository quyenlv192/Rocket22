DROP DATABASE IF EXISTS testing_system_assignment_2;
CREATE DATABASE IF NOT EXISTS testing_system_assignment_2;
USE testing_system_assignment_2;

DROP TABLE IF EXISTS Department;
CREATE TABLE IF NOT EXISTS Department (
    DepartmentID TINYINT NOT NULL AUTO_INCREMENT,
    DepartmentName VARCHAR(50),
    PRIMARY KEY (DepartmentID)
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE IF NOT EXISTS `Position` (
    PositionID TINYINT NOT NULL AUTO_INCREMENT,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM'),
    PRIMARY KEY (PositionID)
);

DROP TABLE IF EXISTS Account;
CREATE TABLE IF NOT EXISTS Account (
    AccountID TINYINT NOT NULL AUTO_INCREMENT,
    Email VARCHAR(255),
    Username VARCHAR(255),
    FullName VARCHAR(255),
    DepartmentID TINYINT NOT NULL,
    PositionID TINYINT NOT NULL,
    CreateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (AccountID),
    FOREIGN KEY (DepartmentID)
        REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID)
        REFERENCES `Position` (PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS `Group` (
    GroupID TINYINT NOT NULL AUTO_INCREMENT,
    GroupName VARCHAR(255),
    CreatorID TINYINT,
    CreateDate DATE,
    PRIMARY KEY (GroupID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE IF NOT EXISTS GroupAccount (
    GroupID TINYINT NOT NULL,
    AccountID TINYINT NOT NULL,
    JoinDate DATE,
    FOREIGN KEY (GroupID)
        REFERENCES `Group` (GroupID)
        ON DELETE CASCADE,
    FOREIGN KEY (AccountID)
        REFERENCES Account (AccountID)
        ON DELETE CASCADE
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE IF NOT EXISTS TypeQuestion (
    TypeID TINYINT NOT NULL AUTO_INCREMENT,
    TypeName ENUM('Essay', 'Multiple-Choice'),
    PRIMARY KEY (TypeID)
);

DROP TABLE IF EXISTS categoryQuestion;
CREATE TABLE IF NOT EXISTS categoryQuestion (
    CategoryID TINYINT NOT NULL AUTO_INCREMENT,
    CategoryName ENUM('Java', '.Net', 'SQL', 'Postman', 'Ruby'),
    PRIMARY KEY (CategoryID)
);

DROP TABLE IF EXISTS Question;
CREATE TABLE IF NOT EXISTS Question (
    QuestionID TINYINT NOT NULL AUTO_INCREMENT,
    Content VARCHAR(255),
    CategoryID TINYINT NOT NULL,
    TypeID TINYINT NOT NULL,
    CreatorID TINYINT,
    CreateDate DATE,
    PRIMARY KEY (QuestionID),
    FOREIGN KEY (CategoryID)
        REFERENCES categoryQuestion (CategoryID),
    FOREIGN KEY (TypeID)
        REFERENCES TypeQuestion (TypeID)
);

DROP TABLE IF EXISTS answer;
CREATE TABLE IF NOT EXISTS answer (
    AnswerID TINYINT NOT NULL AUTO_INCREMENT,
    Content VARCHAR(255),
    QuestionID TINYINT NOT NULL,
    isCorrect BOOLEAN,
    PRIMARY KEY (AnswerID),
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE IF NOT EXISTS Exam (
    ExamID TINYINT NOT NULL AUTO_INCREMENT,
    `Code` CHAR(10),
    Title VARCHAR(150),
    CategoryID TINYINT NOT NULL,
    Duration TINYINT,
    CHECK (Duration >= 45 AND Duration <= 60),
    CreatorID TINYINT,
    CreateDate DATE,
    PRIMARY KEY (ExamID),
    FOREIGN KEY (CategoryID)
        REFERENCES categoryQuestion (CategoryID)
);

DROP TABLE IF EXISTS examquestion;
CREATE TABLE IF NOT EXISTS ExamQuestion (
    ExamID TINYINT NOT NULL,
    QuestionID TINYINT NOT NULL,
    FOREIGN KEY (ExamID)
        REFERENCES Exam (ExamID),
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID)
); 

-- add data Department
INSERT INTO department (DepartmentName) VALUES ('Marketing');
INSERT INTO department (DepartmentName) VALUES ('Sales');
INSERT INTO department (DepartmentName) VALUES ('Bảo vệ');
INSERT INTO department (DepartmentName) VALUES ('Nhân sự');
INSERT INTO department (DepartmentName) VALUES ('Kỹ thuật');
INSERT INTO department (DepartmentName) VALUES ('Mentor');
INSERT INTO department (DepartmentName) VALUES ('Giám đốc');
INSERT INTO department (DepartmentName) VALUES ('Phó giám đốc');
INSERT INTO department (DepartmentName) VALUES ('Thư kí');
INSERT INTO department (DepartmentName) VALUES ('Bán hàng');

-- add data Position
INSERT INTO Position (PositionName) VALUES ('Dev');
INSERT INTO Position (PositionName) VALUES ('Scrum Master');
INSERT INTO Position (PositionName) VALUES ('PM');
INSERT INTO Position (PositionName) VALUES ('Test');
INSERT INTO Position (PositionName) VALUES ('Dev');
INSERT INTO Position (PositionName) VALUES ('Scrum Master');
INSERT INTO Position (PositionName) VALUES ('PM');
INSERT INTO Position (PositionName) VALUES ('Test');
INSERT INTO Position (PositionName) VALUES ('Dev');
INSERT INTO Position (PositionName) VALUES ('Scrum Master');
INSERT INTO Position (PositionName) VALUES ('PM');
INSERT INTO Position (PositionName) VALUES ('Test');

-- add data Account
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('quyen@gmail.com','quyenlv','Luu Van Quyen',1,2);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('cheese@gmail.com','cheese216','Pham Cheese',2,3);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('vanquyen@gmail.com','vq192','Quyen Luu',3,5);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('mom@gmail.com','mom71','Nguyen Thi Mom',4,3);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('dad@gmail.com','dad71','Luu Dad',3,1);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('bugatti@gmail.com','bugatticar','Bugatti France',2,7);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('veyron@gmail.com','veyron16.4','Bugatti Veyron',6,6);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('chiron@gmail.com','chironSupersport','Bugatti Chiron',7,9);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('bolide@gmail.com','bolideSuper','Bugatti Bolide',8,11);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('divo@gmail.com','divo5','Bugatti Divo',4,12);
INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID) VALUES ('supersport@gmail.com','supersport300','Bugatti Supersport 300',10,1);

-- add data Group 
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket22',1,'2001-02-19');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket23',2,'2001-06-21');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket24',4,'2019-01-02');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket25',5,'1971-03-14');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket26',3,'1920-04-05');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket27',6,'2010-10-10');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket28',8,'2021-05-24');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket29',4,'2021-06-21');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket30',2,'2021-02-02');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket31',3,'2019-06-26');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket32',4,'2022-03-03');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket33',1,'2000-02-20');
INSERT INTO `Group`(GroupName, CreatorID, CreateDate) VALUES ('rocket34',1,'1999-02-02');

-- add data GroupAccount

INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (1, 2, '2001-02-19');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (2, 5, '2001-06-21');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (4, 8, '2019-05-01');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (1, 7, '2010-01-01');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (6, 1, '2020-05-28');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (9, 10, '2021-07-20');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (10, 6, '2011-06-09');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (8, 2, '1991-09-21');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (7, 2, '1961-08-11');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (9, 4, '1976-09-02');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (5, 3, '1977-11-29');
INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (3, 9, '2015-12-12');


-- add data TypeQuestion

INSERT INTO typequestion (TypeName) VALUES ('Multiple-Choice');
INSERT INTO typequestion (TypeName) VALUES ('Essay');
INSERT INTO typequestion (TypeName) VALUES ('Multiple-Choice');
INSERT INTO typequestion (TypeName) VALUES ('Essay');
INSERT INTO typequestion (TypeName) VALUES ('Essay');
INSERT INTO typequestion (TypeName) VALUES ('Multiple-Choice');
INSERT INTO typequestion (TypeName) VALUES ('Multiple-Choice');
INSERT INTO typequestion (TypeName) VALUES ('Essay');
INSERT INTO typequestion (TypeName) VALUES ('Multiple-Choice');
INSERT INTO typequestion (TypeName) VALUES ('Essay');
INSERT INTO typequestion (TypeName) VALUES ('Multiple-Choice');
INSERT INTO typequestion (TypeName) VALUES ('Multiple-Choice');
INSERT INTO typequestion (TypeName) VALUES ('Essay');

-- add data CategoryQuestion
INSERT INTO categoryquestion (CategoryName) VALUES ('Java');
INSERT INTO categoryquestion (CategoryName) VALUES ('.Net');
INSERT INTO categoryquestion (CategoryName) VALUES ('Postman');
INSERT INTO categoryquestion (CategoryName) VALUES ('SQL');
INSERT INTO categoryquestion (CategoryName) VALUES ('Ruby');
INSERT INTO categoryquestion (CategoryName) VALUES ('Java');
INSERT INTO categoryquestion (CategoryName) VALUES ('.Net');
INSERT INTO categoryquestion (CategoryName) VALUES ('Postman');
INSERT INTO categoryquestion (CategoryName) VALUES ('SQL');
INSERT INTO categoryquestion (CategoryName) VALUES ('Ruby');
INSERT INTO categoryquestion (CategoryName) VALUES ('Java');
INSERT INTO categoryquestion (CategoryName) VALUES ('.Net');
INSERT INTO categoryquestion (CategoryName) VALUES ('Postman');

-- add data Question

INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket22',1, 2, 4, '2001-02-19');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket23',2, 3, 1, '2001-06-21');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket24',4, 6, 8, '2019-01-02');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket25',5, 2, 3, '1971-03-14');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket26',3, 1, 5, '1920-04-05');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket27',6, 9, 2, '2010-10-10');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket28',8, 5, 4, '2021-05-24');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket29',4, 3, 1, '2021-06-21');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket30',2, 7, 1, '2021-02-02');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket31',3, 9, 5, '2019-06-26');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket32',4, 4, 6, '2022-03-03');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket33',1, 7, 8, '2000-02-20');
INSERT INTO question(Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES ('rocket34',1, 9, 4, '1999-02-02');

-- add data Answer
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('quyenluu', 4, TRUE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('qlv192', 7, TRUE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('vq123', 1, FALSE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('chi216', 6, FALSE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('cheese201', 8, TRUE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('quyen2001', 10, TRUE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('phamchi201', 1, FALSE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('c216', 9, TRUE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('qc2001', 5, TRUE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('veyron', 3, FALSE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('babi216', 2, FALSE);
INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('congchua216', 2, TRUE);

-- add data Exam 

INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A01', 'Midterm', 1, 45, 2, '2001-02-19');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A02', 'Test', 2, 50, 5, '1997-06-19');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A03', 'Final', 6, 52, 8, '1991-12-20');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A04', 'Oral', 3, 55, 7, '1988-10-06');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A05', 'Writing', 5, 60, 9, '2003-11-17');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A07', 'Reading', 10, 45, 1, '1971-07-19');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A08', 'Listening', 4, 60, 3, '1999-06-16');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A09', 'Interview', 10, 45, 2, '2001-06-21');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A10', 'Interview', 5, 45, 8, '2030-08-18');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A11', 'Review', 3, 45, 2, '2021-02-19');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A12', 'Speaking', 9, 50, 7, '2020-10-19');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A13', 'Final', 2, 51, 9, '2010-05-11');
INSERT INTO exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES ('A14', 'Midterm', 6, 47, 10, '2019-03-15');

-- add data ExamQuestion
INSERT INTO examquestion (ExamID, QuestionID) VALUES (1, 1);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (10, 8);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (11, 7);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (8, 2);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (9, 5);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (5, 6);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (5, 4);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (6, 10);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (4, 8);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (9, 4);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (7, 5);
INSERT INTO examquestion (ExamID, QuestionID) VALUES (9, 1);









