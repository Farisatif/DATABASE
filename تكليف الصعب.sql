 
CREATE TABLE employee (

id int primary key identity (1,1),
name nvarchar (20) not null ,
gender nvarchar (20)not null,
salary nvarchar(10)not null,
dep_id int forgin key r ,


)

INSERT INTO employee VALUES('Fares','Male','$10000',null),
						   ('Ahmed','Male','$200',1),
						   ('Nami','Fimale','$100',4),
						   ('Ali','Male','$1',2),
						   ('Mohammed','Male','$5',3);

SELECT * FROM employee;

create table department(

dep_id int primary key,
dep_name nvarchar (20)

);
INSERT INTO department VALUES (1,'IT'),
							  (2,'HR'),
							  (3,'SE'),
							  (4,'AI');

create view vShow 
as 
select e.id , e.gender , e.salary , e.dep_id
from employee e 

select * from vShow;
 
INSERT INTO vShow VALUES ('Abood','Male','$0',1);



CREATE view vWAllempBYdep
as
SELECT e.id , e.name , e.gender ,e.salary , d.dep_name
from employee e
JOIN department d
ON 
e.dep_id = d.dep_id;

select * from vWAllempBYdep



alter TRIGGER tr_vWAllempBYdep
on vWAllempBYdep
instead of insert 
as
begin
declare @dep_id int 
select @dep_id = dep_id from department
join inserted on inserted.dep_name = department.dep_name

if (@dep_id is null)
begin
Raiserror('Dpartment is not exit',16,1)
return
end 

insert into employee (name,gender,salary.dep_id)
select name,gender,salary,@dep_id
from inserted
end 
insert into vWAllempBYdep (name,gender,salary,dep_id)
values ('Lofy','Male','$9999',IT)



insert into vWAllempBYdep values ('Lofy','Male','$9999',IT)

UPDATE vWAllempBYdep SET dep_name = 'HR' WHERE id = 3

Drop view vWAllempBYdep


