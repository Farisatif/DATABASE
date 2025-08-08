create database data4;

use lap4

CREATE TABLE Customer (
    c_ID INT PRIMARY KEY identity (1,1) ,
    c_Name NVARCHAR(50) NOT NULL,
    c_email NVARCHAR(50)NOT NULL,
	c_acount int NOT NULL,
	c_gander NVARCHAR(50)
);
INSERT INTO Customer VALUES('Fares','Fares@gmail.com',200000,'Male'),
                           ('Ahmed','Ahmed@gmail.com',56700,'Male'),
                           ('Ali','Ali@gmail.com',900000,'Male'),
                           ('Nami','Nami@gmail.com',5000,'Female'),
                           ('Robin','Robin@gmail.com',797097,'Female');

select * from Customer ;

create view vwCustomer as
select * from Customer go;

select * from vwCustomer ;

CREATE PROC show_customers
as
begin
select * from Customer
end

exec show_customers


CREATE PROC Add_Customer 
@c_name nvarchar(50),
@c_email nvarchar(50),
@c_acount int,
@c_gander NVARCHAR(50)
as
BEGIN 
INSERT INTO Customer VALUES (@c_name, @c_email, @c_acount , @c_gander)
END

EXEC Add_Customer 'fares','faresatif@gmail.com',10000,'Male'

EXEC show_customers 




alter PROC UpCustomer 
@c_ID int,
@c_name nvarchar(50),
@c_email nvarchar(50),
@c_acount int,
@c_gander NVARCHAR(50)

AS
BEGIN
    UPDATE Customer
    SET 
   
        c_name = @c_name,
        c_email = @c_email,
        c_gander = @c_gander,
        c_acount = @c_acount
    WHERE c_ID = @c_ID;
END;

EXEC UpCustomer  4,'ban' , 'b@gmail.com',20000,'male'
