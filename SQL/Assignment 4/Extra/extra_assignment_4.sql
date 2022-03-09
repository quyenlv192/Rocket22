use fresher_training_management;

-- Question 1
drop table if exists Department;
CREATE TABLE IF NOT EXISTS Department (
    Department_Number INT NOT NULL AUTO_INCREMENT,
    Department_Name VARCHAR(100),
    PRIMARY KEY (Department_Number)
);

drop table if exists Employee;
CREATE TABLE IF NOT EXISTS Employee (
    Employee_Number INT NOT NULL AUTO_INCREMENT,
    Employee_Name VARCHAR(255),
    Department_Number INT,
    PRIMARY KEY (Employee_Number),
    FOREIGN KEY (Department_Number)
        REFERENCES Department (Department_Number)
        ON DELETE CASCADE
);

drop table if exists Employee_Skill;
CREATE TABLE IF NOT EXISTS Employee_Skill (
    Employee_Number INT,
    Skill_Code ENUM('Java', 'Postman', 'SQL', 'Ruby', 'PHP'),
    Date_Registered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Employee_Number)
        REFERENCES Employee (Employee_Number)
        ON DELETE CASCADE
);

-- Question 2

insert into Department(Department_Name) values ('Marketing'),
                                               ('Sales'),
                                               ('Nhan Su'), 
                                               ('Giam doc'), 
                                               ('Pho giam doc'),
                                               ('Bao ve'),
                                               ('Ban hang'), 
                                               ('Thu ki'),
                                               ('Marketing'),
                                               ('Sales'),
                                               ('Nhan Su'), 
                                               ('Giam doc'), 
                                               ('Pho giam doc'),
                                               ('Bao ve'),
                                               ('Ban hang');

insert into employee (Employee_Name, Department_Number) values ('Luu Van Quyen', 1),  
														       ('Pham Thi Hue Chi', 2), 
                                                               ('Nguyen Van A', 3), 
                                                               ('Pham Thi C', 5), 
                                                               ('Nguyen Thi M', 6), 
                                                               ('Duong Van L', 9), 
                                                               ('Nguyen Van T', 15), 
                                                               ('Nguyen Van K', 11), 
                                                               ('Nguyen Nhu C', 12), 
                                                               ('Nguyen Duc N', 7), 
                                                               ('Pham Thi Hue Chi', 1), 
                                                               ('Nguyen Van A', 4), 
                                                               ('Pham Thi C', 9), 
                                                               ('Nguyen Thi M', 3), 
                                                               ('Duong Van L', 2), 
                                                               ('Nguyen Van T', 14), 
                                                               ('Nguyen Van K', 12), 
                                                               ('Nguyen Nhu C', 13), 
                                                               ('Nguyen Duc N', 2),
                                                               ('Pham Thi Hue Chi', 3), 
                                                               ('Nguyen Van A', 10), 
                                                               ('Pham Thi C', 7), 
                                                               ('Nguyen Thi M', 4), 
                                                               ('Duong Van L', 11), 
                                                               ('Nguyen Van T', 12), 
                                                               ('Nguyen Van K', 15), 
                                                               ('Nguyen Nhu C', 14), 
                                                               ('Nguyen Duc N', 10);
insert into employee_skill (Employee_Number, Skill_Code) values (1, 'Java'), 
                                                                (2, 'PHP'), 
                                                                (3, 'Postman'), 
                                                                (4, 'SQL'), 
                                                                (5, 'Java'), 
                                                                (6, 'SQL'), 
                                                                (7, 'Ruby'), 
                                                                (8, 'PHP'), 
                                                                (9, 'SQL'), 
                                                                (10, 'SQL'), 
                                                                (11, 'Postman'), 
                                                                (12, 'Ruby'),
                                                                (13, 'Postman'),
                                                                (14, 'Java'), 
                                                                (15, 'Java'),
                                                                (5, 'Java'), 
                                                                (6, 'SQL'), 
                                                                (7, 'Ruby'), 
                                                                (8, 'PHP'), 
                                                                (9, 'SQL'), 
                                                                (10, 'SQL'), 
                                                                (9, 'SQL'), 
                                                                (10, 'SQL'), 
                                                                (11, 'Postman'), 
                                                                (12, 'Ruby'),
                                                                (13, 'Postman');
												
-- Question 3
SELECT 
    Employee_Name
FROM
    employee 
UNION SELECT 
    Skill_Code
FROM
    employee_skill
WHERE
    Skill_Code = 'Java';
-- Question 4
SELECT 
    d.Department_Number,
    d.Department_Name,
    COUNT(e.Department_Number)
FROM
    department d
        JOIN
    employee e ON d.Department_Number = e.Department_Number
GROUP BY e.Department_Number
HAVING COUNT(e.Department_Number) >= 3;

-- Question 5
SELECT 
    e.Department_Number, COUNT(e.Employee_Number)
FROM
    employee e
GROUP BY e.Department_Number;

-- Question 6
SELECT DISTINCT
    e.Employee_Number,
    e.Employee_Name,
    COUNT(es.Employee_Number)
FROM
    employee e
        JOIN
    employee_skill es ON e.Employee_Number = es.Employee_Number
GROUP BY es.Employee_Number
HAVING COUNT(es.Employee_Number) > 2;




