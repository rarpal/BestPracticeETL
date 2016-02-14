




CREATE function [util].[uf_GetDaysToEndOfWeek](
	 @date		datetime	--current date
	,@sunday	bit = 0		--Is end of week Sat(0) or Sun(1)?
) 
returns tinyint
with execute as caller
as
/**********************************************************************************************************
* UDF Name:		
*		util.uf_GetDaysToEndOfWeek
* Parameters:  
*		 @date		datetime
*		,@sunday	bit = 0		--Is end of week Sat(0) or Sun(1)?
*
* Purpose: This function returns the number of days from a specified date to the 
*	end-of-week. The end of week can be specified as either Saturday (0) or Sunday (1). In
*	ProjectREAL the end of week is usually Saturday. We calculate this number using DATEDIFF
*	from a known date in history. We could have used the built in functions to do this,
*		but we wanted to remove the dependency on SET DATEFIRST.
*
* Example:
	select util.uf_GetDaysToEndOfWeek(getdate(), 0)
*              
* Revision Date/Time:
*	October 31, 2005(G Dickinson)		- Authoring complete
*
**********************************************************************************************************/
begin
	--Coalesce NULL -> 0
	set @sunday = isnull(@sunday, 0)

	--Coerce @date to endOfWeek(@date) using a well-known-date so
	--we are not affected by SET DATEFIRST. 1753-01-06 is a Saturday.
	declare @day int
	set @day = datediff(day, '1753-01-06', @date) --days since origin (Saturday)
	set @day = @day - @sunday --if origin had been Sunday, @days would be one less
	set @day = @day - 1 --mod needs range-shift from (1..x) to (0..x-1)
	set @day = @day % 7 --mod 7 gives us (0..6)
	set @day = 6 - @day --compliment gives us (6..0)

	--Return result
	return @day
end --function