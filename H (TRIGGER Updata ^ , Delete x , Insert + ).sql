CREATE DATABASE ZerCOINE;
GO

USE ZerCOINE;
GO

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME2 DEFAULT SYSDATETIME()
);
GO

CREATE TABLE wallets (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    address NVARCHAR(100) NOT NULL UNIQUE,
    balance DECIMAL(18,8) DEFAULT 0 CHECK (balance >= 0),
    last_used DATETIME2 NULL,
    CONSTRAINT fk_wallets_users FOREIGN KEY (user_id) REFERENCES users(id)
);
GO

CREATE TABLE transactions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    from_wallet INT NULL,
    to_wallet INT NULL,
    amount DECIMAL(18,8) NOT NULL CHECK (amount > 0),
    status NVARCHAR(20) DEFAULT 'pending',
    created_at DATETIME2 DEFAULT SYSDATETIME(),
    CONSTRAINT fk_transactions_from_wallet FOREIGN KEY (from_wallet) REFERENCES wallets(id),
    CONSTRAINT fk_transactions_to_wallet FOREIGN KEY (to_wallet) REFERENCES wallets(id)
);
GO

CREATE TABLE audit_log (
    id INT IDENTITY(1,1) PRIMARY KEY,
    action NVARCHAR(100),
    info NVARCHAR(MAX),
    created_at DATETIME2 DEFAULT SYSDATETIME()
);
GO

CREATE OR ALTER VIEW vw_wallets_overview
AS
SELECT w.id AS wallet_id, w.address, u.username, w.balance, w.last_used
FROM wallets w
LEFT JOIN users u ON w.user_id = u.id;
GO

CREATE OR ALTER PROCEDURE sp_transfer_simple
    @from_wallet INT,
    @to_wallet INT,
    @amount DECIMAL(18,8)
AS
BEGIN
    SET NOCOUNT ON;
    IF @amount <= 0 THROW 60000,'Amount must be positive',1;
    IF NOT EXISTS(SELECT 1 FROM wallets WHERE id = @from_wallet) THROW 60001,'From wallet not found',1;
    IF NOT EXISTS(SELECT 1 FROM wallets WHERE id = @to_wallet) THROW 60002,'To wallet not found',1;

    BEGIN TRAN ZerCoinTran;
    BEGIN TRY
        UPDATE wallets
        SET balance = balance - @amount, last_used = SYSDATETIME()
        WHERE id = @from_wallet AND balance >= @amount;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK TRAN ZerCoinTran;
            THROW 60003,'Insufficient funds',1;
        END

        UPDATE wallets
        SET balance = balance + @amount, last_used = SYSDATETIME()
        WHERE id = @to_wallet;

        INSERT INTO transactions (from_wallet,to_wallet,amount,status,created_at)
        VALUES (@from_wallet,@to_wallet,@amount,'confirmed',SYSDATETIME());

        COMMIT TRAN ZerCoinTran;
        SELECT 'OK' AS result;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRAN ZerCoinTran;
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER TRIGGER trg_after_insert_transactions
ON transactions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO audit_log (action, info, created_at)
    SELECT 'transaction_insert', CONCAT('tx_id=', id, ',from=', ISNULL(CONVERT(NVARCHAR(20), from_wallet),'NULL'), ',to=', ISNULL(CONVERT(NVARCHAR(20), to_wallet),'NULL'), ',amount=', CONVERT(NVARCHAR(50), amount)), SYSDATETIME()
    FROM inserted;
END;
GO

INSERT INTO users (username) VALUES ('alice'),('bob');
INSERT INTO wallets (user_id,address,balance) VALUES (1,'WALLET_ALICE',1000.00),(2,'WALLET_BOB',100.00);
GO

EXEC sp_transfer_simple @from_wallet = 1, @to_wallet = 2, @amount = 150.00;
GO

SELECT * FROM vw_wallets_overview;
SELECT * FROM transactions;
SELECT * FROM audit_log;
GO