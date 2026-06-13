
-- ============================================================
-- CREATE DATABASE & TABLES
-- ============================================================

CREATE DATABASE IF NOT EXISTS placement_db;
USE placement_db;

-- Students Table
CREATE TABLE IF NOT EXISTS Students (
    Student_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Name         VARCHAR(100) NOT NULL,
    Email        VARCHAR(100) UNIQUE NOT NULL,
    Branch       VARCHAR(50),
    CGPA         DECIMAL(3,2),
    Year_of_Graduation INT
);

-- Companies Table
CREATE TABLE IF NOT EXISTS Companies (
    Company_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Company_Name VARCHAR(100) NOT NULL,
    Industry     VARCHAR(50),
    Location     VARCHAR(100)
);

-- Job_Postings Table
CREATE TABLE IF NOT EXISTS Job_Postings (
    Job_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Company_ID   INT,
    Job_Title    VARCHAR(100),
    Required_Skills VARCHAR(200),
    FOREIGN KEY (Company_ID) REFERENCES Companies(Company_ID)
);

-- Applications Table
CREATE TABLE IF NOT EXISTS Applications (
    Application_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID     INT,
    Job_ID         INT,
    Application_Date DATE,
    Status         VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Job_ID)     REFERENCES Job_Postings(Job_ID)
);

-- Placements Table
CREATE TABLE IF NOT EXISTS Placements (
    Placement_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID     INT,
    Company_ID     INT,
    Job_ID         INT,
    Salary_Package DECIMAL(10,2),
    Status         VARCHAR(30) DEFAULT 'Accepted',
    FOREIGN KEY (Student_ID)  REFERENCES Students(Student_ID),
    FOREIGN KEY (Company_ID)  REFERENCES Companies(Company_ID),
    FOREIGN KEY (Job_ID)      REFERENCES Job_Postings(Job_ID)
);

-- ============================================================
-- INSERT SAMPLE DATA
-- ============================================================

INSERT INTO Students (Name, Email, Branch, CGPA, Year_of_Graduation) VALUES
('Alice Johnson',  'alice@email.com',   'Computer Science', 9.1, 2024),
('Bob Smith',      'bob@email.com',     'Electronics',      8.3, 2024),
('Charlie Brown',  'charlie@email.com', 'Mechanical',       7.5, 2024),
('Diana Prince',   'diana@email.com',   'Computer Science', 8.8, 2024),
('Evan Rogers',    'evan@email.com',    'Civil',            6.9, 2024),
('Fiona Green',    'fiona@email.com',   'Computer Science', 9.5, 2024);

INSERT INTO Companies (Company_Name, Industry, Location) VALUES
('Google',      'Technology',  'Hyderabad'),
('TCS',         'IT Services', 'Chennai'),
('Infosys',     'IT Services', 'Bangalore'),
('Amazon',      'E-Commerce',  'Hyderabad'),
('WipTech',     'Technology',  'Pune');

INSERT INTO Job_Postings (Company_ID, Job_Title, Required_Skills) VALUES
(1, 'Software Engineer',       'Python, SQL, DSA'),
(2, 'System Analyst',          'Java, SQL, Communication'),
(3, 'Associate Developer',     'C++, OOP, SQL'),
(4, 'Cloud Support Engineer',  'AWS, Linux, Python'),
(1, 'Data Analyst',            'Python, Excel, SQL');

INSERT INTO Applications (Student_ID, Job_ID, Application_Date, Status) VALUES
(1, 1, '2024-01-10', 'Hired'),
(1, 5, '2024-01-12', 'Shortlisted'),
(2, 2, '2024-01-11', 'Pending'),
(3, 3, '2024-01-13', 'Rejected'),
(4, 1, '2024-01-14', 'Hired'),
(6, 4, '2024-01-15', 'Shortlisted');

INSERT INTO Placements (Student_ID, Company_ID, Job_ID, Salary_Package, Status) VALUES
(1, 1, 1, 1200000.00, 'Accepted'),
(4, 1, 1,  950000.00, 'Accepted');

