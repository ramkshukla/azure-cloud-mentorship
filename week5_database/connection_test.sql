-- Connection Test Script for Azure SQL Database
-- Executes basic queries to verify the SQL Server and database are reachable

SELECT 'Azure SQL Connection Successful!' AS Status;

-- Show server information
SELECT @@VERSION AS SqlServerVersion;

-- List all databases on the server
SELECT name, state_desc 
FROM sys.databases;

-- Switch to your target database and list objects
USE demoDB;
SELECT name, type_desc 
FROM sys.objects;

-- Final success message
SELECT 'Script completed successfully.' AS CompletionStatus;
