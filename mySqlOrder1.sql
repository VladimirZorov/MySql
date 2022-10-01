USE `soft_uni`;

SELECT * FROM `departments`
ORDER BY `department_id`;

SELECT (`name`) FROM `departments`
ORDER BY `department_id`;

SELECT (`first_name`),(`last_name`),(`salary`) FROM `employees`
ORDER BY `employee_id`;

SELECT  CONCAT(first_name, '.', last_name, + '@softuni.bg') AS 'full_email_address'
 FROM `employees`
ORDER BY `employee_id`;

select distinct `salary` from `employees`;

SELECT * FROM `employees`
where `job_title` = 'Sales Representative'
ORDER BY `employee_id`;

SELECT (`first_name`),(`last_name`),(`job_title`) FROM `employees`
where `salary` between 20000 and 30000
ORDER BY `employee_id`;

SELECT  CONCAT(first_name, ' ',middle_name, ' ', last_name) AS 'Full Name'
 FROM `employees`
 where `salary` = 25000 or `salary` = 14000 or `salary` = 12500 or `salary` = 23600
ORDER BY `employee_id`;

SELECT (`first_name`),(`last_name`) FROM `employees`
where `manager_id`is NULL;

SELECT (`first_name`),(`last_name`),(`salary`) FROM `employees`
where `salary` > 50000
ORDER  BY `salary` desc; 

SELECT (`first_name`),(`last_name`) FROM `employees`
ORDER  BY `salary` desc limit 5; 

SELECT (`first_name`),(`last_name`) FROM `employees`
WHERE `department_id` !=4;

SELECT * FROM `employees`
ORDER  BY `salary` desc ,`first_name`, `last_name` desc, `middle_name`; 

create view  v_employees_salaries  AS
SELECT (`first_name`),(`last_name`),(`salary`) FROM `employees`;

create view  v_employees_job_titles  AS
    SELECT 
    CASE 
    WHEN `middle_name` IS NULL THEN
    CONCAT(first_name, ' ', last_name) 
    ELSE
	CONCAT(first_name, ' ',middle_name, ' ', last_name) 
     END
AS `full_name`, `job_title` 
FROM `employees`;

SELECT DISTINCT `job_title` 
FROM `employees`
ORDER BY job_title;

SELECT * FROM `projects`
order by `start_date`, `name`, `project_id`
LIMIT 10;

SELECT `first_name`,`last_name`,`hire_date` FROM `employees`
ORDER BY `hire_date` desc
LIMIT 7;

UPDATE `employees`
SET salary  = salary *0.12
WHERE `department_id` = 1 or 2 or 4 or 11  ;
SELECT `salary` FROM `employees`
WHERE `department_id` =  1 or 2 or 4 or 11 
ORDER BY `salary`;

UPDATE employees
SET salary = salary * 1.12
WHERE department_id IN (1,2,4,11);
SELECT salary FROM employees;

use `geography`;
SELECT `peak_name` FROM `peaks`
ORDER BY `peak_name`;

USE geography;

SELECT `country_name`,`population` FROM `countries` 
WHERE continent_code = 'EU'
ORDER BY `population` DESC , `country_name`
LIMIT 30;

SELECT `country_name`, `country_code` ,  
if(`currency_code` = 'EUR','Euro','Not Euro') AS `currency` 
FROM `countries`
ORDER BY `country_name`;

USE diablo;

SELECT `name` FROM `characters`
ORDER BY `name`;













