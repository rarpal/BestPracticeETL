CREATE TABLE [audit].[ProcessLog] (
    [LogID]         INT       NOT NULL,
    [RootTableName] [sysname] NOT NULL,
    [PartitionDate] DATETIME  NOT NULL
);


GO
CREATE CLUSTERED INDEX [CIX_ProcessLog]
    ON [audit].[ProcessLog]([LogID] ASC);

