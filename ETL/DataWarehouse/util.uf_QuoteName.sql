




CREATE function [util].[uf_QuoteName](
	 @name		sysname
)
returns sysname
with returns null on null input,
execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		util.uf_QuoteName
* Parameters:  
*		 @name		sysname
*
* Purpose: This function adds quotes to the value passed in, unless it is already quoted.
*	While in Project REAL we have no need to worry about SQL Injection, this code will
*	be released as best-practice examples of how TSQL should be written and as such it
*	is important to include SQL injection-mitigation methods.
*
* Example:
	select util.uf_QuoteName('abc')
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	--If @name is not already quoted then quote it
	if @name not like '[[]%]' set @name = quotename(@name)

	--Return result
	return @name
end --function