CREATE TABLE [audit].[StatisticLog] (
    [LogID]          INT          NOT NULL,
    [ComponentName]  VARCHAR (50) NOT NULL,
    [Rows]           INT          NULL,
    [TimeMS]         INT          NULL,
    [MinRowsPerSec]  INT          NULL,
    [MeanRowsPerSec] AS           (case when isnull([TimeMS],(0))=(0) then NULL else CONVERT([int],([Rows]*(1000.0))/[TimeMS],(0)) end) PERSISTED,
    [MaxRowsPerSec]  INT          NULL,
    [LogTime]        DATETIME     CONSTRAINT [DF_ETL_StatisticLog_LogTime] DEFAULT (getdate()) NULL
);


GO
CREATE CLUSTERED INDEX [CIX_StatisticLog]
    ON [audit].[StatisticLog]([LogID] ASC);

