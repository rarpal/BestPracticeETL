



CREATE function [util].[uf_GetTableExists](
	 @schemaName	sysname
	,@tableName		sysname
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
*		,@tableName		sysname
*
* Purpose: This function checks the system tables to see if the specified
*	table exists. It is a simple wrapper over a basic query, though it does
*	allow case- and form-insensitive comparisons by converting the object
*	name to its uppercase-canonical form, eg Abc -> [ABC]
*
* Example:
	select util.uf_GetTableExists('dbo', '[Tbl_Fact_DC_Inventory_WE_2004_12_18]')
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	declare @result int

	--Convert to canonical form for simple comparisons
	set @schemaName = util.uf_GetCanonicalName(@schemaName, 1, 0)
	set @tableName = util.uf_GetCanonicalName(@tableName, 1, 0)

	--Derive result
	select 
		@result = 1
	from sys.tables 
	where util.uf_GetCanonicalName(schema_name(schema_id), 1, 0) = @schemaName
	and util.uf_GetCanonicalName([name], 1, 0) = @tableName

	--Return result
	return isnull(@result, 0)
end --function