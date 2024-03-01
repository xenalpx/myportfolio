CREATE TABLE PROJECT
(
ProjectID INT GENERATED BY DEFAULT AS IDENTITY START WITH 1,
Project_Name VARCHAR2(30) NOT NULL,
Project_Start_Date DATE NOT NULL,
Project_End_Date DATE NOT NULL,
Project_Estimated_Cost NUMBER(10,2) NOT NULL,
Project_Actual_Cost NUMBER(10,2) NOT NULL,
CONSTRAINT PK_Project PRIMARY KEY(ProjectID),
CONSTRAINT U_Project UNIQUE (Project_Name)
);

CREATE TABLE DIVISION
(
DivisionID INT GENERATED BY DEFAULT AS IDENTITY START WITH 1,
DivisionName VARCHAR2(30) NOT NULL,
EmployeeID INT,
CONSTRAINT PK_Division PRIMARY KEY(DivisionID),
CONSTRAINT U_Division UNIQUE (DivisionName)
);


CREATE TABLE DEPARTMENT
(
DepartmentID INT GENERATED BY DEFAULT AS IDENTITY START WITH 1,
DepartmentName VARCHAR2(30) NOT NULL,
DivisionID INT NOT NULL,
EmployeeID INT,
CONSTRAINT PK_Department PRIMARY KEY(DepartmentID),
CONSTRAINT U_Department UNIQUE (DepartmentName),
CONSTRAINT FK_Department FOREIGN KEY (DivisionID) REFERENCES DIVISION(DivisionID)
);

CREATE TABLE EMPLOYEE
(
EmployeeID INT GENERATED BY DEFAULT AS IDENTITY START WITH 1,
EmployeeFName VARCHAR2(30) NOT NULL,
EmployeeLName VARCHAR2(30) NOT NULL,
EmployeeEmail VARCHAR2(50) NOT NULL,
DepartmentID INT,
CONSTRAINT PK_Employee PRIMARY KEY(EmployeeID),
CONSTRAINT Unique_EMail UNIQUE (EmployeeEmail),
CONSTRAINT FK_Employee FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

CREATE TABLE PROJECT_ASSIGNMENT
(
EmployeeID INT NOT NULL,
ProjectID INT NOT NULL,
Project_Role VARCHAR2(50) NOT NULL,
CONSTRAINT PK_Project_Assignment PRIMARY KEY (EmployeeID, ProjectID),
CONSTRAINT FK_Employee1 FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID),
CONSTRAINT FK_Employee2 FOREIGN KEY (ProjectID) REFERENCES PROJECT(ProjectID)
);

ALTER TABLE DIVISION
ADD CONSTRAINT FK_DIVISION_EMPLOYEEid FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID);


ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_EMPLOYEEid FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID);

ALTER TABLE division drop CONSTRAINT FK_DIVISION_EMPLOYEEID;
ALTER TABLE department drop CONSTRAINT FK_DEPARTMENT;
ALTER TABLE department drop CONSTRAINT FK_DEPARTMENT_EMPLOYEEID;
ALTER TABLE employee drop CONSTRAINT FK_EMPLOYEE;


drop table division;
drop table department;
drop table project_assignment;
drop table employee;
drop table project;