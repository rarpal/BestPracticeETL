

CREATE procedure [util].[up_SetDefaultFilegroup]
	 @fileGroup	sysname output
	,@logID		int = null	--ETL Load ID
	,@debug		bit = 0		--Debug mode?
with execute as caller
as
/**********************************************************************************************************
* SP Name:		
*		util.up_SetDefaultFilegroup
* Parameters:  
*		 @fileGroup	sysname output
*		,@logID		int = null	--ETL Load ID
*		,@debug		bit = 0		--Debug mode?
*
* Purpose: This stored procedure changes the default filegroup of the
*	current database. It accepts the new filegroup on the input parameter and
*	after the change passes the old filegroup out on the same parameter. This
*	is useful if the calling procedure later needs to change back to the original
*	filegroup (which is likely since this operation is global to the database)
*
* Example:
	declare @fg sysname
	set @fg = 'PRIMARY'
	exec util.up_SetDefaultFilegroup @fg out, 0, 1
	print @fg
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	set nocount on

	--Save the name of the current default filegroup
	declare @old varchar(50)
	select @old = [name] from sys.filegroups where is_default = 1

	--Convert to canonical form for simple comparisons
	set @filegroup = util.uf_GetCanonicalName(@filegroup, 1, 0)
	set @old = util.uf_GetCanonicalName(@old, 1, 0)

	--Only proceed if the default does actually need changing
	if @fileGroup <> @old begin
		--Construct tsql statement
		declare @sql varchar(500)
		set @sql = 
		' alter database ' + db_name() + 
		' modify filegroup ' + @filegroup +
		' default'

		--Execute and log the dynamic SQL
		exec util.up_ExecuteSQL 'Change Default Filegroup', @sql, @logID, @debug
	end --if

	--Return the old filegroup to the caller
	set @fileGroup = @old

	set nocount off
end --if