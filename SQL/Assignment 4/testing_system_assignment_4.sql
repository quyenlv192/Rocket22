-- Exercise 1

-- Question 1
SELECT 
    a.*, d.DepartmentName
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID;
-- Question 2
SELECT 
    *
FROM
    `account`
WHERE
    CreateDate > '2010-12-20';
-- Question 3

SELECT 
    a.*, p.PositionName
FROM
    account a
        JOIN
    position p ON a.PositionID = p.PositionID
WHERE
    p.PositionName = 'Dev';
-- Question 4
SELECT 
    a.*, d.DepartmentName
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID) > 3;
-- Question 5
SELECT 
    q.QuestionID, q.Content, COUNT(q.QuestionID)
FROM
    question q
        JOIN
    examquestion e ON q.QuestionID = e.QuestionID
GROUP BY q.QuestionID
HAVING COUNT(q.QuestionID) = (SELECT 
        MAX(count_question)
    FROM
        (SELECT 
            COUNT(QuestionID) AS count_question
        FROM
            examquestion
        GROUP BY QuestionID) AS max_count_question);
-- Question 6
SELECT 
    q.QuestionID, q.CategoryID, COUNT(q.CategoryID)
FROM
    question q
        JOIN
    categoryquestion ca ON q.CategoryID = ca.CategoryID
GROUP BY q.CategoryID;

-- Question 7
SELECT 
    q.QuestionID, q.Content, eq.ExamID, COUNT(eq.QuestionID)
FROM
    examquestion eq
         JOIN
    question q ON eq.QuestionID = q.QuestionID
GROUP BY eq.QuestionID;
-- Question 8
SELECT 
    q.QuestionID, q.Content, COUNT(q.QuestionID)
FROM
    question q
        JOIN
    answer a ON q.QuestionID = a.QuestionID
GROUP BY q.QuestionID
HAVING COUNT(q.QuestionID) = (SELECT 
        MAX(count_question)
    FROM
        (SELECT 
            COUNT(a.QuestionID) AS count_question
        FROM
            answer a
        GROUP BY a.QuestionID) AS max_count_question);

-- Question 9
SELECT 
    ga.AccountID,
    a.FullName,
    COUNT(ga.AccountID) AS number_of_account
FROM
    groupaccount ga
        JOIN
    `account` a ON ga.AccountID = a.AccountID
GROUP BY ga.AccountID;

-- Question 10
SELECT 
    p.PositionID, p.PositionName, COUNT(p.PositionID)
FROM
    position p join `account` a on p.PositionID = a.PositionID
GROUP BY p.PositionID
HAVING COUNT(p.PositionID) = (SELECT 
        MIN(count_po)
    FROM
        (SELECT 
            COUNT(PositionID) AS count_po
        FROM
            `account` a
        GROUP BY PositionID) AS min_count_po);

-- Question 11
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    p.PositionID,
    p.PositionName,
    COUNT(p.PositionName)
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
        JOIN
    position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID , p.PositionID;

-- Question 12
SELECT 
    q.*, an.Content, ca.CategoryName
FROM
    question q
        JOIN
    answer an ON q.QuestionID = an.AnswerID
        JOIN
    categoryquestion ca ON q.CategoryID = ca.CategoryID;

-- Question 13

SELECT 
    ty.TypeName, COUNT(q.TypeID)
FROM
    question q
        JOIN
    typequestion ty ON q.TypeID = ty.TypeID
GROUP BY ty.TypeName;

-- Question 14

SELECT 
    g.*
FROM
    `group` g
        LEFT JOIN
    groupaccount ga ON g.GroupID = ga.GroupID
WHERE
    ga.AccountID IS NULL;

-- Question 15
SELECT 
    *
FROM
    `group` 
WHERE
    GroupID NOT IN (SELECT 
            GroupID
        FROM
            groupaccount);
-- Question 16
SELECT 
    *
FROM
    question
WHERE
    QuestionID NOT IN (SELECT 
            QuestionID
        FROM
            answer);
            
-- 2nd way

SELECT 
    q.*
FROM
    question q
        LEFT JOIN
    answer a ON q.QuestionID = a.QuestionID
WHERE
    a.QuestionID IS NULL;
-- Exercise 2
-- Question 17
SELECT 
    a.AccountID, a.FullName
FROM
    account a
        JOIN
    groupaccount gr ON a.AccountID = gr.AccountID
WHERE
    gr.GroupID = 1 
UNION SELECT 
    a.AccountID, a.FullName
FROM
    account a
        JOIN
    groupaccount gr ON a.AccountID = gr.AccountID
WHERE
    gr.GroupID = 2; 
-- Question 18 
SELECT 
    g.GroupName, COUNT(ga.GroupID) AS number_of_member
FROM
    groupaccount ga
        JOIN
    `group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) > 5 
UNION SELECT 
    g.GroupName, COUNT(ga.GroupID) AS number_of_member
FROM
    groupaccount ga
        JOIN
    `group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) > 7;