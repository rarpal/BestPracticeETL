CREATE TABLE [audit].[ValidationLog]
(
	[LogID] INT NOT NULL , 
    [ComponentName] VARCHAR(50) NOT NULL, 
    [ValidationName] VARCHAR(50) NOT NULL, 
    [Description] VARCHAR(1000) NULL, 
    [severity] SMALLINT NOT NULL, 
    [LogTime] DATETIME NOT NULL
)

GO

CREATE CLUSTERED INDEX [cix_ValidationLog] ON [audit].[ValidationLog] ([LogID])
