CREATE TABLE [audit].[RejectsLog]
(
	[LogID] INT NOT NULL , 
    [ComponentName] VARCHAR(50) NOT NULL, 
    [KeyValue] VARCHAR(50) NOT NULL, 
    [RowNumber] BIGINT NOT NULL, 
    [Rejects] VARCHAR(1000) NULL, 
    [LogTime] DATETIME NOT NULL 
)

GO

CREATE CLUSTERED INDEX [cix_RejectsLog] ON [audit].[RejectsLog] ([LogID], [KeyValue])
