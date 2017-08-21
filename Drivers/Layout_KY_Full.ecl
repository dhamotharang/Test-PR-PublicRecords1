export Layout_KY_Full
 :=
  record
    string08    append_PROCESS_DATE;
    string09    orig_DL_NUMBER;
    string25    orig_LAST_NAME;
    string15    orig_FIRST_NAME;
    string10    orig_MIDDLE_NAME;
    string08    orig_DOB;
    string01    orig_SEX;
    string03    orig_HEIGHT;
    string03    orig_WEIGHT;
    string01    orig_LICENSE_CLASS;
    string01    orig_EYE_COLOR;
    string30    orig_ADDRESS;
    string15    orig_CITY;
    string02    orig_STATE;
    string09    orig_ZIP;
    string08    orig_ISSUE_DATE;
    string08    orig_EXPIRATION_DATE;
    string04    orig_ISSUE_LOCATION;
    string03    orig_RESIDENCE_COUNTY;
    string06    orig_ENDORSEMENTS;
    string10    orig_RESTRICTIONS;
    string01    orig_LICENSE_TYPE;
    string30    orig_MAIL_ADDRESS;
    string15    orig_MAIL_CITY;
    string02    orig_MAIL_STATE;
    string09    orig_MAIL_ZIP;
    string01    orig_FILLER;
    string02    orig_CRLF;
    string5     clean_name_prefix;
    string20    clean_name_first;
    string20    clean_name_middle;
    string20    clean_name_last;
    string5     clean_name_suffix;
    string3     clean_name_score;
    string10    clean_prim_range;
    string2     clean_predir;
    string28    clean_prim_name;
    string4     clean_addr_suffix;
    string2     clean_postdir;
    string10    clean_unit_desig;
    string8     clean_sec_range;
    string25    clean_p_city_name;
    string25    clean_v_city_name;
    string2     clean_st;
    string5     clean_zip;
    string4     clean_zip4;
    string4     clean_cart;
    string1     clean_cr_sort_sz;
    string4     clean_lot;
    string1     clean_lot_order;
    string2     clean_dpbc;
    string1     clean_chk_digit;
    string2     clean_record_type;
    string2     clean_ace_fips_st;
    string3     clean_fipscounty;
    string10    clean_geo_lat;
    string11    clean_geo_long;
    string4     clean_msa;
    string7     clean_geo_blk;
    string1     clean_geo_match;
    string4     clean_err_stat;
  end
 ;