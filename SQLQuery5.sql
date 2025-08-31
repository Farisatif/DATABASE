create database lap8;


CREATE TABLE Authors(

ID INT primary key IDENTITY (1,1) ,
Name NVARCHAR (30) NOT NULL ,
Gmail NVARCHAR (100) NOT NULL,
Salary INT  NOT NULL,
Date NVARCHAR (15) NOT NULL

)


CREATE TABLE Pitzsa(

ID INT PRIMARY KEY IDENTITY (1,1),
data_P NVARCHAR (1000),


)

drop table Pitzsa

INSERT INTO Authors values ('MARSEDAS','MARSEDAS@gmail.com',2000,'2005-2-2'),
					   ('TYOTA','TYOTA@gmail.com',2001,'2005-2-3'),
					   ('FUJITSU','FUJITSU@gmail.com',2002,'2005-2-4')

					   alter TRIGGER tr_Authors
					   on Authors
					   AFTER INSERT 
					   AS 
					   BEGIN
					   DECLARE @id int,
					   @Name nvarchar (30)
					   select @id = ID , @Name = Name from inserted
					   INSERT INTO Pitzsa values ('ID = ' + CAST(@id as nvarchar(30)) + ' With Name = ' + @Name + ' IN Date : ' +
					   CAST(GETDATE() as nvarchar (40))
					   );
					   END 

					   Create TRIGGER tr_Authors_Deleteed
					   on Authors
					   AFTER DElete 
					   AS 
					   BEGIN
					   DECLARE @id int,
					   @Name nvarchar (30)
					   select @id = ID , @Name = Name from deleted
					   INSERT INTO Pitzsa values ('Deleted ID = ' + CAST(@id as nvarchar(30)) + ' With Name = ' + @Name + ' IN Date : ' +
					   CAST(GETDATE() as nvarchar (40))
					   );
					   END 

					   Create TRIGGER tr_Authors_Up
					   on Authors
					   AFTER Update 
					   AS 
					   BEGIN
					   DECLARE @id int,
					   @Name nvarchar (30)
					   select @id = ID , @Name = Name from deleted inserted
					   INSERT INTO Pitzsa values ('Updata ID = ' + CAST(@id as nvarchar(30)) + ' With Name = ' + @Name + ' IN Date : ' +
					   CAST(GETDATE() as nvarchar (40))
					   
					   );
					   END 

					   INSERT INTO Authors values ('FAres','F@gmail.com',2000,'20220-02-14')
					   INSERT INTO Authors values ('FAres2','F@gmail.com',2000,'20220-02-14')
					   delete from Authors where ID = 5
					   Update Authors set Name = 'MARSEDAS' where ID = 1

drop trigger tr_Authors
select * from Pitzsa
select * from Authors