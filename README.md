# Salary Analysis SQL
This repository contains SQL code to analyze salary data from the latest_data_science_salaries table.
Contents
The SQL scripts in this repository perform various analyses on the salary data, such as:
Finding minimum and maximum salaries
Determining the highest and nth highest salaries
Ranking salaries
Comparing salaries by experience level
Identifying duplicate records
Formatting salaries as currency
### Usage
The SQL code is designed to work with a sample database schema containing a single table latest_data_science_salaries with columns like:
Salary_in_USD - The salary amount in USD
Job_Title - Job title of the employee
Experience_Level - Experience level, e.g. Junior, Senior
Employee_Residence - Location of the employee
# To use the scripts:
Create the sample schema and populate the table with salary data
Run the individual SQL scripts as needed to generate the desired reports and analysis
Results will be output to the console
# Optimizations
Some optimizations made in the SQL code:
Use of table aliases for improved readability
Conversion of salaries to formatted currency within SQL
Use of CTEs and window functions to simplify complex logic
Comments explaining the purpose of each query
# Future Improvements
Some ways the code could be improved in the future:
Parameterization to allow analyzing other tables
Additional standardized formatting of results
Storing analysis results in new tables
