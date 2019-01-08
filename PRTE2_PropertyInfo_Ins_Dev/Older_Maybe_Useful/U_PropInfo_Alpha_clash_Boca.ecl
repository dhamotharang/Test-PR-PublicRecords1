IMPORT PRTE2_PropertyInfo;

SAVE_RECS_NAME		:= PRTE2_PropertyInfo.U_PropInfo_Clash_Files.SAVE_RECS_NAME;
SAVE_XREF_NAME		:= PRTE2_PropertyInfo.U_PropInfo_Clash_Files.SAVE_XREF_NAME;
ClashLayout := U_PropInfo_Clash_Layout;
	
DS1 := PRTE2_PropertyInfo.Files.PII_ALPHA_BASE_SF_DS_PROD;
DS2 := PRTE2_PropertyInfo.Files.BOCA_BASE_SF_DS_PROD;

ClashLayout trxFrom(DS1 L, DS2 R) := TRANSFORM
		SELF.b_property_rid := R.property_rid;
		SELF.b_dt_vendor_first_reported := R.dt_vendor_first_reported;
		SELF.b_dt_vendor_last_reported := R.dt_vendor_last_reported;
		SELF.b_vendor_source := R.vendor_source;
		SELF.b_prim_range := R.prim_range;
		SELF.b_predir := R.predir;
		SELF.b_prim_name := R.prim_name;
		SELF.b_addr_suffix := R.addr_suffix;
		SELF.b_postdir := R.postdir;
		SELF.b_unit_desig := R.unit_desig;
		SELF.b_sec_range := R.sec_range;
		SELF.b_v_city_name := R.v_city_name;
		SELF.b_st := R.st;
		SELF.b_zip := R.zip;
		SELF.b_zip4 := R.zip4;	
		SELF := L;
END;
joinem1 := JOIN(DS1, DS2,
							LEFT.prim_range=RIGHT.prim_range
							and LEFT.prim_name=RIGHT.prim_name
							and LEFT.st=RIGHT.st
							and LEFT.sec_range=RIGHT.sec_range
							and LEFT.predir=RIGHT.predir
							and LEFT.addr_suffix=RIGHT.addr_suffix
							and LEFT.postdir=RIGHT.postdir
							and LEFT.v_city_name=RIGHT.v_city_name
							and LEFT.zip=RIGHT.zip
							and LEFT.vendor_source=RIGHT.vendor_source
							,trxFrom(LEFT,RIGHT)
							,inner );
joinem2 := JOIN(DS1, DS2,
							LEFT.prim_range=RIGHT.prim_range
							and LEFT.prim_name=RIGHT.prim_name
							and LEFT.st=RIGHT.st
							and LEFT.sec_range=RIGHT.sec_range
							and LEFT.predir=RIGHT.predir
							and LEFT.addr_suffix=RIGHT.addr_suffix
							and LEFT.postdir=RIGHT.postdir
							and LEFT.v_city_name=RIGHT.v_city_name
							and LEFT.zip=RIGHT.zip
							and LEFT.vendor_source=RIGHT.vendor_source
							,TRANSFORM({DS1}, SELF := LEFT;)
							,inner );

// DS1a := DS1(prim_range='1033',prim_name='DELIA',st='OH');
// DS2a := DS2(prim_range='1033',prim_name='DELIA',st='OH');

OUTPUT(COUNT(Joinem1));
OUTPUT(Joinem1);
OUTPUT(SORT(Joinem1,prim_range,prim_name,sec_range,v_city_name,st,vendor_source),,SAVE_XREF_NAME,overwrite);
OUTPUT(SORT(Joinem2,prim_range,prim_name,sec_range,v_city_name,st,vendor_source),,SAVE_RECS_NAME,overwrite);
