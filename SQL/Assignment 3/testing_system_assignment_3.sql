use testing_system_assignment_2;
-- Question 2
SELECT 
    *
FROM
    department;
    
-- Question 3
SELECT 
    DepartmentID
FROM
    department
WHERE
    DepartmentName = 'Sales';

-- Question 4
SELECT 
    FullName, max(length(FullName))
FROM
    account
WHERE
    LENGTH(FullName) = (SELECT 
            MAX(LENGTH(FullName))
        FROM
            account);
-- Question 5 
SELECT 
    FullName, MAX(LENGTH(FullName))
FROM
    account
WHERE
LENGTH(FullName) = (SELECT 
            MAX(LENGTH(FullName))
        FROM
            account) and DepartmentID = 3;

-- Question 6 
SELECT 
    GroupName
FROM
    `group`
WHERE
    createDate < '2019-12-20';
    
-- Question 7
SELECT 
    QuestionID, COUNT(QuestionID)
FROM
    answer
GROUP BY QuestionID
HAVING COUNT(QuestionID) >= 4;

-- Question 8 
SELECT 
    Title
FROM
    exam
WHERE
    Duration >= 60
        AND CreateDate < '2019-12-20';

-- Question 9
SELECT 
    *
FROM
    `group`
ORDER BY CreateDate DESC
LIMIT 5;

-- Question 10
SELECT 
    COUNT(PositionID)
FROM
    account
WHERE
    DepartmentID = 2;
	
-- Question 11 
SELECT 
    *
FROM
    account
WHERE
    SUBSTRING_INDEX(FullName, ' ', - 1) LIKE 'D%o';

-- Question 12 
DELETE FROM exam 
WHERE
    CreateDate < '2019-12-20';
    
-- Cach 2: xoa tu examquestion
DELETE FROM examquestion 
WHERE
    ExamID IN (SELECT 
        ExamID
    FROM
        exam
    
    WHERE
        CreateDate < '2019-12-20');

-- Question 13 
DELETE FROM question 
WHERE
    Content LIKE 'câu hỏi%';

-- Question 14
UPDATE `account` 
SET 
    FullName = 'Nguyễn Bá Lộc',
    Email = 'loc.nguyenba@vti.com.vn'
WHERE
    AccountID = 5;
    
-- Question 15 
UPDATE groupaccount 
SET 
    GroupID = 4
WHERE
    AccountID = 5;


