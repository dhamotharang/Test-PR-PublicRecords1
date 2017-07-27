lTNUpdateBaseName := (Drivers.cluster + 'in::drvlic_tn_update_');

rPre20040409Layout
 :=
  record
	string8		append_PROCESS_DATE;
	string20	orig_LAST_NAME;
	string10	orig_FIRST_NAME;
	string10	orig_MIDDLE_NAME;
	string3		orig_NAME_SUFFIX;
	string25	orig_STREET_ADDRESS_1;
	string20	orig_STREET_ADDRESS_2;
	string18	orig_CITY;
	string2		orig_STATE;
	string5		orig_ZIP_CODE;
	string8		orig_DOB;
	string1		orig_RACE;
	string1		orig_SEX;
	string3		orig_HEIGHT;
	string3		orig_WEIGHT;
	string2		orig_EYE_COLOR;
	string2		orig_HAIR_COLOR;
	string9		orig_DL_NUMBER;
	string6		orig_ISSUE_DATE;
	string6		orig_EXPIRE_DATE;
	string9		orig_FILLER;
	string2		orig_RESIDENCE_COUNTY;
	string2		orig_CRLF;
	string5		clean_name_prefix;
	string20	clean_name_first;
	string20	clean_name_middle;
	string20	clean_name_last;
	string5		clean_name_suffix;
	string3		clean_name_score;
	string10	clean_prim_range;
	string2		clean_predir;
	string28	clean_prim_name;
	string4		clean_addr_suffix;
	string2		clean_postdir;
	string10	clean_unit_desig;
	string8		clean_sec_range;
	string25	clean_p_city_name;
	string25	clean_v_city_name;
	string2		clean_st;
	string5		clean_zip;
	string4		clean_zip4;
	string4		clean_cart;
	string1		clean_cr_sort_sz;
	string4		clean_lot;
	string1		clean_lot_order;
	string2		clean_dpbc;
	string1		clean_chk_digit;
	string2		clean_record_type;
	string2		clean_ace_fips_st;
	string3		clean_fipscounty;
	string10	clean_geo_lat;
	string11	clean_geo_long;
	string4		clean_msa;
	string7		clean_geo_blk;
	string1		clean_geo_match;
	string4		clean_err_stat;
end ;

dFile_TN_Update_Pre20040409
 := dataset(lTNUpdateBaseName + '20030901',rPre20040409Layout,flat)
 +	dataset(lTNUpdateBaseName + '20031201',rPre20040409Layout,flat)
 +	dataset(lTNUpdateBaseName + '20040131',rPre20040409Layout,flat)
 +	dataset(lTNUpdateBaseName + '20040201',rPre20040409Layout,flat)
 +	dataset(lTNUpdateBaseName + '20040229',rPre20040409Layout,flat)
 ;

string8 fPrependCentury(string6 pDateIn)
 := if((integer4)pDateIn <> 0,if((integer2)(pDateIn[1..2]) <= 30,'20','19') + pDateIn,'');

Drivers.Layout_TN_Full tPre20040409toCurrent(rPre20040409Layout pInput)
 :=
  transform
	self.orig_LICENSE_TYPE	:= '';
	self.orig_RESTRICTIONS	:= '';
	self.orig_ENDORSEMENTS	:= '';
	self.orig_NON_CDL_STATUS:= '';
	self.orig_CDL_STATUS	:= '';
	self.orig_EXPIRE_DATE	:= fPrependCentury(pInput.orig_EXPIRE_DATE);
	self.orig_ISSUE_DATE	:= fPrependCentury(pInput.orig_ISSUE_DATE);
	self					:= pInput;
  end
 ;

dPre20040409asCurrent	:= project(dFile_TN_Update_Pre20040409,tPre20040409toCurrent(left));

export File_TN_Update
 :=	dPre20040409asCurrent
// +	dataset(lTNUpdateBaseName + '20040409',drivers.Layout_TN_Full,flat)
 ;