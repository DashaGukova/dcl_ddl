USE [master]
GO
CREATE DATABASE TestBd
GO
USE TestBd
GO
CREATE SCHEMA TestSchema
GO
CREATE TABLE TestSchema.TestTable(
Id INT NOT NULL,
Name VARCHAR(20),
IsSold BIT,
InvoiceDate DATE)
GO
USE TestBd
GO
INSERT INTO TestSchema.TestTable
VALUES
(1, 'Boat', 1, '2020-11-08'),
(2,'Auto', 0, '2020-11-09'),
(3,'Plane', null, '2020-12-09')
GO
USE TestBd
GO
EXEC sp_configure 'CONTAINED DATABASE AUTHENTICATION', 1;
GO
RECONFIGURE;
GO
USE [master]
GO
ALTER DATABASE TestBd SET CONTAINMENT = PARTIAL;
GO
USE TestBd
GO
EXECUTE AS USER = 'TestUser' -- it allows to use testuser without reconnection during the current session
GO
SELECT * FROM TestBd.TestSchema.TestTable
CREATE USER TestUser WITH PASSWORD = 'cvb@4UFREE'
GO
USE TestBd
GO
GRANT CONNECT ON DATABASE::TestBd TO TestUser
GO
REVERT
GRANT SELECT ON OBJECT::TestSchema.TestTable TO TestUser
GO
USE TestBd
GO
EXECUTE AS USER = 'TestUser' -- it allows to use testuser without reconnection during the current session
GO
SELECT * FROM TestBd.TestSchema.TestTable
SELECT CURRENT_USER
REVERT
USE TestBd
GO
DROP USER TestUser
GO
