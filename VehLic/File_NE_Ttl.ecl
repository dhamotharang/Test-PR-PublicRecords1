// The layout changed, so we're mapping the old layout into the new layout below.  Simple changes.
rOldLayout_NE_Ttl
 :=
  record
    string8     append_process_date;
    string11    orig_TITLE_NUMBER;
    string1     orig_TITLE_TYPE;
    string2     orig_PREVIOUS_TITLE_STATE;
    string11    orig_PREVIOUS_TITLE_NUMBER;
    string10    orig_TITLE_ISSUE_DATE;
    string10    orig_TITLE_ACQUIRED_DATE;
    string1     orig_BRAND_CODE;
    string20    orig_VIN;
    string4     orig_MAKE_CODE;
    string4     orig_MODEL_YEAR;
    string3     orig_MODEL_CODE;
    string3     orig_SERIES_CODE;
    string2     orig_BODY_STYLE_CODE;
    string1     orig_VEHICLE_TYPE;
    string3     orig_MAJOR_COLOR_CODE;
    string3     orig_MINOR_COLOR_CODE;
    string9     orig_ODOMETER_READING;
    string1     orig_ODOMETER_READING_TYPE;
    string35    orig_ADDRESS_1;
    string35    orig_ADDRESS_2;
    string17    orig_CITY;
    string1     orig_SPACE;
    string2     orig_STATE;
    string5     orig_ZIPCODE;
    string4     orig_ZIPPLUS4;
    string1     orig_AND_FLAG;
    string1     orig_OR_FLAG;
    string1     orig_TOD_FLAG;
    string35    orig_OWNER_1_NAME;
    string1     orig_OWNER_1_TYPE;
    string35    orig_OWNER_2_NAME;
    string1     orig_OWNER_2_TYPE;
    string35    orig_OWNER_3_NAME;
    string1     orig_OWNER_3_TYPE;
    string35    orig_OWNER_4_NAME;
    string1     orig_OWNER_4_TYPE;
    string2     orig_BRAND_STATE;
    string20    orig_BRAND_DESCRIPTION;
    string1     orig_LF;
    string10    clean_OWNER_ADDRESS_prim_range;
    string2     clean_OWNER_ADDRESS_predir;
    string28    clean_OWNER_ADDRESS_prim_name;
    string4     clean_OWNER_ADDRESS_addr_suffix;
    string2     clean_OWNER_ADDRESS_postdir;
    string10    clean_OWNER_ADDRESS_unit_desig;
    string8     clean_OWNER_ADDRESS_sec_range;
    string25    clean_OWNER_ADDRESS_p_city_name;
    string25    clean_OWNER_ADDRESS_v_city_name;
    string2     clean_OWNER_ADDRESS_st;
    string5     clean_OWNER_ADDRESS_zip;
    string4     clean_OWNER_ADDRESS_zip4;
    string4     clean_OWNER_ADDRESS_cart;
    string1     clean_OWNER_ADDRESS_cr_sort_sz;
    string4     clean_OWNER_ADDRESS_lot;
    string1     clean_OWNER_ADDRESS_lot_order;
    string2     clean_OWNER_ADDRESS_dpbc;
    string1     clean_OWNER_ADDRESS_chk_digit;
    string2     clean_OWNER_ADDRESS_record_type;
    string2     clean_OWNER_ADDRESS_ace_fips_st;
    string3     clean_OWNER_ADDRESS_fipscounty;
    string10    clean_OWNER_ADDRESS_geo_lat;
    string11    clean_OWNER_ADDRESS_geo_long;
    string4     clean_OWNER_ADDRESS_msa;
    string7     clean_OWNER_ADDRESS_geo_blk;
    string1     clean_OWNER_ADDRESS_geo_match;
    string4     clean_OWNER_ADDRESS_err_stat;
    string5     clean_OWNER_1_name_prefix;
    string20    clean_OWNER_1_name_first;
    string20    clean_OWNER_1_name_middle;
    string20    clean_OWNER_1_name_last;
    string5     clean_OWNER_1_name_suffix;
    string3     clean_OWNER_1_name_score;
    string5     clean_OWNER_2_name_prefix;
    string20    clean_OWNER_2_name_first;
    string20    clean_OWNER_2_name_middle;
    string20    clean_OWNER_2_name_last;
    string5     clean_OWNER_2_name_suffix;
    string3     clean_OWNER_2_name_score;
    string5     clean_OWNER_3_name_prefix;
    string20    clean_OWNER_3_name_first;
    string20    clean_OWNER_3_name_middle;
    string20    clean_OWNER_3_name_last;
    string5     clean_OWNER_3_name_suffix;
    string3     clean_OWNER_3_name_score;
    string5     clean_OWNER_4_name_prefix;
    string20    clean_OWNER_4_name_first;
    string20    clean_OWNER_4_name_middle;
    string20    clean_OWNER_4_name_last;
    string5     clean_OWNER_4_name_suffix;
    string3     clean_OWNER_4_name_score;
    string68    append_OWNER_1_NAME_COMPANY;
    string68    append_OWNER_2_NAME_COMPANY;
    string68    append_OWNER_3_NAME_COMPANY;
    string68    append_OWNER_4_NAME_COMPANY;
  end
 ;
 
