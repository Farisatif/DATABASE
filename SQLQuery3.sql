CREATE TABLE employee (

id int primary key identity (1,1),
name nvarchar (20) not null ,
gender nvarchar (20)not null,
salary nvarchar(10)not null,
dep_id int 

)

INSERT INTO employee VALUES('Fares','Male','$10000',null),
						   ('Ahmed','Male','$200',1),
						   ('Nami','Fimale','$100',4),
						   ('Ali','Male','$1',2),
						   ('Mohammed','Male','$5',3);

SELECT * FROM employee;

create view vShow 
as 
select e.id , e.gender , e.salary , e.dep_id
from employee e 

select * from vShow;
 
INSERT INTO vShow VALUES ('Abood','Male','$0',1);

create table department(

dep_id int primary key,
dep_name nvarchar (20)

);

INSERT INTO department VALUES (1,'IT'),
							  (2,'HR'),
							  (3,'SE'),
							  (4,'AI');

CREATE view vWAllempBYdep
as
SELECT e.id , e.name , e.gender ,e.salary , d.dep_name
from employee e
JOIN department d
ON 
e.dep_id = d.dep_id;

select * from vWAllempBYdep

insert into vWAllempBYdep values ('Lofy','Male','$9999',IT)

UPDATE vWAllempBYdep SET dep_name = 'HR' WHERE id = 3

Drop view vWAllempBYdep


