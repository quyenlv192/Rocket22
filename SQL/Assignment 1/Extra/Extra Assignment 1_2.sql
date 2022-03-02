create database fresher_training_management;
use fresher_training_management;

-- Exercise 1: Design a table
CREATE TABLE Trainee (
    TraineeID INT NOT NULL AUTO_INCREMENT,
    Full_Name VARCHAR(255),
    Birth_Date DATE,
    Gender ENUM('male', 'female', 'unknown'),
    ET_IQ INT,
    ET_Gmath INT,
    ET_English INT,
    Training_Class CHAR(50),
    Evaluation_Notes VARCHAR(255),
    PRIMARY KEY (TraineeID)
);

	alter table trainee 
	add VTI_Account varchar(255) not null;

	alter table trainee
	add unique (VTI_Account);

-- Exercise 2: Data type
/*
  ID tinyint not null auto_increment,
  Name varchar(150)
  Code char(5),
  ModifiedDate timestamp default current_timestamp,
  primary key(ID)
*/

-- Exercise 3: Data type(2)
/*
  ID tinyint not null auto_increment,
  Name nvarchar(150),
  BirthDate date,
  Gender enum('male', 'female', 'unknown'),
  isDeletedFlag boolean,
  primary key (ID)
*/

