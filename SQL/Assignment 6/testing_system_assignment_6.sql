-- Exercise 1
-- Question 1
drop procedure if exists question1;
Delimiter && 
create procedure question1(in department_name varchar(255)) 
begin 
SELECT 
    a.*
FROM
    `account` a
        INNER JOIN
    department d ON a.DepartmentID = d.DepartmentID
WHERE
    d.DepartmentName = department_name;
end &&

Delimiter ;
call question1('Sales');

-- Question 2
drop procedure if exists question2;
Delimiter &&
CREATE PROCEDURE question2 () 
BEGIN 
	SELECT 
    GroupID, AccountID, COUNT(AccountID)
FROM
    groupaccount
GROUP BY GroupID, AccountID;
End &&

Delimiter ;
-- Question 3

drop procedure if exists question3;
Delimiter &&
CREATE PROCEDURE question3 () 
BEGIN 
	SELECT 
    tq.TypeName, COUNT(q.TypeID)
FROM
    question q
        INNER JOIN
    typequestion tq ON q.TypeID = tq.TypeID
WHERE
    MONTH(q.CreateDate) = MONTH(NOW())
        AND YEAR(q.CreateDate) = YEAR(NOW())
GROUP BY q.TypeID;
End &&

Delimiter ;
-- Question 4
drop procedure if exists question4;
Delimiter &&
CREATE PROCEDURE question4 () 
BEGIN 
	SELECT 
    tq.TypeID
FROM
    typequestion tq
        INNER JOIN
    question q ON tq.TypeID = q.TypeID
GROUP BY q.TypeID
HAVING COUNT(q.TypeID) = (SELECT 
        MAX(count_ques)
    FROM
        (SELECT 
            COUNT(q.TypeID) AS count_ques
        FROM
            question q
        GROUP BY q.TypeID) AS max_count_ques);
End &&

Delimiter ;
-- Question 5
drop procedure if exists question5;
Delimiter &&
CREATE PROCEDURE question5 () 
BEGIN 
	SELECT 
    tq.TypeID, tq.TypeName
FROM
    typequestion tq
        INNER JOIN
    question q ON tq.TypeID = q.TypeID
GROUP BY q.TypeID
HAVING COUNT(q.TypeID) = (SELECT 
        MAX(count_ques)
    FROM
        (SELECT 
            COUNT(q.TypeID) AS count_ques
        FROM
            question q
        GROUP BY q.TypeID) AS max_count_ques);
End &&

Delimiter ;
-- Question 6
drop procedure if exists question6;
Delimiter &&
CREATE PROCEDURE question6 (in string_input varchar(50)) 
BEGIN 
	SELECT 
    GroupID, GroupName
FROM
    `group`
WHERE
    GroupName LIKE CONCAT('%', string_input, '%');
    SELECT 
    *
FROM
    `account`
WHERE
    Username LIKE CONCAT('%', string_input, '%');
End &&

Delimiter ;
-- Question 7
drop procedure if exists question7;
Delimiter &&
CREATE PROCEDURE question7 (in email_input varchar(255), in fullname_input varchar(255)) 
BEGIN 
	Declare v_user_name varchar(255) default substring_index(email_input, '@', 1);
    Declare v_department_id int default 1;
    declare v_position_id int default 1;
    declare v_create_date datetime default now();
    
    insert into `account` (Email, Username, FullName, DepartmentID, PositionID, CreateDate) values (email_input, v_user_name, fullname_input, v_department_id, v_position_id, v_create_date);
End &&

Delimiter ;
-- Question 8
drop function if exists question8;
Delimiter &&
CREATE function question8 (input_string enum ('Multiple-Choice', 'Essay')) returns int
BEGIN 
	declare output int;
    if input_string = 'Multiple-Choice' then 
    SELECT 
    MAX(LENGTH(Content)) into output
FROM
    question q
        JOIN
    typequestion tq ON q.TypeID = tq.TypeID
WHERE
    q.TypeID IN (SELECT 
            TypeID
        FROM
            typequestion
        WHERE
            TypeName = 'Multiple-Choice');
            return output;
   else 
   SELECT 
    MAX(LENGTH(Content)) into output
