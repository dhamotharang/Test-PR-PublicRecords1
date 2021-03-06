export Layout_ID_Full
 := record
    string8 	append_PROCESS_DATE;
    string2		orig_ISSUE_TYPE;
    string2		orig_LICENSE_CLASS;
    string8		orig_ISSUE_DATE;
    string6		orig_EXPIRATION_DATE;
    string3		orig_RESIDENCE_COUNTY;
    string1		orig_SEX;
    string8		orig_RESTRICTIONS;
    string8		orig_DOB;
    string1		orig_DPPA;
    string26	orig_NAME;
    string20	orig_ADDRESS2;
    string20	orig_ADDRESS1;
    string15	orig_CITY;
    string2		orig_STATE;
    string9		orig_ZIP_CODE;
    string40	orig_MAIL_ADDRESS;
    string15	orig_MAIL_CITY;
    string2		orig_MAIL_STATE;
    string9		orig_MAIL_ZIP_CODE;
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
  end;