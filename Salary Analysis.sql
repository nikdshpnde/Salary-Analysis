#Delete schema if already exists
DROP SCHEMA IF EXISTS Salary_Analysis;

#Create Salary Analysis Schema
CREATE SCHEMA Salary_Analysis;

#Select Salary Analysis Schema
USE Salary_Analysis;

# I used the table import feature rather than a create table command.
	#If you are no aware of how to use this feature, please follow the steps:
	#1. Expand the Salary_Analysis Schema 
	#2. Right Click on Tables and Select Table Data Import wizard
	#3. Click on Browse to open the file
	#4. Click on Next and select Create New Table. (by default the active schema is selected and the file name is taken as a table name)
	#5. Select drop table if exists (it will work only if you have created the same table name as the file name before using import wizard, otherwise ignore)
	#6. Click on next and select the appropriate datatype for variables. (Table previous is available for your understanding while selecting datatype)
	#7. Click next and data import will work. If there is any error, you will see it in the window. 
	#8. Once the import is successful, you will see the total number of observations (rows) that are imported. 
	
	

SELECT * FROM latest_data_science_salaries
LIMIT 5;

#Highest Salary
SELECT
	CONCAT('$', FORMAT( MAX(Salary_in_USD), 2)) AS Highest_Salary 
    FROM latest_data_science_salaries
    ORDER BY Highest_Salary DESC LIMIT 1;

#2nd Highest Salary onwards
SELECT 
    Job_Title,
    MAX(Salary_in_USD) AS Second_Highest
FROM latest_data_science_salaries
WHERE Salary_in_USD < (SELECT MAX(Salary_in_USD) FROM latest_data_science_salaries)
GROUP BY Job_Title
ORDER BY Second_Highest DESC;

#Rank salary
SELECT Job_Title,
        Salary_in_USD AS Second_Highest
FROM latest_data_science_salaries
GROUP BY Job_Title,
		Second_Highest
ORDER BY Second_Highest DESC
LIMIT 1 OFFSET 2;  #nth highest salary: change offset value accordingly. Index starts at 0
	
#Dense Rank
SELECT Salary_in_USD,
       DENSE_RANK() OVER (ORDER BY Salary_in_USD DESC) AS 'Rank'
FROM latest_data_science_salaries; 

# salaries those appear 3 times in the dataset
SELECT Salary_in_USD,
COUNT(*) AS Consecutive_rank
FROM latest_data_science_salaries
GROUP BY Salary_in_USD
HAVING COUNT(*) = 3
ORDER BY Salary_in_USD DESC; 

#Salary Formated in currency
SELECT Job_Title,
	 CONCAT('$', FORMAT(Salary_in_USD, '##,###') )AS Salary
FROM latest_data_science_salaries
GROUP BY Job_Title, Salary_in_USD
ORDER BY Salary_in_USD ASC; 

#min and max salaries
SELECT
  MAX(Salary_in_USD) AS highest_salary,
  MIN(Salary_in_USD) AS lowest_salary
FROM latest_data_science_salaries; 

#minimum salary and their title
SELECT Job_Title,
		Salary_in_USD
FROM latest_data_science_salaries
WHERE (SELECT MIN(Salary_in_USD) FROM latest_data_science_salaries)
GROUP BY Job_Title, Salary_in_USD
ORDER BY Salary_in_USD ASC, Job_Title ASC
LIMIT 1; 

SELECT DISTINCT(Experience_Level)
FROM latest_data_science_salaries;

#Self Join Mid level employees earning more than Senior level employees
SELECT CONCAT('$', FORMAT(e.Salary_in_USD, '##,###')) AS Salary,
		e.Experience_Level AS Seniority,
        e.Job_Title as 'Job Title',
        e.Company_Size
FROM latest_data_science_salaries e 
JOIN latest_data_science_salaries m 
	ON e.Experience_Level = 'Mid' AND m.Experience_Level = 'Senior' 
	AND e.Salary_in_USD > m.Salary_in_USD AND e.Company_Location = 'United States' AND e.Company_size = 'Medium'
GROUP BY e.Salary_in_USD,
		e.Experience_Level,
		e.Job_Title,
        e.Company_Size
ORDER BY e.Salary_in_USD DESC;

#Count of duplicate Residence locations
SELECT Employee_Residence,
		COUNT(*) AS Repeated
FROM latest_data_science_salaries
GROUP BY Employee_Residence
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC; 

#Highest Salaried Job Titles by Expertise Level between 2021 and 2023
SELECT e.Job_Title,
		e.Experience_Level,
        e.Salary_in_USD,
        e.Employee_Residence
FROM latest_data_science_salaries e
JOIN latest_data_science_salaries m ON e.Expertise_Level = 'Expert' AND e.Salary_in_USD > m.Salary_in_USD AND e.Year BETWEEN 2021 AND 2023
GROUP BY e.Job_Title,
		e.Experience_Level,
        e.Salary_in_USD,
        e.Employee_Residence
ORDER BY e.Salary_in_USD DESC;  #This is to demonstrate complex self-join method 
#OR
SELECT Job_Title, Experience_Level, Salary_in_USD, Employee_Residence
FROM latest_data_science_salaries
WHERE Expertise_Level = 'Expert' AND Year BETWEEN 2021 AND 2023
ORDER BY Salary_in_USD DESC;

#TOP 3 highest salary earners in Expert level
SELECT e.Job_Title,
		e.Experience_Level,
        e.Salary_in_USD,
        e.Employee_Residence
FROM latest_data_science_salaries e
JOIN latest_data_science_salaries m ON e.Expertise_Level = 'Expert' AND e.Salary_in_USD > m.Salary_in_USD AND e.Year BETWEEN 2021 AND 2023
GROUP BY e.Job_Title,
		e.Experience_Level,
        e.Salary_in_USD,
        e.Employee_Residence
ORDER BY e.Salary_in_USD DESC
LIMIT 3; 
#OR
SELECT Job_Title, Experience_Level, Salary_in_USD, Employee_Residence
FROM latest_data_science_salaries
WHERE Expertise_Level = 'Expert' AND Year BETWEEN 2021 AND 2023
ORDER BY Salary_in_USD DESC
LIMIT 3;
