
create procedure [audit].[up_ClearLogs]
with execute as caller
as
begin
	set nocount on

	truncate table audit.CommandLog
	truncate table audit.ExecutionLog
	truncate table audit.ProcessLog
	truncate table audit.StatisticLog
	truncate table dbo.sysdtslog90
	truncate table audit.RejectsLog

	set nocount off
end --proc