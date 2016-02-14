﻿CREATE PROCEDURE [audit].[up_CreateRejectsLog]
	@LogID int,
	@ComponentName varchar(50),
	@KeyValue varchar(50),
	@RowNumber int,
	@Rejects varchar(1000) = 'Not specified'
WITH EXECUTE AS CALLER
AS
/***********************************************************
Name: audit.up_CreateRejectsLog
Parameters:
	 @LogID				int
	,@ComponentName		varchar(50)
	,@KeyValue			varchar(50)
	,@RowNumber			int
	,@Rejects			varchar(1000)

Samples:

Purpose: This is a general purpose re-usable procedure intended to be used for logging of rejected records
	as a result of de-duplications, unifications or conforming scenaiors

History:
	12-02-2016 (Ravi Palihena)	- Created

************************************************************/
BEGIN

SET NOCOUNT ON
SET ANSI_NULLS ON

INSERT INTO audit.RejectsLog (
	 LogID
	,ComponentName
	,KeyValue
	,RowNumber
	,Rejects
	,LogTime
	)
VALUES (
	 @LogID
	,@ComponentName
	,@KeyValue
	,@RowNumber
	,@Rejects
	,GETDATE()
	)

END