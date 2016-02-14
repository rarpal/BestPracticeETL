CREATE TABLE [audit].[ExecutionLog] (
    [LogID]         INT              IDENTITY (1, 1) NOT NULL,
    [ParentLogID]   INT              NULL,
    [Description]   VARCHAR (50)     NULL,
    [PackageName]   VARCHAR (50)     NOT NULL,
    [PackageGuid]   UNIQUEIDENTIFIER NOT NULL,
    [MachineName]   VARCHAR (50)     NOT NULL,
    [ExecutionGuid] UNIQUEIDENTIFIER NOT NULL,
    [LogicalDate]   DATETIME         NOT NULL,
    [Operator]      VARCHAR (50)     NOT NULL,
    [StartTime]     DATETIME         NOT NULL,
    [EndTime]       DATETIME         NULL,
    [Status]        TINYINT          NOT NULL,
    [FailureTask]   VARCHAR (64)     NULL,
    CONSTRAINT [PK_ExecutionLog] PRIMARY KEY CLUSTERED ([LogID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ExecutionLog_ParentLogID]
    ON [audit].[ExecutionLog]([ParentLogID] ASC);

