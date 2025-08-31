CREATE DATABASE H2
USE H2
CREATE TABLE teacher (
    id INT PRIMARY KEY,
    name NVARCHAR(50),
    email NVARCHAR(100),
    salary INT
);


CREATE TABLE teacher_logs (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    teacher_id INT,
    operation NVARCHAR(20),
    old_email NVARCHAR(100),
    new_email NVARCHAR(100),
    old_salary INT,
    new_salary INT,
    log_time DATETIME
);

CREATE TRIGGER tr_teacher_update
ON teacher
AFTER UPDATE
AS
BEGIN
    INSERT INTO teacher_logs (teacher_id, operation, old_email, new_email, old_salary, new_salary, log_time)
    SELECT
        d.id,
        'UPDATE',
        d.email,
        i.email,
        d.salary,
        i.salary,
        GETDATE()
    FROM deleted d
    JOIN inserted i ON d.id = i.id;
END;

CREATE TRIGGER tr_teacher_delete
ON teacher
AFTER DELETE
AS
BEGIN
    INSERT INTO teacher_logs (teacher_id, operation, old_email, new_email, old_salary, new_salary, log_time)
    SELECT
        d.id,
        'DELETE',
        d.email,
        NULL,
        d.salary,
        NULL,
        GETDATE()
    FROM deleted d;
END;



CREATE TRIGGER tr_teacher_insert
ON teacher
AFTER INSERT
AS
BEGIN
    INSERT INTO teacher_logs (teacher_id, operation, new_email, new_salary, log_time)
    SELECT
        d.id,
        'INSERT',
        d.email,
        d.salary,
        GETDATE()
    FROM inserted d;
END;

INSERT INTO teacher VALUES (4,'Omar','os@gmail.com',3000);

UPDATE teacher 
SET email = 'osa@gmail.com', salary = 10000 
WHERE id = 3;

DELETE FROM teacher WHERE id = 3;

SELECT * FROM teacher_logs;
