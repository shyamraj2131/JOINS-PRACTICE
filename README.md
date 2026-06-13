# JOINS-PRACTICE

*COMPANY*: CODTECH IT SOLUTIONS

*NAME*: SOLOMON SHYAM RAJ

*INTERN ID*: CTIS9521

*DURATION*: 6 WEEKS

*MENTOR*: NEELA SANTOSH

# Task 1: Implementation and Analysis of SQL JOIN Operations in a Placement Management System

During my 6-week internship as a SQL Developer Intern, I worked on designing and implementing a Placement Management System database using MySQL. For Task 1, my primary objective was to understand and demonstrate the practical use of SQL JOIN operations by creating a relational database and retrieving meaningful information from multiple related tables.

To begin with, I designed the database schema from scratch based on the requirements of a placement management system. I created five interconnected tables: Students, Companies, Job_Postings, Applications, and Placements. Each table was designed with appropriate primary keys and foreign key relationships to maintain data integrity and establish connections between different entities in the database.

After creating the database structure, I inserted sample data into all tables. The sample records represented students from different branches, companies from various industries, job postings, student applications, and placement details. This data helped in testing and validating the SQL JOIN queries effectively.

The main focus of this task was to explore different types of JOIN operations available in SQL and understand their real-world applications. I implemented and analyzed the following JOIN types:

**1. INNER JOIN**

The INNER JOIN operation was used to retrieve only the records that had matching values in all related tables. By joining the Students, Applications, Job_Postings, and Companies tables, I was able to display information about students who had successfully applied for jobs. The result included student details, company names, job titles, application dates, and application statuses. This query demonstrated how INNER JOIN returns only the common records that exist across all joined tables.

**2. LEFT JOIN**

The LEFT JOIN operation was used to retrieve all records from the Students table, regardless of whether they had applied for a job or not. This allowed me to identify students who had not submitted any applications. For students without applications, the corresponding columns from the related tables returned NULL values. This JOIN type is particularly useful when organizations need a complete list of students while also identifying those who have not participated in placement activities.

Additionally, I used a LEFT JOIN with a NULL condition to specifically find students who had never applied for any job posting. This query helped in generating actionable insights for placement coordinators.

**3. RIGHT JOIN**

The RIGHT JOIN operation was implemented to retrieve all companies, including those that had not posted any job opportunities. By joining the Job_Postings table with the Companies table, I was able to identify registered companies that were currently inactive in recruitment. In the sample data, one company appeared with NULL job details, indicating that it had no job postings. This demonstrated how RIGHT JOIN can be used to analyze participation and engagement levels of companies in the placement process.

**4. FULL OUTER JOIN (Simulated)**

Since MySQL does not directly support FULL OUTER JOIN, I simulated its behavior using a combination of LEFT JOIN, RIGHT JOIN, and UNION operations. This query provided a comprehensive view of all students and placement records, including students who were placed and those who were not. The output clearly showed which students had secured placements and which students still had no placement records. This approach helped me understand how to overcome DBMS limitations while still achieving the desired results.

Through this task, I gained practical experience in database design, table relationships, primary and foreign key constraints, data insertion, and advanced SQL querying techniques. Most importantly, I developed a strong understanding of JOIN operations and their significance in retrieving related data from multiple tables. The task enhanced my ability to write efficient SQL queries, analyze relational data, and generate meaningful reports from a database system.

Overall, this exercise provided valuable hands-on experience in MySQL database management and strengthened my knowledge of relational database concepts that are widely used in real-world software and business applications.


# OUTPUT
[full  join.html](https://github.com/user-attachments/files/28893863/full.join.html)
[inter join.html](https://github.com/user-attachments/files/28893865/inter.join.html)
[left  join.html](https://github.com/user-attachments/files/28893866/left.join.html)
[right  join.html](https://github.com/user-attachments/files/28893864/right.join.html)
