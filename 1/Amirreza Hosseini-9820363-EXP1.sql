--Amirreza Hosseini 9820363 EXP1

------initial
CREATE TABLE Departments (
	Name VARCHAR ( 20 ) NOT NULL,
	ID CHAR ( 5 ) PRIMARY KEY,
	Budget NUMERIC ( 12, 2 ),
Category VARCHAR ( 15 ) CHECK ( Category IN ( 'Engineering', 'Science' ) ) 
);

----
CREATE TABLE Teachers (
	FirstName VARCHAR ( 20 ) NOT NULL,
	LastName VARCHAR ( 30 ) NOT NULL,
	ID CHAR ( 7 ),
	BirthYear INT,
	DepartmentID CHAR ( 5 ),
	Salary NUMERIC ( 7, 2 ) DEFAULT 10000.00,
	PRIMARY KEY ( ID ),
	FOREIGN KEY ( DepartmentID ) REFERENCES Departments ( ID ),

);

----
CREATE TABLE Students (
	FirstName VARCHAR ( 20 ) NOT NULL,
	LastName VARCHAR ( 30 ) NOT NULL,
	StudentNumber CHAR ( 7 ) PRIMARY KEY,
	BirthYear INT,
	DepartmentID CHAR ( 5 ),
	AdvisorID CHAR ( 7 ),
	FOREIGN KEY ( DepartmentID ) REFERENCES Departments ( ID ),
	FOREIGN KEY ( AdvisorID ) REFERENCES Teachers ( ID ) 
);

--------Q1-1
ALTER TABLE Students
ADD credit INT;


--------Q1-2
CREATE TABLE Courses (
	ID CHAR ( 5 ) PRIMARY KEY,
	Title VARCHAR ( 20 ) NOT NULL,
	Credits INT DEFAULT 0,
	DepartmentID CHAR ( 5 ),
	FOREIGN KEY ( DepartmentID ) REFERENCES Departments ( ID ),
);

-------Q1-3
CREATE TABLE Available_Courses (
	CourseID CHAR ( 5 ) NOT NULL,
	Semester VARCHAR ( 15 ) CHECK ( Semester IN ( 'fall', 'Spring' ) ),
	YEAR VARCHAR ( 10 ),
	ID CHAR ( 5 ) PRIMARY KEY,
	TeacherID CHAR ( 7 ) NOT NULL,
	FOREIGN KEY ( CourseID ) REFERENCES Courses ( ID ),
	FOREIGN KEY ( TeacherID ) REFERENCES Teachers ( ID ),
);

-------Q1-4
CREATE TABLE Taken_Courses (
	StudentID CHAR ( 7 ) NOT NULL,
	CourseID CHAR ( 5 ) NOT NULL,
	Semester VARCHAR ( 15 ) CHECK ( Semester IN ( 'fall', 'Spring' ) ),
	YEAR VARCHAR ( 10 ),
	Grade NUMERIC ( 4, 2 ) DEFAULT 0,
	FOREIGN KEY ( CourseID ) REFERENCES Courses ( ID ),
	FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentNumber ),
	PRIMARY KEY ( StudentID, CourseID, Semester, YEAR ),
);

-------Q1-5
CREATE TABLE Prerequisites (
	CourseID CHAR ( 5 ) NOT NULL,
	PrereqID CHAR ( 5 ) NOT NULL,
	FOREIGN KEY ( CourseID ) REFERENCES Courses ( ID ),
	PRIMARY KEY ( PrereqID, CourseID ),

);


-----inserting into tables
INSERT INTO Students (FirstName , LastName, StudentNumber,BirthYear, DepartmentID,AdvisorID,credit) VALUES ('ali','aliyari','123',1377,NULL, NULL ,108);
INSERT INTO Students (FirstName , LastName, StudentNumber,BirthYear, DepartmentID,AdvisorID,credit) VALUES ('ahmad','fatolahi','19823',1370,NULL, NULL ,100);
INSERT INTO Students (FirstName , LastName, StudentNumber,BirthYear, DepartmentID,AdvisorID,credit) VALUES ('kiavash','rabani','222',1379,NULL, NULL ,50);
INSERT INTO Students (FirstName , LastName, StudentNumber,BirthYear, DepartmentID,AdvisorID,credit) VALUES ('zahra','ghorbani','1234',1379,NULL, NULL ,53);
INSERT INTO Students (FirstName , LastName, StudentNumber,BirthYear, DepartmentID,AdvisorID,credit) VALUES ('elham','abedin','3333',1279,NULL, NULL ,53);


