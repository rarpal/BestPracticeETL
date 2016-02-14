

CREATE procedure [util].[up_ExecuteSQL]
	 @key		varchar(50)
	,@sql		varchar(max)
	,@logID		int
	,@debug		bit = 0		--Debug mode?
with execute as caller
as
-- exec util.up_ExecuteSQL 'Test', 'select', 0, 1
begin
	set nocount on

	if @debug = 1 begin
		print '--' + @key
		print (@sql)
	end else begin
		--Write the statement to the log first so we can monitor it (with nolock)
		exec audit.up_Event_Package_OnCommand
			 @Key	= @key
			,@Type	= 'SQL'
			,@Value	= @sql
			,@logID	= @logID
		--Execute the statement
		exec (@sql)
	end --if

	set nocount off
end --proc