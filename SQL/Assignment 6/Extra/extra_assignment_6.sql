drop database if exists extra_assignment_6;
create database if not exists extra_assignment_6;
use extra_assignment_6;
DROP TABLE IF EXISTS Projects;
CREATE TABLE IF NOT EXISTS Projects (
    ProjectID TINYINT NOT NULL AUTO_INCREMENT,
    managerID TINYINT,
    ProjectName VARCHAR(255),
    ProjectStartDate DATE,
    ProjectDescription VARCHAR(255),
    ProjectDetail VARCHAR(255),
    ProjectCompletedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ProjectID)
);
DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee (
    EmployeeID TINYINT NOT NULL AUTO_INCREMENT,
    EmployeeLastName VARCHAR(255),
    EmployeeFirstName VARCHAR(255),
    EmployeeHireDate DATE,
    EmployeeStatus VARCHAR(255),
    SupervisorID TINYINT,
    SocialSecurityNumber INT,
    PRIMARY KEY (EmployeeID)
);
DROP TABLE IF EXISTS Project_Modules;
CREATE TABLE IF NOT EXISTS Project_Modules (
    ModuleID TINYINT NOT NULL AUTO_INCREMENT,
    ProjectID TINYINT,
    EmployeeID TINYINT,
    ProjectModulesDate DATE,
    ProjectModulesCompletedON DATE,
    ProjectModulesDescription VARCHAR(255),
    PRIMARY KEY (ModuleID),
    FOREIGN KEY (ProjectID)
        REFERENCES Projects (ProjectID),
    FOREIGN KEY (EmployeeID)
        REFERENCES Employee (EmployeeID)
);
DROP TABLE IF EXISTS Work_Done;
CREATE TABLE IF NOT EXISTS Work_Done (
    WorkDoneID TINYINT NOT NULL AUTO_INCREMENT,
    EmployeeID TINYINT,
    ModuleID TINYINT,
    WorkDoneDate DATE,
    WorkDoneDescription VARCHAR(255),
    WorkDoneStatus VARCHAR(255),
    PRIMARY KEY (WorkDoneID),
    FOREIGN KEY (EmployeeID)
        REFERENCES Employee (EmployeeID),
    FOREIGN KEY (ModuleID)
        REFERENCES Project_Modules (ModuleID)
);

-- b)
DROP PROCEDURE IF EXISTS remove_project_info_after_3_month;

DELIMITER &&
CREATE PROCEDURE remove_project_info_after_3_month ()
BEGIN 	
	DELETE FROM Projects 
WHERE
    MONTH(ProjectCompletedOn) = (MONTH(ProjectStartDate) + 3);
END &&
DELIMITER ;

-- c) truyền module lấy 
DROP PROCEDURE IF EXISTS print_project_not_complete;
CREATE PROCEDURE print_project_not_complete(in project_id tinyint ) 
BEGIN 





-- print 
signal sqlstate '45000' set message_text = concat('So luong ban da remove tu project la ', countRemove);

