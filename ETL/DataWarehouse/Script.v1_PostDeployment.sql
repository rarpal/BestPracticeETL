/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF EXISTS ( 
	SELECT 1 FROM sys.columns
	WHERE [name] = 'KeyValue' AND OBJECT_NAME(object_id('audit.RejectsLog')) = 'RejectsLog' 
) 
BEGIN
	UPDATE audit.RejectsLog SET
		KeyField = SUBSTRING(KeyValue, 1, CHARINDEX(':',KeyValue) -1),
		KeyFieldValue = SUBSTRING(KeyValue, CHARINDEX(':',KeyValue) +1, 50)

	IF EXISTS (
		SELECT 1 FROM sys.indexes
		WHERE [name] = 'cix_RejectsLog' AND OBJECT_NAME(object_id('audit.RejectsLog')) = 'RejectsLog'
	)
	BEGIN
		DROP INDEX cix_RejectsLog ON audit.RejectsLog
		CREATE CLUSTERED INDEX cix_RejectsLog ON audit.RejectsLog (LogID, KeyFieldValue)
	END

	ALTER TABLE audit.RejectsLog DROP COLUMN KeyValue
END

