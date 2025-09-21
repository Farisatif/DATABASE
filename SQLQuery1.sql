create database Hehehe;
USE Hehehe;



create table Depaertments(
	DepID INT PRIMARY KEY,
	DepName NVARCHAR (50),
	Location NVARCHAR (50)
	);


create table Employee (

	EmpID INT PRIMARY KEY ,
	EmpName NVARCHAR (50),
	DeptID INT ,
	Salary DECIMAL (10,2),
	FOREIGN KEY (DeptID) REFERENCES Depaertments(DepID)

);

INSERT INTO Depaertments VALUES (1,'IT','ROUND ONE'),
								(2,'HR','ROUND TOW'),
								(3,'AI','ROUND THREE'),
								(4,'SE','ROUND FOUR');


INSERT INTO Employee VALUES (1,'Amjed',2,2345678.00),
								(2,'Manal',1,8000.00),
								(3,'Zkaria',null,70000.00),
								(4,'Qassem',4,567.00),
								(5,'Rami',4,200000.00);

								select * from Depaertments;
								select * from Employee;
(localdb)\MSSQLLocalDB
SELECT Depaertments.DepName ,Depaertments.Location , Employee.EmpID ,
Employee.EmpName ,Employee.DeptID , Employee.Salary  FROM Depaertments 
JOIN Employee
ON  Depaertments.DepID = Employee.DeptID;

SELECT Depaertments.DepName ,Depaertments.Location , Employee.EmpID ,
Employee.EmpName ,Employee.DeptID , Employee.Salary  FROM Depaertments 
LEFT JOIN Employee
ON  Depaertments.DepID = Employee.DeptID;

select d.DepName , d.Location , 
ISNULL (e.EmpName,'Dose Not Emp') as em_name,
ISNULL (e.DeptID,0),
ISNULL (e.Salary,000000.00)
FROM Depaertments d LEFT JOIN Employee e
ON d.DepID = e.DeptID;

SELECT ISNULL(Depaertments.DepName,'NO NAME') , ISNULL(Depaertments.Location,'NO LOCATION') , Employee.EmpID ,
Employee.EmpName ,ISNULL(CAST (Employee.DeptID AS NVARCHAR),'NO ID') , Employee.Salary  FROM Depaertments 
Right JOIN Employee
ON  Depaertments.DepID = Employee.DeptID;