rPre20050823_NE_Ttl
 :=
  record
    string8     append_process_date;
    string11    orig_TITLE_NUMBER;
    string1     orig_TITLE_TYPE;
    string2     orig_PREVIOUS_TITLE_STATE;
    string11    orig_PREVIOUS_TITLE_NUMBER;
    string35    orig_PREVIOUS_OWNER;
    string10    orig_TITLE_ISSUE_DATE;
    string10    orig_TITLE_ACQUIRED_DATE;
    string1     orig_BRAND_CODE;
    string20    orig_VIN;
    string4     orig_MAKE_CODE;
    string4     orig_MODEL_YEAR;
    string3     orig_MODEL_CODE;
    string3     orig_SERIES_CODE;
    string2     orig_BODY_STYLE_CODE;
    string1     orig_VEHICLE_TYPE;
    string3     orig_MAJOR_COLOR_CODE;
    string3     orig_MINOR_COLOR_CODE;
    string9     orig_ODOMETER_READING;
    string1     orig_ODOMETER_READING_TYPE;
    string35    orig_ADDRESS_1;
    string35    orig_ADDRESS_2;
    string17    orig_CITY;
    string1     orig_SPACE;
    string2     orig_STATE;
    string5     orig_ZIPCODE;
    string4     orig_ZIPPLUS4;
    string1     orig_AND_FLAG;
    string1     orig_OR_FLAG;
    string1     orig_TOD_FLAG;
    string35    orig_OWNER_1_NAME;
    string1     orig_OWNER_1_TYPE;
    string35    orig_OWNER_2_NAME;
    string1     orig_OWNER_2_TYPE;
    string35    orig_OWNER_3_NAME;
    string1     orig_OWNER_3_TYPE;
    string35    orig_OWNER_4_NAME;
    string1     orig_OWNER_4_TYPE;
    string2     orig_BRAND_STATE;
    string20    orig_BRAND_DESCRIPTION;
    string1     orig_LF;
    string10    clean_OWNER_ADDRESS_prim_range;
    string2     clean_OWNER_ADDRESS_predir;
    string28    clean_OWNER_ADDRESS_prim_name;
    string4     clean_OWNER_ADDRESS_addr_suffix;
    string2     clean_OWNER_ADDRESS_postdir;
    string10    clean_OWNER_ADDRESS_unit_desig;
    string8     clean_OWNER_ADDRESS_sec_range;
    string25    clean_OWNER_ADDRESS_p_city_name;
    string25    clean_OWNER_ADDRESS_v_city_name;
    string2     clean_OWNER_ADDRESS_st;
    string5     clean_OWNER_ADDRESS_zip;
    string4     clean_OWNER_ADDRESS_zip4;
    string4     clean_OWNER_ADDRESS_cart;
    string1     clean_OWNER_ADDRESS_cr_sort_sz;
    string4     clean_OWNER_ADDRESS_lot;
    string1     clean_OWNER_ADDRESS_lot_order;
    string2     clean_OWNER_ADDRESS_dpbc;
    string1     clean_OWNER_ADDRESS_chk_digit;
    string2     clean_OWNER_ADDRESS_record_type;
    string2     clean_OWNER_ADDRESS_ace_fips_st;
    string3     clean_OWNER_ADDRESS_fipscounty;
    string10    clean_OWNER_ADDRESS_geo_lat;
    string11    clean_OWNER_ADDRESS_geo_long;
    string4     clean_OWNER_ADDRESS_msa;
    string7     clean_OWNER_ADDRESS_geo_blk;
    string1     clean_OWNER_ADDRESS_geo_match;
    string4     clean_OWNER_ADDRESS_err_stat;
    string5     clean_OWNER_1_name_prefix;
    string20    clean_OWNER_1_name_first;
    string20    clean_OWNER_1_name_middle;
    string20    clean_OWNER_1_name_last;
    string5     clean_OWNER_1_name_suffix;
    string3     clean_OWNER_1_name_score;
    string5     clean_OWNER_2_name_prefix;
    string20    clean_OWNER_2_name_first;
    string20    clean_OWNER_2_name_middle;
    string20    clean_OWNER_2_name_last;
    string5     clean_OWNER_2_name_suffix;
    string3     clean_OWNER_2_name_score;
    string5     clean_OWNER_3_name_prefix;
    string20    clean_OWNER_3_name_first;
    string20    clean_OWNER_3_name_middle;
    string20    clean_OWNER_3_name_last;
    string5     clean_OWNER_3_name_suffix;
    string3     clean_OWNER_3_name_score;
    string5     clean_OWNER_4_name_prefix;
    string20    clean_OWNER_4_name_first;
    string20    clean_OWNER_4_name_middle;
    string20    clean_OWNER_4_name_last;
    string5     clean_OWNER_4_name_suffix;
    string3     clean_OWNER_4_name_score;
    string68    append_OWNER_1_NAME_COMPANY;
    string68    append_OWNER_2_NAME_COMPANY;
    string68    append_OWNER_3_NAME_COMPANY;
    string68    append_OWNER_4_NAME_COMPANY;
  end
 ;

