use fresher_training_management;
drop table if exists Department;
CREATE TABLE IF NOT EXISTS Department (
    Department_Number INT NOT NULL AUTO_INCREMENT,
    Department_Name VARCHAR(100),
    PRIMARY KEY (Department_Number)
);
cr4eate tbale Employee