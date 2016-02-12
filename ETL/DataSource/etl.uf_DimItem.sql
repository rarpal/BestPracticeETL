
if object_id('[etl].[uf_DimItem]') is not null
begin
	DROP FUNCTION [etl].[uf_DimItem]
end
GO

CREATE function [etl].[uf_DimItem](@logicalDate datetime)
returns table
-- select top 10 * from etl.uf_DimItem('2004-12-20')
--grantdi 2005/10/05: Sharpened all numeric data types
as
return (
	--Throw away duplicate updates per day using a CTE as opposed to GroupBy
	with cte as (
		select
			 row_number() over (partition by SysID order by SysID) as rn
			,*
		from
			dbo.BN_Item_FULL
		where 
			Logical_Date = @logicalDate
	)
	select
		 convert(int, SYSID)				as SYSID --numeric(9,0)
		,ASSORTMENT_CODE
		,ASSORTMENT_DESC
		,AUDIENCE_CODE
		,AUDIENCE_GRD_FROM
		,AUDIENCE_GRD_TO
		,AUTHOR
		,AUTHOR_FNAME
		,AUTHOR_LNAME
		,AUTHOR_MNAME
		,BARGAIN_CATALOG_IND
		,BARGAIN_TYPE_CODE
		,BN_ORIG_DISCOUNT_SCHED
		,BN_ORIG_PURCH_VENDOR_DESC
		,convert(int, BN_ORIG_PURCH_VENDOR_NUM) as BN_ORIG_PURCH_VENDOR_NUM --numeric(8,0)
		,BN_RETAIL
		,BUYER_CODE
		,CATEGORY_CODE
		,CATEGORY_DESC
		,convert(smallint, CLASS_CODE)		as CLASS_CODE --numeric(3,0)
		,CO_PACK_IND
		,CURRENT_STATUS_CODE
		,CURRENT_STATUS_TYPE
		,DC_AUTO_PO_IND
		,DC_BILLING_COST_AMT
		,DC_BILLING_DISC
		,DC_BUS_TYPE_CODE
		,convert(int, DC_BUYER_NUM)			as DC_BUYER_NUM --numeric(5,0)
		,DC_COST_AMT
		,DC_DATE_SENSITIVE_CODE
		,DC_DISCOUNT_SCHED
		,DC_FACILITY_CODE
		,DC_FREIGHT_PASS_AMT
		,DC_HOLD_ORDERS_CODE
		,DC_IMPORT_TITLE_IND
		,DC_INV_CLASS_CODE
		,DC_ORDER_STATUS_CODE
		,DC_ORDER_STATUS_DATE
		,DC_PACKING_CODE
		,convert(int, DC_PO_MAX_QTY)		as DC_PO_MAX_QTY --numeric(9,0)
		,convert(int, DC_PO_MIN_QTY)		as DC_PO_MIN_QTY --numeric(9,0)
		,DC_PRE_TICKET_CODE
		,DC_PUB_DISC_CODE
		,DC_PUB_RTN_DATE
		,DC_PURCHASE_CODE
		,DC_PURCHASE_DISC
		,DC_REC_STATUS_CODE
		,DC_REGION_CODE
		,DC_RELEASE_DATE
		,DC_RESTRICTION_CODE
		,DC_RETURN_CODE
		,DC_RTN_ALL_IND
		,DC_RTN_TITLE_IND
		,DC_SELLDOWN_CODE
		,convert(int, DC_STOCK_DOWN_QTY)	as DC_STOCK_DOWN_QTY --numeric(9,0)
		,DC_STOCK_OFFER_IND
		,DC_SUPER_RESERVE_IND
		,DC_VENDOR_DESC
		,convert(int, DC_VENDOR_NUM)		as DC_VENDOR_NUM --numeric(8,0)
		,DEPT_CAT
		,convert(varchar(7), 'Unknown')		as DEPT_NAME
		,convert(varchar(2), 'NA')			as DEPT_GROUP
		,convert(int, DEPT_NUM)				as DEPT_NUM --numeric(5,0)
		,DEPTH_NUM
		,DISPLAY_CODE
		,DISPLAY_DESC
		,DUMMY_FLAG
		,convert(bigint, EAN)				as EAN --numeric(15,0)
		,EDITION_DESC
		,convert(int, EDITION_NUM)			as EDITION_NUM --numeric(5,0)
		,FORMAT_CODE
		,IMPRINT
		,IMPRINT_NAME
		,IMS_IND
		,convert(int, INCR_ORDER_QTY)		as INCR_ORDER_QTY --numeric(5,0)
		,ISBN
		,ITEM_DESC
		,LANGUAGE_CODE
		,LARGE_PRINT_IND
		,LENGTH_NUM
		,LONG_ITEM_DESC
		,MBOOK_IND
		,MEDIA_CODE
		,convert(smallint, MEDIA_QTY)		as MEDIA_QTY --numeric(4,0)
		,NET_PRICE_AMT
		,ORDER_FLAG
		,ORIG_BGN_PRICE
		,convert(bigint, ORIGINAL_EAN)		as ORIGINAL_EAN --numeric(15,0)
		,PREPACK_IND
		,PRICE_TYPE_CODE
		,convert(int, PRINT_RUN_QTY)		as PRINT_RUN_QTY --numeric(7,0)
		,PRODUCT_TYPE
		,PROPRIETARY_CODE
		,PUB_PRICE
		,convert(smallint, PUB_YEAR_NUM)	as PUB_YEAR_NUM --numeric(4,0)
		,PUBLISH_DATE
		,PUBLISHER_NAME
		,IsNull(PURCH_VENDOR_DESC,'Unknown') as PURCH_VENDOR_DESC
		,convert(int, PURCH_VENDOR_NUM)		as PURCH_VENDOR_NUM --numeric(8,0)
		,REPLEN_TYPE
		,RETAIL_AMT
		,RETURN_CODE
		,RETURN_FLAG
		,RETURN_VENDOR_DESC
		,convert(int, RETURN_VENDOR_NUM)	as RETURN_VENDOR_NUM --numeric(8,0)
		,SALEABLE_CODE
		,convert(int, SERIES_NUM)			as SERIES_NUM --numeric(5,0)
		,SERIES_REPLEN_IND
		,SERIES_TITLE
		,SOURCE_DESC
		,SOURCE_DISCOUNT_SCHED
		,convert(int, SOURCE_NUM)			as SOURCE_NUM --numeric(8,0)
		,STREET_DATE
		,convert(int, SUBJECT_CODE)			as SUBJECT_CODE --numeric(5,0)
		,SUBJECT_DESC
		,TITLE_STATUS
		,convert(int, TOTAL_NUM_PAGES)		as TOTAL_NUM_PAGES --numeric(10,0)
		,UPC
		,convert(int, VEN_CASEPACK_NUM)		as VEN_CASEPACK_NUM --numeric(5,0)
		,VENDOR_ITEM_CODE
		,VENDOR_RETAIL
		,VENDOR_STATUS
		,VOLUME_NUM
		,convert(int, VOLUME_QTY)			as VOLUME_QTY --numeric(7,0)
		,WEB_FLAG
		,WEIGHT_NUM,WIDTH_NUM,
		rn
	from
		cte
	--where 
	--	rn = 1
);