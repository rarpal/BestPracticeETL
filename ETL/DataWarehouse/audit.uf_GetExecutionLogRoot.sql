


CREATE function [audit].[uf_GetExecutionLogRoot](@logID int)
returns int
with returns null on null input,
execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		part.uf_GetDatabaseIsPartitioned
* Parameters:
*
* Purpose: This function returns the root of the execution log tree that the specified 
*	node belongs to.
*
* Example:
	select audit.uf_GetExecutionLogRoot(3)
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	declare @rootID int

	--Derive result using a CTE as the table is self-referencing
	;with graph as (
		--select the anchor (specified) node
		select LogID, ParentLogID from audit.ExecutionLog where LogID = @logID
		union all
		--select the parent node
		select node.LogID, node.ParentLogID from audit.ExecutionLog as node
		inner join graph as leaf on (node.LogID = leaf.ParentLogID)
	)
	select @rootID = LogID from graph where ParentLogID is null
	
	--Return result
	return isnull(@rootID, @logID)
end --function