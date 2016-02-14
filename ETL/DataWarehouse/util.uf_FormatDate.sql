

CREATE function [util].[uf_FormatDate](
	 @date			datetime
	,@seperator		varchar(1) = null)
returns varchar(10)
with execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		util.uf_FormatDate
* Parameters:  
*		 @date			datetime
*		,@seperator		varchar(1) = null)
*
* Purpose: This function returns a @date formatted with the specified seperators. This is 
*	useful when constructing object names that contain dates dynamically, eg
*	Tbl_Fact_Store_Sales_2004_12_25
*
* Example:
	select util.uf_FormatDate(getdate(), null)
	select util.uf_FormatDate(getdate(), '_')
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	declare @result varchar(10)

	--Derive result
	if nullif(@seperator, '') is null 	
		set @result = convert(varchar(10), @date, 112) --yyyymmdd
	else begin
		set @result = convert(varchar(10), @date, 102) --yyyy.mm.dd
		set @result = replace(@result, '.', @seperator)
	end --if

	--Return result
	return @result
end --function