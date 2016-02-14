
CREATE function [audit].[uf_GetExecutionLogTree](
	 @logID			int
	,@fromRoot		bit = 0
) 
returns table
--with execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*	part.uf_GetExecutionLogTree
* Parameters:
*	 @logID			int
*	,@fromRoot		bit = 0
*
* Purpose: This function returns the execution log tree that the specified node belongs to,
*	either the subtree starting from the node, or the whole tree from the root.
*
* Example:
	select * from audit.ExecutionLog order by LogID desc
	select * from audit.uf_GetExecutionLogTree(3, 1)
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
return
(
	--Derive result using a CTE as the table is self-referencing
	with graph as (
		--select the anchor (specified) node
		select *, 0 as Depth from audit.ExecutionLog
		where LogID = case @fromRoot
			when 1 then audit.uf_GetExecutionLogRoot(@logID)
			else @logID
		end --case
		--select the child nodes
		union all
		select leaf.*, Depth + 1 from audit.ExecutionLog as leaf
		inner join graph as node on (node.LogID = leaf.ParentLogID)
	)
	select
		 *
		,datediff(ss, StartTime, EndTime) as Seconds
	from graph
) --function