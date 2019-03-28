import address;
export layouts := module

	export certegy_DL_monthly := record
		String2 DL_State
		,String24 DL_Num
		,String9 SSN
		,String10 DL_Issue_Dte
		,String10 DL_Expire_Dte
		,String4 Name_pre
		,String4 Professional_Title
		,String4 Functional_Title
		,String10 House_Bldg_Num
		,String4 Street_Suffix
		,String10 Apt_Num
		,String4 Unit_Desc
		,String2 Street_Post_Dir
		,String2 Street_Pre_Dir
		,String2 State
		,String5 Zip
		,String4 Zip4
		,String5 Carrier_Rte
		,String3 Oversees_Loc
		,String10 DOB
		,String10 Deceased_Dte
		,String3 Home_Tel_Area
		,String7 Home_Tel_Num
		,String3 Work_Tel_Area
		,String7 Work_Tel_Num
		,String5 Work_Tel_Ext
		,String26 Upd_Dte_Time
		,String20 First_Name
		,String20 Mid_Name
		,String35 Last_Name
		,String20 Gen_Delivery
		,String35 Street_Name
		,String25 City
		,String25 Foreign_Cntry
		,String2 CRLF
	end;

	export cp_DL_in := record
		string32 CPS_SIG_RAW
		,string19 CPS_LOAD_DTTM
		,string15 CPS_VENDOR_CD
		,string3 CPS_CLOAK
		,string250 LAST_UPDATE_DTE
		,string250 CPS_HISTORY_FLG
		,string250 RECORD_NUM
		,string250 ADD_CHG_DEL_FLG
		,string250 DELETE_CD
		,string250 DELETE_DTE
		,string250 TRANS_CD
		,string250 TRANS_DTE
		,string250 PREV_TRNS_CD
		,string250 PREV_TRNS_DTE
		,string250 TAPE_DTE
		,string250 NAME_FULL
		,string250 NAME_FIRST
		,string250 NAME_MID
		,string250 NAME_LAST
		,string250 NAME_SUFFIX
		,string250 SSN
		,string250 BIRTH_DTE
		,string250 GENDER_CD
		,string250 HEIGHT
		,string250 WEIGHT
		,string250 HAIR_COLOR_CD
		,string250 EYE_COLOR_CD
		,string250 RACE_CD
		,string250 DECEASED_DTE
		,string250 PERSONAL_INFO_FLG
		,string250 MAILING_LIST_FLG
		,string250 HOME_AREA_CODE
		,string250 HOME_PHONE_NUM
		,string250 CELL_AREA_CODE
		,string250 CELL_PHONE_NUM
		,string250 WORK_AREA_CODE
		,string250 WORK_PHONE_NUM
		,string250 WORK_PHONE_EXT
		,string250 DL_STATE
		,string250 DL_NUM
		,string250 LICENSE_CLASS_CD
		,string250 ISSUE_DTE
		,string250 ORIG_ISSUE_DTE
		,string250 EXPIRE_DTE
		,string250 RESTRICTIONS
		,string250 ENDORSEMENTS
		,string250 PREV_DL_STATE
		,string250 PREV_DL_NUM
		,string250 IN_STATE_ONLY_FLG
		,string250 XREF_DL_NUM
		,string250 MOTORCYCLE_FLG
		,string250 CDL_FLG
		,string250 YRS_LAST_VIOLATION
		,string250 STATUS
		,string250 STATUS_DTE
		,string250 CLN_LAST_UPDATE_DTE
		,string250 CLN_DELETE_DTE
		,string250 CLN_TRANS_DTE
		,string250 CLN_PREV_TRNS_DTE
		,string250 CLN_TAPE_DTE
		,string250 CLN_BIRTH_DTE
		,string250 CLN_DECEASED_DTE
		,string250 CLN_ISSUE_DTE
		,string250 CLN_ORIG_ISSUE_DTE
		,string250 CLN_EXPIRE_DTE
		,string250 CLN_STATUS_DTE
		,string250 CLN_SSN
		,string250 CLN_DL_NUM
		,string250 CLN_PREV_DL_NUM
		,string250 CLN_XREF_DL_NUM
		,string250 CLN_BIRTH_YR
		,string250 CLN_BIRTH_MON
		,string250 CLN_BIRTH_DAY
		,string250 CPS_STATE_CD
		,string250 CPS_LIC_CLS_CD
		,string250 CPS_RESTRICTIONS
		,string250 CPS_SUFFIX_CD
		,string250 CPS_GENDER_CD
		,string250 CPS_HAIR_CLR_CD
		,string250 CPS_EYE_CLR_CD
		,string250 CPS_RACE_CD
		,string5 CLN_NAME_STATUS
		,string1 CLN_NAME_REV
		,string250 CLN_NAME_FIRST
		,string250 CLN_NAME_MID
		,string250 CLN_NAME_LAST
		,string250 CLN_CERT
		,string250 CLN_NAME_TTL
		,string250 CLN_NAME_PREFIX
		,string250 CLN_NAME_SUFFIX
		,string250 CLN_GENDER
		,string6 CLN_ADDR_STATUS
		,string1 CLN_ADDR_REV
		,string250 CLN_PRIM_ADDR
		,string250 CLN_SEC_ADDR
		,string250 CLN_PRIM_RANGE
		,string250 CLN_PRE_DIR
		,string250 CLN_PRIM_NAME
		,string250 CLN_ADDR_SUFFIX
		,string250 CLN_POST_DIR
		,string250 CLN_SEC_RANGE
		,string250 CLN_UNIT_DESIG
		,string250 CLN_REMAINDER
		,string250 CLN_RRNUM
		,string250 CLN_RRBOXNUM
		,string250 CLN_POBOXNUM
		,string250 CLN_CITY
		,string250 CLN_CITY_ABBR
		,string250 CLN_STATE
		,string250 CLN_ZIP5
		,string250 CLN_ZIP4
		,string250 CLN_CARRIER_RTE
		,string250 CLN_MATCH_UN
		,string250 CLN_ZIP_TYPE_CD
		,string250 CLN_RECORD_TYPE_CD
		,string250 CLN_CONGRESS_DIST
		,string250 CLN_CNTY_NAME
		,string250 CLN_CNTY_CD
		,string250 CLN_FIPS_CD
		,string250 CLN_GEO_MATCH
		,string15 CLN_GEO_LAT
		,string15 CLN_GEO_LNG
		,string250 CLN_GEO_MSA
		,string250 CLN_GEO_BLK
	end;

	export orig_DL_slim := record
		String2 orig_DL_State
		,String24 orig_DL_Num
		,String9 orig_SSN
		,String10 orig_DL_Issue_Dte
		,String10 orig_DL_Expire_Dte
		,String4 orig_Professional_Title
		,String4 orig_Functional_Title
		,String10 orig_House_Bldg_Num
		,String4 orig_Street_Suffix
		,String10 orig_Apt_Num
		,String4 orig_Unit_Desc
		,String2 orig_Street_Post_Dir
		,String2 orig_Street_Pre_Dir
		,String2 orig_State
		,String5 orig_Zip
		,String10 orig_DOB
		,String10 orig_Deceased_Dte
		,String3 orig_Home_Tel_Area
		,String7 orig_Home_Tel_Num
		,String3 orig_Work_Tel_Area
		,String7 orig_Work_Tel_Num
		,String5 orig_Work_Tel_Ext
		,String20 orig_First_Name
		,String20 orig_Mid_Name
		,String35 orig_Last_Name
		,String35 orig_Street_Name
		,String25 orig_City
	end;

	export base := record
		unsigned6	did       :=0
		,unsigned	did_score :=0

		,orig_DL_slim

		,String9 clean_ssn:=''
		,String8 clean_DOB:=''
		,String10 clean_hphone:=''
		,String10 clean_wphone:=''
		,string8  date_first_seen := ''
		,string8  date_last_seen := ''
		,string8  date_vendor_first_reported := ''
		,string8  date_vendor_last_reported := ''
		,address.Layout_Clean_Name.title
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix
		,address.Layout_Clean_Name.name_score

		,address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,string2		fips_county:=''
		,string3		county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat
		//DF-24226 - add global_sid and record_sid for CCPA 
		,unsigned4 global_sid
		,unsigned8 record_sid
	end;

end;