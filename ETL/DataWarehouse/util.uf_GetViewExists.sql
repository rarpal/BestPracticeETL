




CREATE function [util].[uf_GetViewExists](
	 @schemaName	sysname
	,@viewName		sysname
)
returns bit
with returns null on null input,
execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		util.uf_GetViewExists
* Parameters:  
*		 @schemaName	sysname
*		,@viewName		sysname
*
* Purpose: This function checks the system tables to see if the specified
*	view exists. It is a simple wrapper over a basic query, though it does
*	allow case- and form-insensitive comparisons by converting the object
*	name to its uppercase-canonical form, eg Abc -> [ABC]
*
* Example:
	select util.uf_GetViewExists('olap', 'vTbl_Dim_Buyer')
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	declare @result int

	--Convert to canonical form for simple comparisons
	set @schemaName = util.uf_GetCanonicalName(@schemaName, 1, 0)
	set @viewName = util.uf_GetCanonicalName(@viewName, 1, 0)

	--Derive result
	select 
		@result = 1
	from sys.views
	where @schemaName = util.uf_GetCanonicalName(schema_name(schema_id), 1, 0)
	and @viewName = util.uf_GetCanonicalName([name], 1, 0)

	--Return result
	return isnull(@result, 0)
end --function