// now using SuperFiles
dOldFile_NE_Ttl
 :=	dataset('~thor_data400::in::vehreg_ne_ttl_full',				rOldLayout_NE_Ttl,flat)
 +	dataset('~thor_data400::in::vehreg_ne_ttl_update_pre_20031006',	rOldLayout_NE_Ttl,flat)
 ;

dPre20050823_NE_Ttl
 :=	dataset('~thor_data400::in::vehreg_ne_ttl_update_pre_20050823',	rPre20050823_NE_Ttl,flat)
 ;

VehLic.Layout_NE_Ttl tOldLayoutToCurrent(dOldFile_NE_Ttl pInput)
 := 
  transform
	self.orig_PREVIOUS_OWNER	:=	'';  		// this is the new field
  self.orig_MAKE_DESCRIPTION := '';
	self.orig_MODEL_DESCRIPTION := '';
	self.orig_PREVIOUS_OWNER_CITY := '';
	self.orig_PREVIOUS_OWNER_STATE := '';
	self.orig_PREVIOUS_OWNER_ZIP1 := '';
	self.orig_PREVIOUS_OWNER_ZIP2 := '';
	self.orig_HOLDER_NAME := '';
	self.orig_HOLDER_ADDRESS := '';
	self.orig_HOLDER_CITY := '';
	self.orig_HOLDER_STATE := '';
	self.orig_HOLDER_ZIP1 := '';
	self.orig_HOLDER_ZIP2 := '';
	self.orig_NOTATION_DATE := '';
	self.orig_RELEASE_DATE := '';
	self						:=	pInput;
  end
 ;

VehLic.Layout_NE_Ttl tPre20050823LayoutToCurrent(dPre20050823_NE_Ttl pInput)
 := 
  transform
	self.orig_MAKE_DESCRIPTION := '';
	self.orig_MODEL_DESCRIPTION := '';
	self.orig_PREVIOUS_OWNER_CITY := '';
	self.orig_PREVIOUS_OWNER_STATE := '';
	self.orig_PREVIOUS_OWNER_ZIP1 := '';
	self.orig_PREVIOUS_OWNER_ZIP2 := '';
	self.orig_HOLDER_NAME := '';
	self.orig_HOLDER_ADDRESS := '';
	self.orig_HOLDER_CITY := '';
	self.orig_HOLDER_STATE := '';
	self.orig_HOLDER_ZIP1 := '';
	self.orig_HOLDER_ZIP2 := '';
	self.orig_NOTATION_DATE := '';
	self.orig_RELEASE_DATE := '';
	self						:=	pInput;
  end
 ;
 
dOldAsCurrent := project(dOldFile_NE_Ttl, tOldLayoutToCurrent(left)); 
dPre20050823Current := project(dPre20050823_NE_Ttl, tPre20050823LayoutToCurrent(left));

// now using SuperFiles
export File_NE_Ttl
 := dOldAsCurrent
 + dPre20050823Current
 +	dataset('~thor_data400::in::vehreg_ne_ttl_update',VehLic.Layout_NE_Ttl,flat)
 ;
