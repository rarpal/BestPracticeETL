CREATE TABLE [audit].[CommandLog] (
    [LogID]     INT           NOT NULL,
    [CommandID] INT           IDENTITY (1, 1) NOT NULL,
    [Key]       VARCHAR (50)  NULL,
    [Type]      VARCHAR (50)  NULL,
    [Value]     VARCHAR (MAX) NULL,
    [LogTime]   DATETIME      CONSTRAINT [DF_ETL_CommandLog_LogTime] DEFAULT (getdate()) NULL
);


GO
CREATE CLUSTERED INDEX [CIX_CommandLog]
    ON [audit].[CommandLog]([LogID] ASC, [CommandID] ASC);