-- ============================================================
-- JOIN QUERIES WITH OUTPUTS
-- ============================================================

-- ------------------------------------------------------------
-- INNER JOIN
-- Returns only matching records from both tables.
-- Use case: Students who have applied for jobs (both must exist).
-- ------------------------------------------------------------
SELECT
    s.Student_ID,
    s.Name          AS Student_Name,
    s.Branch,
    j.Job_Title,
    c.Company_Name,
    a.Application_Date,
    a.Status
FROM Students s
INNER JOIN Applications a ON s.Student_ID = a.Student_ID
INNER JOIN Job_Postings j  ON a.Job_ID     = j.Job_ID
INNER JOIN Companies c     ON j.Company_ID = c.Company_ID
ORDER BY s.Student_ID;


-- ------------------------------------------------------------
-- LEFT JOIN
-- Returns ALL students, even those with no applications.
-- Use case: Find students who have NOT applied anywhere yet.
-- ------------------------------------------------------------
SELECT
    s.Student_ID,
    s.Name         AS Student_Name,
    s.Branch,
    a.Application_ID,
    j.Job_Title,
    c.Company_Name,
    a.Status
FROM Students s
LEFT JOIN Applications a ON s.Student_ID = a.Student_ID
LEFT JOIN Job_Postings j  ON a.Job_ID     = j.Job_ID
LEFT JOIN Companies c     ON j.Company_ID = c.Company_ID
ORDER BY s.Student_ID;


-- Filter to find students who never applied
SELECT s.Student_ID, s.Name, s.Branch
FROM Students s
LEFT JOIN Applications a ON s.Student_ID = a.Student_ID
WHERE a.Application_ID IS NULL;


-- ------------------------------------------------------------
-- RIGHT JOIN
-- Returns ALL companies, even those with no job postings.
-- Use case: Identify companies registered but not yet hiring.
-- ------------------------------------------------------------
SELECT
    c.Company_ID,
    c.Company_Name,
    c.Industry,
    j.Job_ID,
    j.Job_Title
FROM Job_Postings j
RIGHT JOIN Companies c ON j.Company_ID = c.Company_ID
ORDER BY c.Company_ID;


-- ------------------------------------------------------------
-- FULL OUTER JOIN (Simulated in MySQL using UNION)
-- Returns ALL students and ALL jobs, matched where possible.
-- Use case: Complete picture of placements — who is placed,
--           who is not, and which jobs have no takers.
-- ------------------------------------------------------------
SELECT
    s.Student_ID,
    s.Name         AS Student_Name,
    p.Salary_Package,
    c.Company_Name,
    j.Job_Title,
    p.Status
FROM Students s
LEFT JOIN Placements p  ON s.Student_ID = p.Student_ID
LEFT JOIN Companies c   ON p.Company_ID = c.Company_ID
LEFT JOIN Job_Postings j ON p.Job_ID    = j.Job_ID

UNION

SELECT
    s.Student_ID,
    s.Name         AS Student_Name,
    p.Salary_Package,
    c.Company_Name,
    j.Job_Title,
    p.Status
FROM Students s
RIGHT JOIN Placements p  ON s.Student_ID = p.Student_ID
RIGHT JOIN Companies c   ON p.Company_ID = c.Company_ID
RIGHT JOIN Job_Postings j ON p.Job_ID    = j.Job_ID
ORDER BY Student_ID;


-- ============================================================
-- SUMMARY OF JOIN TYPES USED
-- ============================================================
/*
| Join Type   | Records Returned                                      |
|-------------|-------------------------------------------------------|
| INNER JOIN  | Only students WITH matching applications               |
| LEFT JOIN   | ALL students, NULLs for those with no applications    |
| RIGHT JOIN  | ALL companies, NULLs for those with no job postings   |
| FULL JOIN   | ALL students + ALL placements (union approach)        |
*/