INSERT INTO Departments (Name, ID ,Budget,Category ) VALUES ('Math','222',100000000.00,'Science');
INSERT INTO Departments (Name, ID ,Budget,Category ) VALUES ('Physics','333',100000000.00,'Science');
INSERT INTO Departments (Name, ID ,Budget,Category ) VALUES ('Comp-sci','125',100000000.00,'Engineering');
INSERT INTO Departments (Name, ID ,Budget,Category ) VALUES ('Mechanics','111',100000000.00,'Engineering');
INSERT INTO Departments (Name, ID ,Budget,Category ) VALUES ('Electrical','12345',100000000.00,'Engineering');


UPDATE Students
SET DepartmentID = '12345'
WHERE StudentNumber='123';


SELECT Departments.Name,Departments.ID,Departments.Budget,Departments.Category
FROM Departments INNER JOIN Students ON (Students.DepartmentID= Departments.ID);


INSERT INTO Courses (ID,Title,Credits,DepartmentID) VALUES ('18','BP',4,'12345');
INSERT INTO Courses (ID,Title,Credits,DepartmentID) VALUES ('12','AP',4,'12345');
INSERT INTO Courses (ID,Title,Credits,DepartmentID) VALUES ('15','DB',3,'12345');
INSERT INTO Courses (ID,Title,Credits,DepartmentID) VALUES ('14','DM',3,'12345');
INSERT INTO Courses (ID,Title,Credits,DepartmentID) VALUES ('20','Statics',3,'125');
INSERT INTO Courses (ID,Title,Credits,DepartmentID) VALUES ('28','signal',3,'125');


INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('222','14','fall',1378,19.8);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('222','20','spring',1378,16.8);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('123','18','fall',2017,18);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('123','12','spring',2018,15);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('123','15','spring',2020,19);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('123','14','fall',2019,10);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('1234','20','fall',2017,19);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('1234','28','spring',2018,13);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('1234','14','fall',2019,16);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('19823','15','fall',2012,15);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('19823','12','spring',2018,11);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('19823','20','spring',2018,20);
INSERT INTO Taken_Courses(StudentID,CourseID,Semester,[Year],Grade) VALUES('19823','14','fall',2013,17);

INSERT INTO Teachers(FirstName,LastName,ID,BirthYear,DepartmentID,Salary) VALUES('nader','karbasi','1',1970,'125',DEFAULT);
INSERT INTO Teachers(FirstName,LastName,ID,BirthYear,DepartmentID,Salary) VALUES('navid','irani','2',1970,'125',DEFAULT);
INSERT INTO Teachers(FirstName,LastName,ID,BirthYear,DepartmentID,Salary) VALUES('aref','koohsar','3',1970,'222',20000.0);

INSERT INTO Prerequisites(CourseId,PrereqID) VALUES('18','1');
INSERT INTO Prerequisites(CourseId,PrereqID) VALUES('28','2');
INSERT INTO Prerequisites(CourseId,PrereqID) VALUES('18','3');
INSERT INTO Prerequisites(CourseId,PrereqID) VALUES('20','7');
INSERT INTO Prerequisites(CourseId,PrereqID) VALUES('15','87');

INSERT INTO Available_Courses(CourseID,Semester,Year,ID,TeacherID) VALUES('20','spring',2020,'1','2');
INSERT INTO Available_Courses(CourseID,Semester,Year,ID,TeacherID) VALUES('15','fall',2020,'2','3');
INSERT INTO Available_Courses(CourseID,Semester,Year,ID,TeacherID) VALUES('28','spring',2020,'3','2');


------Q2-1
SELECT *
FROM Students
WHERE Students.StudentNumber='123'

-----Q2-2
SELECT
	StudentID,
	CourseID,
	Semester,
	[Year],
	Grade + 1 as new_grade
FROM
	Taken_Courses 
WHERE
	Grade + 1 < 20;
	
-----Q2-3
SELECT DISTINCT
	FirstName,
	LastName,
	StudentNumber 
FROM
	Students
	LEFT JOIN Taken_Courses ON ( Students.StudentNumber= Taken_Courses.StudentID ) 
WHERE
	( StudentNumber not in ( SELECT StudentID FROM Taken_Courses WHERE CourseID = '15' ) );

