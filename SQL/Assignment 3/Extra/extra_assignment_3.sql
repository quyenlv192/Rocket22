
use fresher_training_management;

-- Question 1
insert into  trainee (Full_Name, Birth_Date, Gender, ET_IQ, ET_GMATH, ET_English, Training_Class, Evaluation_Notes)
values ('Luu Van Quyen', '2001-02-19', 'male', 20, 20, 50, 'Rocket22', 'Good'), 
	   ('Pham Thi Hue Chi', '2001-06-21', 'female', 20, 20, 50, '4Q19', 'Excellent'), 
       ('Nguyen Van A', '1998-02-21', 'male', 10, 4, 8, 'FIT', 'Bad'), 
       ('Ha Hung B', '1975-03-01', 'unknown', 15, 15, 9, 'FMT', 'Pass'), 
       ('Nguyen Thi M', '2000-01-01', 'female', 10, 12, 39, 'Marketing', 'Progress'), 
       ('Duong Thi N', '1995-02-21', 'female', 7, 12, 15, 'Java', 'Good'), 
       ('Ta Van U', '1988-02-12', 'male', 15, 3, 49, 'PHP', 'Good'),
       ('Nguyen Thi Y', '1998-02-12', 'female', 16, 13, 25, 'NodeJS', 'Good'),
       ('Nguyen Van K', '1990-02-11', 'male', 10, 15, 43, 'Postman', 'Good');
       
-- Question 2

SELECT 
    Full_Name, MONTH(Birth_Date)
FROM
    trainee
WHERE
    (ET_IQ + ET_GMATH >= 20 AND ET_IQ >= 8
        AND ET_GMATH >= 8
        AND ET_English >= 18)
GROUP BY MONTH(Birth_Date);

-- Question 3

SELECT 
    *
FROM
    trainee
WHERE
    LENGTH(Full_Name) = (SELECT 
            MAX(LENGTH(Full_Name))
        FROM
            trainee);
            
-- Question 4
SELECT 
    Full_Name AS ET
FROM
    trainee
WHERE
    ET_IQ + ET_GMATH >= 20 AND ET_IQ >= 8
        AND ET_GMATH >= 8
        AND ET_English >= 18;
	
-- Question 5
DELETE FROM trainee 
WHERE
    TraineeID = 3;
    
-- Question 6
UPDATE trainee 
SET 
    Training_Class = '2'
WHERE
    TraineeID = 5;

