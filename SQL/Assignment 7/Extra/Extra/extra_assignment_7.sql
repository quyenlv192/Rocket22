-- Exercise 1
use extra_assignment_6;
drop trigger if exists not_allow_user_insert_invalid_info;

delimiter $$
create trigger not_allow_user_insert_invalid_info
before insert on project_modules
for each row
begin 
	declare v_project_start_date date;
    declare v_project_completed_on date;
    SELECT 
    ProjectStartDate, ProjectCompletedOn
INTO v_project_start_date , v_project_completed_on FROM
    projects; 
    if (ProjectModulesDate < v_project_start_date) or (ProjectModulesCompletedON > v_project_completed_on) then
    signal sqlstate '12345' set message_text = "Invalid Input";
    end if;
end $$
delimiter ;

-- Exercise 2
use fresher_training_management;
drop view if exists vw_intership;
CREATE VIEW vw_internship AS
    SELECT 
        *
    FROM
        trainee
    WHERE
        (ET_IQ + ET_Gmath >= 20) AND ET_IQ >= 8
            AND ET_Gmath >= 8
            AND ET_English >= 18;

