create database fresher_training_management;
use fresher_training_management;

-- Exercise 1: Design a table
CREATE TABLE Trainee (
    TraineeID INT NOT NULL AUTO_INCREMENT,
    Full_Name VARCHAR(255),
    Birth_Date DATE,
    Gender ENUM('male', 'female', 'unknown'),
    ET_IQ INT,
    CHECK (ET_IQ > 0 AND ET_IQ <= 20),
    ET_Gmath INT,
    CHECK (ET_Gmath > 0 AND ET_Gmath <= 20),
    ET_English INT,
    CHECK (ET_English > 0 AND ET_English <= 50),
    Training_Class CHAR(50),
    Evaluation_Notes VARCHAR(255),
    PRIMARY KEY (TraineeID)
);

	ALTER TABLE trainee 
	ADD VTI_Account VARCHAR(255) NOT NULL;

	ALTER TABLE trainee
	ADD UNIQUE KEY (VTI_Account);

-- Exercise 2: Data type
/*
  ID mediumint not null auto_increment,
  Name varchar(150)
  Code char(5),
  ModifiedDate timestamp default current_timestamp,
  primary key(ID)
*/

-- Exercise 3: Data type(2)
/*
  ID mediumint not null auto_increment,
  Name nvarchar(150),
  BirthDate date,
  Gender enum('male', 'female', 'unknown'),
  isDeletedFlag boolean,
  primary key (ID)
*/

