IMPORT Address;

export Layout_SKA_Nixie_In := record
  // string5 PRENAME;
  string5     TTL;               //Formerly PRENAME
  string15    FIRST_NAME;
  string1     MIDDLE;
  string15    LAST_NAME;
  // string35		DEPT_TITLE;
  string35    T1;                //Formerly DEPT_TITLE
  string3     DEPT_CODE;
  string31    DEPT_EXPL;
  string3     SPEC;
  string31    SPEC_EXPL;
  string40    DEPT_FILE;
  // string31    COMPANY_NAME;
  string31    COMPANY1;          //Formerly COMPANY_NAME
  string31    ADDRESS1;
  string17    CITY;
  string2     STATE;
  string10    ZIP;
  string3     AREA_CODE;
  // string8     PHONE;
  string8     NUMBER;             //Formerly PHONE
  string7     ID;
  string10    PERSID;             //Changed from length of 7
  string10    NIXIE_DATE;

  Address.Layout_Clean_Name;
  // string5     title;
  // string20    fname;
  // string20    mname;
  // string20    lname;
  // string5     name_suffix;
  // string3     name_score;
  string10    mail_prim_range;
  string2     mail_predir;
  string28    mail_prim_name;
  string4     mail_addr_suffix;
  string2     mail_postdir;
  string10    mail_unit_desig;
  string8     mail_sec_range;
  string25    mail_p_city_name;
  string25    mail_v_city_name;
  string2     mail_st;
  string5     mail_zip;
  string4     mail_zip4;
  string4     mail_cart;
  string1     mail_cr_sort_sz;
  string4     mail_lot;
  string1     mail_lot_order;
  string2     mail_dbpc;
  string1     mail_chk_digit;
  string2     mail_rec_type;
  string2     mail_ace_fips_state;
  string3     mail_county;
  string10    mail_geo_lat;
  string11    mail_geo_long;
  string4     mail_msa;
  string7     mail_geo_blk;
  string1     mail_geo_match;
  string4     mail_err_stat;
  // string1     lf;
end;