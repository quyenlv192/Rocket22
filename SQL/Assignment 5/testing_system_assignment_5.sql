-- Question 1
CREATE OR REPLACE VIEW _list_employee_from_sales_department AS
    SELECT 
        a.*
    FROM
        `account` a
    WHERE
        a.DepartmentID IN (SELECT 
                d.DepartmentID
            FROM
                department d
            WHERE
                d.DepartmentName = 'Sales');
                
-- using CTE
with CTE_question_1 as 
(SELECT 
        a.*
    FROM
        `account` a
    WHERE
        a.DepartmentID IN (SELECT 
                d.DepartmentID
            FROM
                department d
            WHERE
                d.DepartmentName = 'Sales')) 
	select * from CTE_question_1;

-- Question 2
CREATE OR REPLACE VIEW question_2 AS
    SELECT 
        a.*
    FROM
        `account` a
            JOIN
        groupaccount ga ON a.AccountID = ga.AccountID
    GROUP BY ga.AccountID
    HAVING COUNT(ga.AccountID) = (SELECT 
            MAX(count_acc)
        FROM
            (SELECT 
                COUNT(ga.AccountID) AS count_acc
            FROM
                groupaccount ga
            GROUP BY ga.AccountID) AS max_count_acc);
            
-- using CTE
with CTE_question_2 as
(SELECT 
        a.*
    FROM
        `account` a
            JOIN
        groupaccount ga ON a.AccountID = ga.AccountID
    GROUP BY ga.AccountID
    HAVING COUNT(ga.AccountID) = (SELECT 
            MAX(count_acc)
        FROM
            (SELECT 
                COUNT(ga.AccountID) AS count_acc
            FROM
                groupaccount ga
            GROUP BY ga.AccountID) AS max_count_acc))
            select * from CTE_question_2;

-- Question 3
CREATE OR REPLACE VIEW question_3 AS
    SELECT 
        *, LENGTH(content)
    FROM
        question
    WHERE
        LENGTH(content) > 100;
-- using CTE
with CTE_question_3 as
(SELECT 
        *, LENGTH(content)
    FROM
        question
    WHERE
        LENGTH(content) > 100)
        select * from CTE_question_3;

-- Question 4
CREATE OR REPLACE VIEW list_department_have_most_employee_number AS
    SELECT 
        d.*
    FROM
        department d
            JOIN
        `account` a ON d.DepartmentID = a.DepartmentID
    GROUP BY d.DepartmentID
    HAVING COUNT(d.DepartmentID) = (SELECT 
            MAX(number_of_employee)
        FROM
            (SELECT 
                COUNT(DepartmentID) AS number_of_employee
            FROM
                `account`
            GROUP BY DepartmentID) AS max_number_of_employee);

-- using CTE
with CTE_question_4 as
(SELECT 
        d.*
    FROM
        department d
            JOIN
        `account` a ON d.DepartmentID = a.DepartmentID
    GROUP BY d.DepartmentID
    HAVING COUNT(d.DepartmentID) = (SELECT 
            MAX(number_of_employee)
        FROM
            (SELECT 
                COUNT(DepartmentID) AS number_of_employee
            FROM
                `account`
            GROUP BY DepartmentID) AS max_number_of_employee)) 
		select * from CTE_question_4;

-- Question 5
CREATE OR REPLACE VIEW question_5 AS
    SELECT 
        q.QuestionID, q.Content, a.FullName AS Creator
    FROM
        `account` a
            JOIN
        question q ON a.AccountID = q.CreatorID
    WHERE
        SUBSTRING_INDEX(a.FullName, ' ', 1) = 'Nguyen';

-- using CTE        
with CTE_question_5 as
(SELECT 
        q.QuestionID, q.Content, a.FullName AS Creator
    FROM
        `account` a
            JOIN
        question q ON a.AccountID = q.CreatorID
    WHERE
        SUBSTRING_INDEX(a.FullName, ' ', 1) = 'Nguyen')
        SELECT 
    *
FROM
    CTE_Question_5;