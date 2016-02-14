
CREATE function [util].[uf_GetEndOfWeekDate](
	 @date		datetime
) 
returns datetime
with returns null on null input,
execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		util.uf_GetEndOfWeekDate
* Parameters:  
*		 @date		datetime
*
* Purpose: This function returns the end-of-week date for a specified @date. In ProjectREAL
*	the end of week is a Saturday. We could have used the built in functions to do this, 
*	but we wanted to remove the dependency on SET DATEFIRST.
*
* Example:
	select util.uf_GetEndOfWeekDate('2005-10-23')
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	--Remove the time from the datetime
	set @date = convert(datetime, convert(varchar(10), @date, 102))

	--Use DateFirst-independant method of getting endOfWeek date
	set @date = @date + util.uf_GetDaysToEndOfWeek(@date, 0)

	--Return result
	return @date
end --function