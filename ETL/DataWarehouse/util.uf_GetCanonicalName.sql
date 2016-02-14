



CREATE function [util].[uf_GetCanonicalName](
	 @name			sysname	--main parameter
	,@upper			bit		--uppercase @name?
	,@compress		bit		--create a hash-string out of @name?
)
returns sysname
with returns null on null input,
execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		util.uf_GetCanonicalName
* Parameters:  
*		 @name			sysname	--main parameter
*		,@upper			bit		--uppercase @name?
*		,@compress		bit		--create a hash-string out of @name?
*
* Purpose: This function returns the canonical name for a database object. The reason we
*	need this is so that we can make comparisons of objects without worrying about case
*	and form. Converting all objects to a common representation makes comparisons trivial.
*	We define the canonical form as quoted. The function also allows upper-casing and
*	compression which removed vowels and underscores. The latter feature is useful for
*	creating a simple hash.
*
* Example:
	select util.uf_GetCanonicalName('Tbl_Fact_Store_Sales', 1, 0)
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	set @name = nullif(ltrim(rtrim(@name)), '')

	if @name like '[[]%]' and len(@name) = 2 
		set @name = null
	else if @name is not null begin
		if @compress = 1 begin --Optionally remove vowels and _
			set @name = replace(@name, '_', '')
			set @name = replace(@name, 'A', '')
			set @name = replace(@name, 'E', '')
			set @name = replace(@name, 'I', '')
			set @name = replace(@name, 'O', '')
			set @name = replace(@name, 'U', '')
		end --if
		if @name = '' set @name = null
		else set @name = util.uf_QuoteName(upper(@name))
	end --if

	return @name
end --function