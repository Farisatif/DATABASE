create database Home1;
use Home1;

CREATE TABLE EMP(

    EmpID INT PRIMARY KEY ,
	EmpName NVARCHAR (50),
	DeptID INT ,

);


INSERT INTO EMP VALUES (1,'Amjed',1),
								(2,'Manal',1),
								(3,'Zkaria',2),
								(4,'Qassem',4),
								(5,'Rami',3);


SELECT  E.EmpID AS ID, M.EmpName AS NAME 
FROM 
	EMP E
LEFT JOIN 
	EMP M ON E.DeptID = M.DeptID;
