use `testing_system_assignment_2`;

-- Question 1
drop trigger if exists trigger_not_allow_user_insert;
Delimiter $$

Create trigger trg_not_allow_user_insert
before insert on `group`
for each row
begin 
   if year(new.CreateDate) = (year(now())-1) then 
   signal sqlstate '12345' set message_text = 'Cannot create a group whose CreateDate is 1 year ago'; end if;
end $$

delimiter ;

insert into `group`(GroupName, CreatorID, CreateDate) values ('fgshdfgfsdhg', 1, '2021-03-16');

-- Question 2

Drop trigger if exists trg_insert_on_sales_department;

Delimiter $$
create trigger trg_insert_on_sales_department
before insert on `account`
for each row 
begin 
declare v_sales_department_id int;
SELECT 
    DepartmentID
INTO v_sales_department_id FROM
    department
WHERE
    DepartmentName = 'Sales';

if new.DepartmentID = v_sales_department_id then
signal sqlstate '12345' set message_text = "Department
"'Sale'" cannot add more user"; end if;
end $$

delimiter ;

-- Question 3
drop trigger if exists trig_max_account_of_a_group;

delimiter $$
create trigger trig_max_account_of_a_group
before insert on groupaccount
for each row
begin
declare v_count_user int; 
SELECT 
    COUNT(GroupID)
INTO v_count_user FROM
    groupaccount
WHERE
    GroupID = new.GroupID;
    if v_count_user >= 5 then 
signal sqlstate '12345' set message_text = "Maximum number of users in a group is 5"; end if;
end $$
delimiter ;

INSERT INTO groupaccount (GroupID, AccountID, JoinDate) VALUES (1, 9, '2011-12-12');

-- Question 4
drop trigger trg_max_question_of_an_exam;

Delimiter $$
create trigger trg_max_question_of_an_exam
before insert on examquestion
for each row
begin
	declare v_count_question int;
    select count(QuestionID) into v_count_question from examquestion 
    where QuestionID = new.QuestionID;
    if v_count_question >= 10 then 
    signal sqlstate '12345' 
    set message_text = "Maximum number of question of an exam is 10"; end if;
end $$
delimiter ;

-- Question 5

drop trigger if exists trg_not_allow_to_delete_admin_account;
Delimiter $$
create trigger trg_not_allow_to_delete_admin_account
before delete on `account`
for each row
begin 
if old.Email = 'admin@gmail.com' then 
signal sqlstate '12345' set message_text = "You cannot delete admin account";
end if;
end $$
delimiter ;

delete from `account` where Email = 'admin@gmail.com';

-- Question 6
drop trigger if exists trg_take_user_to_waiting_department;
delimiter $$
create trigger trg_take_user_to_waiting_department
before insert on `account`
for each row
begin 
declare department_id int;
SELECT 
    DepartmentID
INTO department_id FROM
    department
WHERE
    DepartmentName = 'Waiting Department';
    if  new.DepartmentID is null then set new.DepartmentID = department_id;
    end if;
end $$
delimiter ;

INSERT INTO `account`(Email, Username, FullName, PositionID) VALUES ('quyen@gmail.com','quyenlv','Luu Van Quyen',2);

-- Question 7

drop trigger if exists trg_max_answer_for_a_question;
delimiter $$
create trigger  trg_max_answer_for_a_question
before insert on answer
for each row
begin 
declare v_count_question int;
declare v_count_correct_answer int;
SELECT 
    COUNT(QuestionID)
INTO v_count_question FROM
    answer
WHERE
    QuestionID = new.QuestionID;
SELECT 
    COUNT(isCorrect)
INTO v_count_correct_answer FROM
    answer
WHERE
    QuestionID = new.QuestionID
        AND isCorrect = new.isCorrect;
if (v_count_question >= 4) or (v_count_correct_answer>= 2) then 
signal sqlstate '12345' set message_text = "Cannont add more answer"; end if;
end $$
delimiter ;

INSERT INTO answer(Content, QuestionID, isCorrect) VALUES ('quyenluu', 5, true);

-- Question 8
drop trigger if exists trg_fix_data;
delimiter $$
create trigger trg_fix_data
before insert on `account`
for each row
begin 
if new.Gender = 'Male' then set new.Gender = 'M';
elseif new.Gender = 'Female' then set new.Gender = 'F';
else set new.Gender = 'U'; end if;
end $$
delimiter ;

INSERT INTO `account`(Email, Username, FullName, DepartmentID, PositionID, Gender) VALUES ('quyen3retrfg4234@gmail.com','test2quyen','Luu Van Quyen Test2',4,9, 'Unknown');

-- Question 9
drop trigger if exists trg_not_allow_user_delete_exam_created_2_days_before;
delimiter $$
create trigger trg_not_allow_user_delete_exam_created_2_days_before
before delete on exam
for each row
begin 
	if datediff(now(), CreateDate) = 2 then 
    signal sqlstate '12345' set message_text = "Cannot delete exam created 2 days ago"; end if;
end $$
delimiter ;

delete from exam where CreateDate = '2022-04-16';

-- Question 10

drop trigger if exists trg_prevent_user_from_updating_question;
delimiter $$
create trigger trg_prevent_user_from_updating_question
before update on question 
for each row
begin 
	declare v_count_question int;
    select count(QuestionID) into v_count_question from examquestion where 
    QuestionID = new.QuestionID;
    if v_count_question = 0 then 
    signal sqlstate '12345' set message_text = "Cannot update this question"; 
    end if;
end $$
delimiter ;

update question 
set content = 'test'
where QuestionID = 13;

drop trigger if exists trg_prevent_user_from_deleting_question;
delimiter $$
create trigger trg_prevent_user_from_deleting_question
before delete on question 
for each row
begin 
	declare v_count_question int;
    select count(QuestionID) into v_count_question from examquestion where 
    old.QuestionID = QuestionID;
    if v_count_question = 0 then 
    signal sqlstate '12345' set message_text = "Cannot delete this question"; 
    end if;
end $$
delimiter ;

delete from question 
where QuestionID = 13;

-- Question 12

SELECT 
    ExamID,
    Title,
    CASE
        WHEN Duration <= 30 THEN 'Short time'
        WHEN Duration > 30 AND Duration <= 60 THEN 'Medium time'
        ELSE 'Long time'
    END AS Duration
FROM
    exam;

-- Question 13
SELECT 
    AccountID,
    COUNT(AccountID),
    CASE
        WHEN COUNT(AccountID) <= 5 THEN 'Few'
        WHEN COUNT(AccountID) > 5 AND COUNT(AccountID) <= 20 THEN 'Normal'
        ELSE 'Higher'
    END AS the_number_user_amount
FROM
    groupaccount
GROUP BY AccountID;

-- Question 14

SELECT 
    d.DepartmentID,
    d.DepartmentName,
    IF(COUNT(a.DepartmentID) = 0,
        'Không có user',
        COUNT(a.DepartmentID)) AS number_of_user
FROM
    department d
        LEFT JOIN
    account a ON a.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID;


