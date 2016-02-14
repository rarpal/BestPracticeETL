create function [audit].[uf_Progress]()
returns table
--with execute as caller
as
-- select * from audit.uf_Progress()
return(
	with cte as (
		select 
			 f.LogID 
			,f.ParentLogID
			,space(f.depth * 4) + f.PackageName as 'PackageName'
			,convert(varchar(10), f.LogicalDate, 102) as 'LogicalDate'
			,f.StartTime
			,f.EndTime
			,f.Seconds
			,convert(varchar, f.Seconds / 60) + ':' + right('00' + convert(varchar, f.Seconds % 60), 2) as 'Time'
			,case f.Status
				when 1 then 'OK'
				when 2 then 'Failed'
				else 'Processing'
			end as 'Status'
		from audit.ExecutionLog t
		cross apply audit.uf_GetExecutionLogTree(t.LogID, 0) f
		where t.ParentLogID is null
	)
	select top (100) percent
		 c.LogID 
		,c.ParentLogID
		,c.PackageName
		,c.LogicalDate
		,c.StartTime
		,c.EndTime
		,c.Status
	--	,c.FailureTask
		,s.Rows
		,c.[Time]
	--	,s.TimeMS
		,case when nullif(c.seconds, 0) is null then null else s.Rows / c.seconds end as 'OverallRps'
		,s.MinRowsPerSec as MinRps
		,s.MeanRowsPerSec as MeanRps
		,s.MaxRowsPerSec as MaxRps
	from
		cte c
	left join 
		audit.StatisticLog s on c.LogID = s.LogID and s.ComponentName = 'STAT Source'
	order by
		c.LogID
)