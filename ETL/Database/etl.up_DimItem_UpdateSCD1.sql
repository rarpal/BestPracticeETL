CREATE procedure [etl].[up_DimItem_UpdateSCD1](
	 @logID			int
	,@logicalDate	datetime
	,@operator		varchar(30)
)
with execute as caller
as
/**********************************************************************************************************
* SP Name:
*		etl.up_DimItem_UpdateSCD1
* Parameters:
*		 @logID			int
*		,@logicalDate	datetime
*		,@operator		varchar(30)
*  
* Purpose:	This stored procedure performs a batch update of the SCD-Type-I updates as part of the 
*	DimItem ETL process. Instead of updating each member row-by-row, the updates are written to an
*	intermediate table and then set-based operations are used to bulk-update the destination.
*              
* Example:
	exec etl.up_DimItem_UpdateSCD1 1, null, null
*              
* Revision Date/Time:
*	July 25, 2005	(G Dickinson)	- Authored
*
**********************************************************************************************************/
begin
	set nocount on

	if @logID is not null begin
		--Coalesce @operator
		set @operator = nullif(ltrim(rtrim(@operator)), '')
		set @operator = isnull(@operator, suser_sname())

		--Coalesce @logicalDate
		set @logicalDate = isnull(@logicalDate, getdate())

		--Perform batch update
		update dbo.Tbl_Dim_Item set
			SK_Parent_Item_ID		= case old.SK_Parent_Item_ID
				when 0 then old.SK_Item_ID
				else old.SK_Parent_Item_ID
			 end --case
		--	,SYSID					= new.SYSID
		--	,ASSORTMENT_CODE		= new.ASSORTMENT_CODE
		--	,ASSORTMENT_DESC		= new.ASSORTMENT_DESC
			,AUDIENCE_CODE			= new.AUDIENCE_CODE
			,AUDIENCE_GRD_FROM		= new.AUDIENCE_GRD_FROM
			,AUDIENCE_GRD_TO		= new.AUDIENCE_GRD_TO
			,AUTHOR					= new.AUTHOR
			,AUTHOR_FNAME			= new.AUTHOR_FNAME
			,AUTHOR_LNAME			= new.AUTHOR_LNAME
			,AUTHOR_MNAME			= new.AUTHOR_MNAME
			,BARGAIN_CATALOG_IND	= new.BARGAIN_CATALOG_IND
			,BARGAIN_TYPE_CODE		= new.BARGAIN_TYPE_CODE
			,BN_ORIG_DISCOUNT_SCHED		= new.BN_ORIG_DISCOUNT_SCHED
		--	,BN_ORIG_PURCH_VENDOR_DESC	= new.BN_ORIG_PURCH_VENDOR_DESC
			,BN_ORIG_PURCH_VENDOR_NUM	= new.BN_ORIG_PURCH_VENDOR_NUM
			,BN_RETAIL				= new.BN_RETAIL
			,BUYER_CODE				= new.BUYER_CODE
			,CATEGORY_CODE			= new.CATEGORY_CODE
			,Category				= new.CATEGORY_DESC --CATEGORY_DESC
			,CLASS_CODE				= new.CLASS_CODE
			,CO_PACK_IND			= new.CO_PACK_IND
			,CURRENT_STATUS_CODE	= new.CURRENT_STATUS_CODE
			,CURRENT_STATUS_TYPE	= new.CURRENT_STATUS_TYPE
			,DC_AUTO_PO_IND			= new.DC_AUTO_PO_IND
			,DC_BILLING_COST_AMT	= new.DC_BILLING_COST_AMT
			,DC_BILLING_DISC		= new.DC_BILLING_DISC
			,DC_BUS_TYPE_CODE		= new.DC_BUS_TYPE_CODE
			,DC_BUYER_NUM			= new.DC_BUYER_NUM
			,DC_COST_AMT			= new.DC_COST_AMT
			,DC_DATE_SENSITIVE_CODE	= new.DC_DATE_SENSITIVE_CODE
			,DC_DISCOUNT_SCHED		= new.DC_DISCOUNT_SCHED
			,DC_FACILITY_CODE		= new.DC_FACILITY_CODE
			,DC_FREIGHT_PASS_AMT	= new.DC_FREIGHT_PASS_AMT
			,DC_HOLD_ORDERS_CODE	= new.DC_HOLD_ORDERS_CODE
			,DC_IMPORT_TITLE_IND	= new.DC_IMPORT_TITLE_IND
			,DC_INV_CLASS_CODE		= new.DC_INV_CLASS_CODE
			,DC_ORDER_STATUS_CODE	= new.DC_ORDER_STATUS_CODE
			,DC_ORDER_STATUS_DATE	= new.DC_ORDER_STATUS_DATE
			,DC_PACKING_CODE		= new.DC_PACKING_CODE
			,DC_PO_MAX_QTY			= new.DC_PO_MAX_QTY
			,DC_PO_MIN_QTY			= new.DC_PO_MIN_QTY
			,DC_PRE_TICKET_CODE		= new.DC_PRE_TICKET_CODE
			,DC_PUB_DISC_CODE		= new.DC_PUB_DISC_CODE
			,DC_PUB_RTN_DATE		= new.DC_PUB_RTN_DATE
			,DC_PURCHASE_CODE		= new.DC_PURCHASE_CODE
			,DC_PURCHASE_DISC		= new.DC_PURCHASE_DISC
			,DC_REC_STATUS_CODE		= new.DC_REC_STATUS_CODE
			,DC_REGION_CODE			= new.DC_REGION_CODE
			,DC_RELEASE_DATE		= new.DC_RELEASE_DATE
			,DC_RESTRICTION_CODE	= new.DC_RESTRICTION_CODE
			,DC_RETURN_CODE			= new.DC_RETURN_CODE
			,DC_RTN_ALL_IND			= new.DC_RTN_ALL_IND
			,DC_RTN_TITLE_IND		= new.DC_RTN_TITLE_IND
			,DC_SELLDOWN_CODE		= new.DC_SELLDOWN_CODE
			,DC_STOCK_DOWN_QTY		= new.DC_STOCK_DOWN_QTY
			,DC_STOCK_OFFER_IND		= new.DC_STOCK_OFFER_IND
			,DC_SUPER_RESERVE_IND	= new.DC_SUPER_RESERVE_IND
			,DC_Vendor				= new.DC_VENDOR_DESC --DC_VENDOR_DESC
			,DC_VENDOR_NUM			= new.DC_VENDOR_NUM
			,DEPT_CAT				= new.DEPT_CAT
		--	,DEPT_NAME				= new.DEPT_NAME
			,DEPT_GROUP				= new.DEPT_GROUP
			,DEPT_NUM				= new.DEPT_NUM
			,DEPTH_NUM				= new.DEPTH_NUM
			,DISPLAY_CODE			= new.DISPLAY_CODE
			,Display				= new.DISPLAY_DESC --DISPLAY_DESC
			,DUMMY_FLAG				= new.DUMMY_FLAG
			,EAN					= new.EAN
			,Edition				= new.EDITION_DESC --EDITION_DESC
			,EDITION_NUM			= new.EDITION_NUM
			,FORMAT_CODE			= new.FORMAT_CODE
			,IMPRINT				= new.IMPRINT
			,IMPRINT_NAME			= new.IMPRINT_NAME
			,IMS_IND				= new.IMS_IND
			,INCR_ORDER_QTY			= new.INCR_ORDER_QTY
			,ISBN					= new.ISBN
			,ITEM_DESC				= new.ITEM_DESC
			,LANGUAGE_CODE			= new.LANGUAGE_CODE
			,LARGE_PRINT_IND		= new.LARGE_PRINT_IND
			,LENGTH_NUM				= new.LENGTH_NUM
			,LONG_ITEM_DESC			= new.LONG_ITEM_DESC
			,MBOOK_IND				= new.MBOOK_IND
			,MEDIA_CODE				= new.MEDIA_CODE
			,MEDIA_QTY				= new.MEDIA_QTY
			,NET_PRICE_AMT			= new.NET_PRICE_AMT
			,ORDER_FLAG				= new.ORDER_FLAG
			,ORIG_BGN_PRICE			= new.ORIG_BGN_PRICE
			,ORIGINAL_EAN			= new.ORIGINAL_EAN
			,PREPACK_IND			= new.PREPACK_IND
			,PRICE_TYPE_CODE		= new.PRICE_TYPE_CODE
			,PRINT_RUN_QTY			= new.PRINT_RUN_QTY
			,PRODUCT_TYPE			= new.PRODUCT_TYPE
			,PROPRIETARY_CODE		= new.PROPRIETARY_CODE
			,PUB_PRICE				= new.PUB_PRICE
			,PUB_YEAR_NUM			= new.PUB_YEAR_NUM
			,PUBLISH_DATE			= new.PUBLISH_DATE
			,PUBLISHER_NAME			= new.PUBLISHER_NAME
			,Purch_Vendor			= new.PURCH_VENDOR_DESC --PURCH_VENDOR_DESC
			,PURCH_VENDOR_NUM		= new.PURCH_VENDOR_NUM
			,REPLEN_TYPE			= new.REPLEN_TYPE
			,RETAIL_AMT				= new.RETAIL_AMT
			,RETURN_CODE			= new.RETURN_CODE
			,RETURN_FLAG			= new.RETURN_FLAG
			,Return_Vendor			= new.RETURN_VENDOR_DESC --RETURN_VENDOR_DESC
			,RETURN_VENDOR_NUM		= new.RETURN_VENDOR_NUM
			,SALEABLE_CODE			= new.SALEABLE_CODE
			,SERIES_NUM				= new.SERIES_NUM
			,SERIES_REPLEN_IND		= new.SERIES_REPLEN_IND
			,SERIES_TITLE			= new.SERIES_TITLE
			,SOURCE_DESC			= new.SOURCE_DESC
			,SOURCE_DISCOUNT_SCHED	= new.SOURCE_DISCOUNT_SCHED
			,SOURCE_NUM				= new.SOURCE_NUM
			,STREET_DATE			= new.STREET_DATE
			,SUBJECT_CODE			= new.SUBJECT_CODE
			,Subject				= new.SUBJECT_DESC --SUBJECT_DESC
			,TITLE_STATUS			= new.TITLE_STATUS
			,TOTAL_NUM_PAGES		= new.TOTAL_NUM_PAGES
			,UPC					= new.UPC
			,VEN_CASEPACK_NUM		= new.VEN_CASEPACK_NUM
			,VENDOR_ITEM_CODE		= new.VENDOR_ITEM_CODE
			,VENDOR_RETAIL			= new.VENDOR_RETAIL
			,VENDOR_STATUS			= new.VENDOR_STATUS
			,VOLUME_NUM				= new.VOLUME_NUM
			,VOLUME_QTY				= new.VOLUME_QTY
			,WEB_FLAG				= new.WEB_FLAG
			,WEIGHT_NUM				= new.WEIGHT_NUM
			,WIDTH_NUM				= new.WIDTH_NUM
			,Has_Sales				= new.Has_Sales
	--		,Inferred_Member		= new.Inferred_Member
			,ETL_Load_ID			= new.ETL_Load_ID
			,Last_Modified_Date		= @logicalDate
			,Modified_By_User		= @operator
		from
			etl.DimItem_SCD1Log as new
		inner join
			dbo.Tbl_Dim_Item as old
		on
			old.SK_Item_ID = new.SK_Item_ID	
		--and old.Current_Row = 1 --SCD1 must change ALL rows including historical
		where
			new.ETL_Load_ID = @logID
	end --if

	set nocount off
end --proc

