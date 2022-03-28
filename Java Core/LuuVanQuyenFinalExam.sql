DROP DATABASE IF EXISTS thuctap;
CREATE DATABASE IF NOT EXISTS thuctap;
USE thuctap;

-- Question 1

-- Create table country
DROP TABLE IF EXISTS country;
CREATE TABLE IF NOT EXISTS country (
    country_id TINYINT NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(255),
    PRIMARY KEY (country_id)
);

-- Create table location
DROP TABLE IF EXISTS location;
CREATE TABLE IF NOT EXISTS location (
    location_id TINYINT NOT NULL AUTO_INCREMENT,
    street_address VARCHAR(255),
    postal_code INT,
    country_id TINYINT,
    PRIMARY KEY (location_id),
    FOREIGN KEY (country_id)
        REFERENCES country (country_id)
);

-- Create table employee
DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee (
    employee_id TINYINT NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(255),
    email VARCHAR(255),
    location_id TINYINT,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (location_id)
        REFERENCES location (location_id),
    UNIQUE KEY (email)
);

-- insert data into table country
INSERT INTO country (country_name) VALUES ('Việt Nam');
INSERT INTO country (country_name) VALUES ('Thai Lan');
INSERT INTO country (country_name) VALUES ('Lien Bang Nga');
INSERT INTO country (country_name) VALUES ('My');
INSERT INTO country (country_name) VALUES ('Trung Quoc');
INSERT INTO country (country_name) VALUES ('Lao');
INSERT INTO country (country_name) VALUES ('Campuchia');
INSERT INTO country (country_name) VALUES ('Singapore');
INSERT INTO country (country_name) VALUES ('Phap');
INSERT INTO country (country_name) VALUES ('Italy');

-- insert data into table location
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Hanoi', 70000, 1);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Thanh pho Ho Chi Minh', 60000, 1);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('BangKok', 230000, 2);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Bac Kinh', 1000, 5);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Vien Chan', 340000, 6);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('New York', 4500, 4);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Moscow', 54000, 3);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Da Nang', 50000, 1);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Paris', 1200, 9);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Milan', 6500, 10);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('Nha Trang', 32400, 1);

-- insert data into table employee
INSERT INTO employee (full_name, email, location_id) VALUES ('Luu Van Quyen', 'luuvanquyen08@gmail.com', 1);
INSERT INTO employee (full_name, email, location_id) VALUES ('Pham Thi Hue Chi', 'cheese216@gmail.com', 1);
INSERT INTO employee (full_name, email, location_id) VALUES ('Luu Van A', 'luuvana@gmail.com', 6);
INSERT INTO employee (full_name, email, location_id) VALUES ('Nguyen Van Quyen', 'nguyenvanquyen0gmail.com', 9);
INSERT INTO employee (full_name, email, location_id) VALUES ('Phan Thi A', 'phanthia@gmail.com', 3);
INSERT INTO employee (full_name, email, location_id) VALUES ('Duong Van A', 'duongvana@gmail.com', 5);
INSERT INTO employee (full_name, email, location_id) VALUES ('Nguyen Thi T', 'nguyenthit@gmail.com', 7);
INSERT INTO employee (full_name, email, location_id) VALUES ('Pham Thi H', 'phamthih@gmail.com', 10);
INSERT INTO employee (full_name, email, location_id) VALUES ('Nguyen Thi M', 'nguyenthim@gmail.com', 4);
INSERT INTO employee (full_name, email, location_id) VALUES ('Nguyen Van K', 'nguyenvank@gmail.com', 2);


-- Question 2
-- a) 
SELECT 
    e.*
FROM
    employee e
        JOIN
    location l ON e.location_id = l.location_id
        JOIN
    country c ON l.country_id = c.country_id
WHERE
    c.country_name = 'Việt Nam';
    
-- b)
SELECT 
    c.country_name
FROM
    employee e
        JOIN
    location l ON e.location_id = l.location_id
        JOIN
    country c ON l.country_id = c.country_id
WHERE
    e.email = 'nn03@gmail.com';
    
-- c)
SELECT 
    c.*,
    l.location_id,
    l.street_address,
    COUNT(e.location_id) AS number_of_employee
FROM
    country c
        JOIN
    location l ON c.country_id = l.country_id
        JOIN
    employee e ON e.location_id = l.location_id
GROUP BY e.location_id
ORDER BY c.country_id;
    
-- Question 3
DROP TRIGGER IF EXISTS trg_max_number_of_employee_for_each_country;

DELIMITER $$
CREATE TRIGGER trg_max_number_of_employee_for_each_country
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
	DECLARE v_count_number_of_employee INT;
    SELECT 
    COUNT(e.employee_id) INTO v_count_number_of_employee
FROM
    country c
        JOIN
    location l ON c.country_id = l.country_id
        JOIN
    employee e ON e.location_id = l.location_id
WHERE e.location_id = new.location_id
GROUP BY c.country_id;
	IF v_count_number_of_employee >= 10 THEN 
    SIGNAL SQLSTATE '12345' SET MESSAGE_TEXT = "This country has maximum number of employees";
    END IF;
END $$
DELIMITER ;
 
-- Question 4
DROP TRIGGER IF EXISTS trg_set_location_id_null;

DELIMITER $$
CREATE TRIGGER trg_set_location_id_null
BEFORE DELETE ON location
FOR EACH ROW
BEGIN
	UPDATE employee 
    SET location_id = NULL
    WHERE location_id = old.location_id;
END $$
DELIMITER ;

-- Test trigger
DELETE FROM LOCATION 
WHERE location_id = 6;



