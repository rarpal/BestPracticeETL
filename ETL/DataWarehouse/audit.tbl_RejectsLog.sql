CREATE TABLE [audit].[RejectsLog]
(
	[LogID] INT NOT NULL , 
    [ComponentName] VARCHAR(50) NOT NULL, 
    [KeyValue] VARCHAR(50) NOT NULL, 
    [RowNumber] INT NOT NULL, 
    [Rejects] VARCHAR(1000) NULL, 
    [LogTime] DATETIME NOT NULL, 
    CONSTRAINT [cix_ReduceLog] PRIMARY KEY ([LogID], [KeyValue], [RowNumber])
)