FROM
    question q
        JOIN
    typequestion tq ON q.TypeID = tq.TypeID
WHERE
    q.TypeID IN (SELECT 
    TypeID
FROM
    typequestion
WHERE
    TypeName = 'Essay');
    return output;
    end if;
End &&

Delimiter ;


select question8('Essay');

-- Question 9
drop procedure if exists question9;
Delimiter &&
CREATE PROCEDURE question9 (exam_id int) 
BEGIN 
	DELETE FROM exam 
WHERE
    ExamID = exam_id;
End &&
Delimiter ;

call question9(15);
-- Question 10
drop procedure if exists question10;
Delimiter &&
CREATE PROCEDURE question10 () 
BEGIN 
	DELETE FROM exam 
WHERE
    YEAR(CreateDate) = (YEAR(Now()) - 3);
End &&

Delimiter ;
-- Question 11
drop procedure if exists question11;
Delimiter &&
CREATE PROCEDURE question11 (in department_name varchar(255)) 
BEGIN 
	declare v_department_id int;
SELECT 
    d.DepartmentID
INTO v_department_id FROM
    department d
WHERE
    DepartmentName = department_name;
	DELETE FROM department 
WHERE
    DepartmentName = department_name;
UPDATE `account` a
SET 
    a.DepartmentID = 15
WHERE
    a.DepartmentID = v_department_id;
End &&

Delimiter ;

call question11('Bảo vệ');
-- Question 12
drop procedure if exists question12;
Delimiter &&
CREATE PROCEDURE question12 () 
BEGIN 
	SELECT 
    MONTH(CreateDate), COUNT(QuestionID)
FROM
    question
WHERE
    YEAR(CreateDate) = Year(Now())
GROUP BY MONTH(CreateDate);
End &&

Delimiter ;

-- solution
drop procedure if exists question12;
Delimiter &&
CREATE PROCEDURE question12 () 
BEGIN 
	with CTE_12month as 
    (SELECT 1 AS month 
UNION SELECT 2 AS month 
UNION SELECT 3 AS month 
UNION SELECT 4 AS month 
UNION SELECT 5 AS month 
UNION SELECT 6 AS month 
UNION SELECT 7 AS month 
UNION SELECT 8 AS month 
UNION SELECT 9 AS month 
UNION SELECT 10 AS month 
UNION SELECT 11 AS month 
UNION SELECT 12 AS month) SELECT 
    m.month, COUNT(q.QuestionID)
FROM
    CTE_12month m
        LEFT JOIN
    (SELECT 
        *
    FROM
        question q
    WHERE
        YEAR(CreateDate) = YEAR(NOW())) Q ON m.month = MONTH(Q.CreateDate)
GROUP BY m.month;
End &&

Delimiter ;
-- Question 13
drop procedure if exists question13;
Delimiter &&
CREATE PROCEDURE question13 () 
BEGIN 
	with CTE_6_latest_month as
    (SELECT 
    MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS month,
    YEAR(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS `year`

UNION SELECT 
    MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS month,
    YEAR(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS `year`

UNION SELECT 
    MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS month,
    YEAR(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS `year`

UNION SELECT 
    MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS month,
    YEAR(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS `year`

UNION SELECT 
    MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS month,
    YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS `year`

UNION SELECT MONTH(NOW()) AS month, YEAR(NOW()) AS `year`
)
SELECT M.MONTH,M.YEAR, CASE

WHEN COUNT(QuestionID) = 0 THEN 'không có câu hỏi nào trong

tháng'
ELSE COUNT(QuestionID)
END AS SL
FROM CTE_6_latest_month M
LEFT JOIN (SELECT * FROM question where CreateDate <= now() and CreateDate >= DATE_SUB(NOW(),

INTERVAL 6 MONTH)) AS Sub_Question ON M.MONTH =
MONTH(CreateDate)

GROUP BY M.MONTH
ORDER BY M.MONTH ASC;

End &&

Delimiter ;




