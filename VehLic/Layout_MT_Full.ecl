export Layout_MT_Full
 :=
  record
	string8		append_PROCESS_DATE;
	string2		orig_TRANSACTION_TYPE;
	string14	orig_TITLE_NUMBER;
	string1		orig_TITLE_STATUS;
	string8		orig_TITLE_DATE;
	string8		orig_VEHICLE_SALE_DATE;
	string1		orig_CONFIDENTIAL_INDICATOR;
	string22	orig_VIN;
	string1		orig_VIN_TYPE;
	string1		orig_STOLEN_INDICATOR;
	string9		orig_PLATE_NUMBER;
	string2		orig_PLATE_TYPE;
	string8		orig_PLATE_EXPIRATION_DATE;
	string9		orig_PLATE_NUMBER_2;
	string2		orig_PLATE_TYPE_2;
	string8		orig_REGISTRATION_DATE;
	string2		orig_REGISTRATION_COUNTY;
	string2		orig_REGISTRATION_EXEMPTION;
	string20	orig_OUT_OF_STATE_TITLE_NUMBER;
	string2		orig_OUT_OF_STATE_ABBREV;
	string2		orig_VEHICLE_TYPE;
	string4		orig_VEHICLE_MAKE;
	string3		orig_VEHICLE_MODEL;
	string2		orig_VEHICLE_BODY_STYLE;
	string4		orig_VEHICLE_YEAR;
	string3		orig_VEHICLE_MAJOR_COLOR;
	string3		orig_VEHICLE_MINOR_COLOR;
	string1		orig_VEHICLE_FUEL_TYPE;
	string1		orig_VEHICLE_TITLE_BRAND;
	string8		orig_VEHICLE_DEALER_NUMBER;
	string7		orig_VEHICLE_ODOMETER;
	string1		orig_VEHICLE_ODOMETER_INDICATOR;
	string5		orig_VEHICLE_UNLADEN_WEIGHT;
	string3		orig_VEHICLE_GVW;
	string8		orig_VEHICLE_GVW_EFFECTIVE_DATE;
	string1		orig_VEHICLE_GVW_CLASS;
	string8		orig_VEHICLE_GVW_EXPIRATION_DATE;
	string2		orig_VEHICLE_TON_CODE;
	string2		orig_VEHICLE_CAPACITY;
	string1		orig_OWNER_COUNT;
	string40	orig_OWNER_NAME_1;
	string1		orig_OWNER_NAME_TYPE_1;
	string1		orig_OWNERSHIP_TYPE_1;
	string1		orig_OWNER_JTROS_INDICATOR_1;
	string30	orig_OWNER_STREET_ADDRESS_1;
	string22	orig_OWNER_STREET_CITY_1;
	string2		orig_OWNER_STREET_STATE_1;
	string9		orig_OWNER_STREET_ZIP_1;
	string30	orig_OWNER_MAIL_ADDRESS_1;
	string22	orig_OWNER_MAIL_CITY_1;
	string2		orig_OWNER_MAIL_STATE_1;
	string9		orig_OWNER_MAIL_ZIP_1;
	string1		orig_OWNER_DISM_INDICATOR_1;
	string40	orig_OWNER_NAME_2;
	string1		orig_OWNER_NAME_TYPE_2;
	string1		orig_OWNERSHIP_TYPE_2;
	string1		orig_OWNER_JTROS_INDICATOR_2;
	string30	orig_OWNER_STREET_ADDRESS_2;
	string22	orig_OWNER_STREET_CITY_2;
	string2		orig_OWNER_STREET_STATE_2;
	string9		orig_OWNER_STREET_ZIP_2;
	string30	orig_OWNER_MAIL_ADDRESS_2;
	string22	orig_OWNER_MAIL_CITY_2;
	string2		orig_OWNER_MAIL_STATE_2;
	string9		orig_OWNER_MAIL_ZIP_2;
	string1		orig_OWNER_DISM_INDICATOR_2;
	string40	orig_OWNER_NAME_3;
	string1		orig_OWNER_NAME_TYPE_3;
	string1		orig_OWNERSHIP_TYPE_3;
	string1		orig_OWNER_JTROS_INDICATOR_3;
	string30	orig_OWNER_STREET_ADDRESS_3;
	string22	orig_OWNER_STREET_CITY_3;
	string2		orig_OWNER_STREET_STATE_3;
	string9		orig_OWNER_STREET_ZIP_3;
	string30	orig_OWNER_MAIL_ADDRESS_3;
	string22	orig_OWNER_MAIL_CITY_3;
	string2		orig_OWNER_MAIL_STATE_3;
	string9		orig_OWNER_MAIL_ZIP_3;
	string1		orig_OWNER_DISM_INDICATOR_3;
	string40	orig_OWNER_NAME_4;
	string1		orig_OWNER_NAME_TYPE_4;
	string1		orig_OWNERSHIP_TYPE_4;
	string1		orig_OWNER_JTROS_INDICATOR_4;
	string30	orig_OWNER_STREET_ADDRESS_4;
	string22	orig_OWNER_STREET_CITY_4;
	string2		orig_OWNER_STREET_STATE_4;
	string9		orig_OWNER_STREET_ZIP_4;
	string30	orig_OWNER_MAIL_ADDRESS_4;
	string22	orig_OWNER_MAIL_CITY_4;
	string2		orig_OWNER_MAIL_STATE_4;
	string9		orig_OWNER_MAIL_ZIP_4;
	string1		orig_OWNER_DISM_INDICATOR_4;
	string40	orig_OWNER_NAME_5;
	string1		orig_OWNER_NAME_TYPE_5;
	string1		orig_OWNERSHIP_TYPE_5;
	string1		orig_OWNER_JTROS_INDICATOR_5;
	string30	orig_OWNER_STREET_ADDRESS_5;
	string22	orig_OWNER_STREET_CITY_5;
	string2		orig_OWNER_STREET_STATE_5;
	string9		orig_OWNER_STREET_ZIP_5;
	string30	orig_OWNER_MAIL_ADDRESS_5;
	string22	orig_OWNER_MAIL_CITY_5;
	string2		orig_OWNER_MAIL_STATE_5;
	string9		orig_OWNER_MAIL_ZIP_5;
	string1		orig_OWNER_DISM_INDICATOR_5;
	string40	orig_OWNER_NAME_6;
	string1		orig_OWNER_NAME_TYPE_6;
	string1		orig_OWNERSHIP_TYPE_6;
	string1		orig_OWNER_JTROS_INDICATOR_6;
	string30	orig_OWNER_STREET_ADDRESS_6;
	string22	orig_OWNER_STREET_CITY_6;
	string2		orig_OWNER_STREET_STATE_6;
	string9		orig_OWNER_STREET_ZIP_6;
	string30	orig_OWNER_MAIL_ADDRESS_6;
	string22	orig_OWNER_MAIL_CITY_6;
	string2		orig_OWNER_MAIL_STATE_6;
	string9		orig_OWNER_MAIL_ZIP_6;
	string1		orig_OWNER_DISM_INDICATOR_6;
	string1		orig_LIEN_COUNT;
	string8		orig_LIEN_FILE_DATE_1;
	string13	orig_LIEN_AMOUNT_1;
	string40	orig_LIENHOLDER_NAME_1;
	string30	orig_LIENHOLDER_ADDRESS1_1;
	string30	orig_LIENHOLDER_ADDRESS2_1;
	string22	orig_LIENHOLDER_CITY_1;
	string2		orig_LIENHOLDER_STATE_1;
	string9		orig_LIENHOLDER_ZIP_1;
	string10	orig_LIENHOLDER_ACCOUNT_NUMBER_1;
	string8		orig_LIEN_FILE_DATE_2;
	string13	orig_LIEN_AMOUNT_2;
	string40	orig_LIENHOLDER_NAME_2;
	string30	orig_LIENHOLDER_ADDRESS1_2;
	string30	orig_LIENHOLDER_ADDRESS2_2;
	string22	orig_LIENHOLDER_CITY_2;
	string2		orig_LIENHOLDER_STATE_2;
	string9		orig_LIENHOLDER_ZIP_2;
	string10	orig_LIENHOLDER_ACCOUNT_NUMBER_2;
	string5  	clean_OWNER_1_NAME_prefix;
	string20 	clean_OWNER_1_NAME_first;
	string20 	clean_OWNER_1_NAME_middle;
	string20 	clean_OWNER_1_NAME_last;
	string5  	clean_OWNER_1_NAME_suffix;
	string3  	clean_OWNER_1_NAME_score;
	string68	append_OWNER_1_COMPANY_NAME;
	string5  	clean_OWNER_2_NAME_prefix;
	string20 	clean_OWNER_2_NAME_first;
	string20 	clean_OWNER_2_NAME_middle;
	string20 	clean_OWNER_2_NAME_last;
	string5  	clean_OWNER_2_NAME_suffix;
	string3  	clean_OWNER_2_NAME_score;
	string68	append_OWNER_2_COMPANY_NAME;
	string5  	clean_REG_1_NAME_prefix;
	string20 	clean_REG_1_NAME_first;
	string20 	clean_REG_1_NAME_middle;
	string20 	clean_REG_1_NAME_last;
	string5  	clean_REG_1_NAME_suffix;
	string3  	clean_REG_1_NAME_score;
	string68	append_REG_1_COMPANY_NAME;
	string5  	clean_REG_2_NAME_prefix;
	string20 	clean_REG_2_NAME_first;
	string20 	clean_REG_2_NAME_middle;
	string20 	clean_REG_2_NAME_last;
	string5  	clean_REG_2_NAME_suffix;
	string3  	clean_REG_2_NAME_score;
	string68	append_REG_2_COMPANY_NAME;
	string10	clean_OWNER_1_STREET_ADDRESS_prim_range;
	string2		clean_OWNER_1_STREET_ADDRESS_predir;
	string28	clean_OWNER_1_STREET_ADDRESS_prim_name;
	string4		clean_OWNER_1_STREET_ADDRESS_addr_suffix;
	string2		clean_OWNER_1_STREET_ADDRESS_postdir;
	string10	clean_OWNER_1_STREET_ADDRESS_unit_desig;
	string8		clean_OWNER_1_STREET_ADDRESS_sec_range; 
	string25	clean_OWNER_1_STREET_ADDRESS_p_city_name;
	string25	clean_OWNER_1_STREET_ADDRESS_v_city_name;
	string2		clean_OWNER_1_STREET_ADDRESS_st;
	string5		clean_OWNER_1_STREET_ADDRESS_zip;
	string4		clean_OWNER_1_STREET_ADDRESS_zip4;
	string4		clean_OWNER_1_STREET_ADDRESS_cart;
	string1		clean_OWNER_1_STREET_ADDRESS_cr_sort_sz;
	string4		clean_OWNER_1_STREET_ADDRESS_lot;
	string1		clean_OWNER_1_STREET_ADDRESS_lot_order;
	string2		clean_OWNER_1_STREET_ADDRESS_dpbc;
	string1		clean_OWNER_1_STREET_ADDRESS_chk_digit;
	string2		clean_OWNER_1_STREET_ADDRESS_record_type;
	string2		clean_OWNER_1_STREET_ADDRESS_ace_fips_st;
	string3		clean_OWNER_1_STREET_ADDRESS_fipscounty;
	string10	clean_OWNER_1_STREET_ADDRESS_geo_lat;
	string11	clean_OWNER_1_STREET_ADDRESS_geo_long;
	string4		clean_OWNER_1_STREET_ADDRESS_msa;
	string7		clean_OWNER_1_STREET_ADDRESS_geo_blk;
	string1		clean_OWNER_1_STREET_ADDRESS_geo_match;
	string4		clean_OWNER_1_STREET_ADDRESS_err_stat;
	string10	clean_OWNER_1_MAIL_ADDRESS_prim_range;
	string2		clean_OWNER_1_MAIL_ADDRESS_predir;
	string28	clean_OWNER_1_MAIL_ADDRESS_prim_name;
	string4		clean_OWNER_1_MAIL_ADDRESS_addr_suffix;
	string2		clean_OWNER_1_MAIL_ADDRESS_postdir;
	string10	clean_OWNER_1_MAIL_ADDRESS_unit_desig;
	string8		clean_OWNER_1_MAIL_ADDRESS_sec_range; 
	string25	clean_OWNER_1_MAIL_ADDRESS_p_city_name;
	string25	clean_OWNER_1_MAIL_ADDRESS_v_city_name;
	string2		clean_OWNER_1_MAIL_ADDRESS_st;
	string5		clean_OWNER_1_MAIL_ADDRESS_zip;
	string4		clean_OWNER_1_MAIL_ADDRESS_zip4;
	string4		clean_OWNER_1_MAIL_ADDRESS_cart;
	string1		clean_OWNER_1_MAIL_ADDRESS_cr_sort_sz;
	string4		clean_OWNER_1_MAIL_ADDRESS_lot;
	string1		clean_OWNER_1_MAIL_ADDRESS_lot_order;
	string2		clean_OWNER_1_MAIL_ADDRESS_dpbc;
	string1		clean_OWNER_1_MAIL_ADDRESS_chk_digit;
	string2		clean_OWNER_1_MAIL_ADDRESS_record_type;
	string2		clean_OWNER_1_MAIL_ADDRESS_ace_fips_st;
	string3		clean_OWNER_1_MAIL_ADDRESS_fipscounty;
	string10	clean_OWNER_1_MAIL_ADDRESS_geo_lat;
	string11	clean_OWNER_1_MAIL_ADDRESS_geo_long;
	string4		clean_OWNER_1_MAIL_ADDRESS_msa;
	string7		clean_OWNER_1_MAIL_ADDRESS_geo_blk;
	string1		clean_OWNER_1_MAIL_ADDRESS_geo_match;
	string4		clean_OWNER_1_MAIL_ADDRESS_err_stat;
	string10	clean_OWNER_2_STREET_ADDRESS_prim_range;
	string2		clean_OWNER_2_STREET_ADDRESS_predir;
	string28	clean_OWNER_2_STREET_ADDRESS_prim_name;
	string4		clean_OWNER_2_STREET_ADDRESS_addr_suffix;
	string2		clean_OWNER_2_STREET_ADDRESS_postdir;
	string10	clean_OWNER_2_STREET_ADDRESS_unit_desig;
	string8		clean_OWNER_2_STREET_ADDRESS_sec_range; 
	string25	clean_OWNER_2_STREET_ADDRESS_p_city_name;
	string25	clean_OWNER_2_STREET_ADDRESS_v_city_name;
	string2		clean_OWNER_2_STREET_ADDRESS_st;
	string5		clean_OWNER_2_STREET_ADDRESS_zip;
	string4		clean_OWNER_2_STREET_ADDRESS_zip4;
	string4		clean_OWNER_2_STREET_ADDRESS_cart;
	string1		clean_OWNER_2_STREET_ADDRESS_cr_sort_sz;
	string4		clean_OWNER_2_STREET_ADDRESS_lot;
	string1		clean_OWNER_2_STREET_ADDRESS_lot_order;
	string2		clean_OWNER_2_STREET_ADDRESS_dpbc;
	string1		clean_OWNER_2_STREET_ADDRESS_chk_digit;
	string2		clean_OWNER_2_STREET_ADDRESS_record_type;
	string2		clean_OWNER_2_STREET_ADDRESS_ace_fips_st;
	string3		clean_OWNER_2_STREET_ADDRESS_fipscounty;
	string10	clean_OWNER_2_STREET_ADDRESS_geo_lat;
	string11	clean_OWNER_2_STREET_ADDRESS_geo_long;
	string4		clean_OWNER_2_STREET_ADDRESS_msa;
	string7		clean_OWNER_2_STREET_ADDRESS_geo_blk;
	string1		clean_OWNER_2_STREET_ADDRESS_geo_match;
	string4		clean_OWNER_2_STREET_ADDRESS_err_stat;
	string10	clean_OWNER_2_MAIL_ADDRESS_prim_range;
	string2		clean_OWNER_2_MAIL_ADDRESS_predir;
	string28	clean_OWNER_2_MAIL_ADDRESS_prim_name;
	string4		clean_OWNER_2_MAIL_ADDRESS_addr_suffix;
	string2		clean_OWNER_2_MAIL_ADDRESS_postdir;
	string10	clean_OWNER_2_MAIL_ADDRESS_unit_desig;
	string8		clean_OWNER_2_MAIL_ADDRESS_sec_range; 
	string25	clean_OWNER_2_MAIL_ADDRESS_p_city_name;
	string25	clean_OWNER_2_MAIL_ADDRESS_v_city_name;
	string2		clean_OWNER_2_MAIL_ADDRESS_st;
	string5		clean_OWNER_2_MAIL_ADDRESS_zip;
	string4		clean_OWNER_2_MAIL_ADDRESS_zip4;
	string4		clean_OWNER_2_MAIL_ADDRESS_cart;
	string1		clean_OWNER_2_MAIL_ADDRESS_cr_sort_sz;
	string4		clean_OWNER_2_MAIL_ADDRESS_lot;
	string1		clean_OWNER_2_MAIL_ADDRESS_lot_order;
	string2		clean_OWNER_2_MAIL_ADDRESS_dpbc;
	string1		clean_OWNER_2_MAIL_ADDRESS_chk_digit;
	string2		clean_OWNER_2_MAIL_ADDRESS_record_type;
	string2		clean_OWNER_2_MAIL_ADDRESS_ace_fips_st;
	string3		clean_OWNER_2_MAIL_ADDRESS_fipscounty;
	string10	clean_OWNER_2_MAIL_ADDRESS_geo_lat;
	string11	clean_OWNER_2_MAIL_ADDRESS_geo_long;
	string4		clean_OWNER_2_MAIL_ADDRESS_msa;
	string7		clean_OWNER_2_MAIL_ADDRESS_geo_blk;
	string1		clean_OWNER_2_MAIL_ADDRESS_geo_match;
	string4		clean_OWNER_2_MAIL_ADDRESS_err_stat;
	string10	clean_REG_1_STREET_ADDRESS_prim_range;
	string2		clean_REG_1_STREET_ADDRESS_predir;
	string28	clean_REG_1_STREET_ADDRESS_prim_name;
	string4		clean_REG_1_STREET_ADDRESS_addr_suffix;
	string2		clean_REG_1_STREET_ADDRESS_postdir;
	string10	clean_REG_1_STREET_ADDRESS_unit_desig;
	string8		clean_REG_1_STREET_ADDRESS_sec_range; 
	string25	clean_REG_1_STREET_ADDRESS_p_city_name;
	string25	clean_REG_1_STREET_ADDRESS_v_city_name;
	string2		clean_REG_1_STREET_ADDRESS_st;
	string5		clean_REG_1_STREET_ADDRESS_zip;
	string4		clean_REG_1_STREET_ADDRESS_zip4;
	string4		clean_REG_1_STREET_ADDRESS_cart;
	string1		clean_REG_1_STREET_ADDRESS_cr_sort_sz;
	string4		clean_REG_1_STREET_ADDRESS_lot;
	string1		clean_REG_1_STREET_ADDRESS_lot_order;
	string2		clean_REG_1_STREET_ADDRESS_dpbc;
	string1		clean_REG_1_STREET_ADDRESS_chk_digit;
	string2		clean_REG_1_STREET_ADDRESS_record_type;
	string2		clean_REG_1_STREET_ADDRESS_ace_fips_st;
	string3		clean_REG_1_STREET_ADDRESS_fipscounty;
	string10	clean_REG_1_STREET_ADDRESS_geo_lat;
	string11	clean_REG_1_STREET_ADDRESS_geo_long;
	string4		clean_REG_1_STREET_ADDRESS_msa;
	string7		clean_REG_1_STREET_ADDRESS_geo_blk;
	string1		clean_REG_1_STREET_ADDRESS_geo_match;
	string4		clean_REG_1_STREET_ADDRESS_err_stat;
	string10	clean_REG_1_MAIL_ADDRESS_prim_range;
	string2		clean_REG_1_MAIL_ADDRESS_predir;
	string28	clean_REG_1_MAIL_ADDRESS_prim_name;
	string4		clean_REG_1_MAIL_ADDRESS_addr_suffix;
	string2		clean_REG_1_MAIL_ADDRESS_postdir;
	string10	clean_REG_1_MAIL_ADDRESS_unit_desig;
	string8		clean_REG_1_MAIL_ADDRESS_sec_range; 
	string25	clean_REG_1_MAIL_ADDRESS_p_city_name;
	string25	clean_REG_1_MAIL_ADDRESS_v_city_name;
	string2		clean_REG_1_MAIL_ADDRESS_st;
	string5		clean_REG_1_MAIL_ADDRESS_zip;
	string4		clean_REG_1_MAIL_ADDRESS_zip4;
	string4		clean_REG_1_MAIL_ADDRESS_cart;
	string1		clean_REG_1_MAIL_ADDRESS_cr_sort_sz;
	string4		clean_REG_1_MAIL_ADDRESS_lot;
	string1		clean_REG_1_MAIL_ADDRESS_lot_order;
	string2		clean_REG_1_MAIL_ADDRESS_dpbc;
	string1		clean_REG_1_MAIL_ADDRESS_chk_digit;
	string2		clean_REG_1_MAIL_ADDRESS_record_type;
	string2		clean_REG_1_MAIL_ADDRESS_ace_fips_st;
	string3		clean_REG_1_MAIL_ADDRESS_fipscounty;
	string10	clean_REG_1_MAIL_ADDRESS_geo_lat;
	string11	clean_REG_1_MAIL_ADDRESS_geo_long;
	string4		clean_REG_1_MAIL_ADDRESS_msa;
	string7		clean_REG_1_MAIL_ADDRESS_geo_blk;
	string1		clean_REG_1_MAIL_ADDRESS_geo_match;
	string4		clean_REG_1_MAIL_ADDRESS_err_stat;
	string10	clean_REG_2_STREET_ADDRESS_prim_range;
	string2		clean_REG_2_STREET_ADDRESS_predir;
	string28	clean_REG_2_STREET_ADDRESS_prim_name;
	string4		clean_REG_2_STREET_ADDRESS_addr_suffix;
	string2		clean_REG_2_STREET_ADDRESS_postdir;
	string10	clean_REG_2_STREET_ADDRESS_unit_desig;
	string8		clean_REG_2_STREET_ADDRESS_sec_range; 
	string25	clean_REG_2_STREET_ADDRESS_p_city_name;
	string25	clean_REG_2_STREET_ADDRESS_v_city_name;
	string2		clean_REG_2_STREET_ADDRESS_st;
	string5		clean_REG_2_STREET_ADDRESS_zip;
	string4		clean_REG_2_STREET_ADDRESS_zip4;
	string4		clean_REG_2_STREET_ADDRESS_cart;
	string1		clean_REG_2_STREET_ADDRESS_cr_sort_sz;
	string4		clean_REG_2_STREET_ADDRESS_lot;
	string1		clean_REG_2_STREET_ADDRESS_lot_order;
	string2		clean_REG_2_STREET_ADDRESS_dpbc;
	string1		clean_REG_2_STREET_ADDRESS_chk_digit;
	string2		clean_REG_2_STREET_ADDRESS_record_type;
	string2		clean_REG_2_STREET_ADDRESS_ace_fips_st;
	string3		clean_REG_2_STREET_ADDRESS_fipscounty;
	string10	clean_REG_2_STREET_ADDRESS_geo_lat;
	string11	clean_REG_2_STREET_ADDRESS_geo_long;
	string4		clean_REG_2_STREET_ADDRESS_msa;
	string7		clean_REG_2_STREET_ADDRESS_geo_blk;
	string1		clean_REG_2_STREET_ADDRESS_geo_match;
	string4		clean_REG_2_STREET_ADDRESS_err_stat;
	string10	clean_REG_2_MAIL_ADDRESS_prim_range;
	string2		clean_REG_2_MAIL_ADDRESS_predir;
	string28	clean_REG_2_MAIL_ADDRESS_prim_name;
	string4		clean_REG_2_MAIL_ADDRESS_addr_suffix;
	string2		clean_REG_2_MAIL_ADDRESS_postdir;
	string10	clean_REG_2_MAIL_ADDRESS_unit_desig;
	string8		clean_REG_2_MAIL_ADDRESS_sec_range; 
	string25	clean_REG_2_MAIL_ADDRESS_p_city_name;
	string25	clean_REG_2_MAIL_ADDRESS_v_city_name;
	string2		clean_REG_2_MAIL_ADDRESS_st;
	string5		clean_REG_2_MAIL_ADDRESS_zip;
	string4		clean_REG_2_MAIL_ADDRESS_zip4;
	string4		clean_REG_2_MAIL_ADDRESS_cart;
	string1		clean_REG_2_MAIL_ADDRESS_cr_sort_sz;
	string4		clean_REG_2_MAIL_ADDRESS_lot;
	string1		clean_REG_2_MAIL_ADDRESS_lot_order;
	string2		clean_REG_2_MAIL_ADDRESS_dpbc;
	string1		clean_REG_2_MAIL_ADDRESS_chk_digit;
	string2		clean_REG_2_MAIL_ADDRESS_record_type;
	string2		clean_REG_2_MAIL_ADDRESS_ace_fips_st;
	string3		clean_REG_2_MAIL_ADDRESS_fipscounty;
	string10	clean_REG_2_MAIL_ADDRESS_geo_lat;
	string11	clean_REG_2_MAIL_ADDRESS_geo_long;
	string4		clean_REG_2_MAIL_ADDRESS_msa;
	string7		clean_REG_2_MAIL_ADDRESS_geo_blk;
	string1		clean_REG_2_MAIL_ADDRESS_geo_match;
	string4		clean_REG_2_MAIL_ADDRESS_err_stat;
end;