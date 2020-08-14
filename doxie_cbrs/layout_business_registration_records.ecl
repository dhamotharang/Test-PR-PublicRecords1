
EXPORT layout_business_registration_records := RECORD
  UNSIGNED6 bdid;
  // UNSIGNED6 br_id; //Linking field to contact records
  // STRING8 dt_first_seen;
  // STRING8 dt_last_seen;
  // STRING1 record_type;
   STRING8 record_date;
  // STRING40 OFC1_NAME;
  // STRING5 OFC1_TITLE;
  // STRING25 FIRST_NAME;
  // STRING1 MI;
  // STRING25 LAST_NAME;
  // STRING5 SUFFIX;
  // STRING1 GENDER;
  // STRING1 OWNR_CODE; // 'C' indicates OFC1 is a corporation
  // STRING1 XCODE;
  STRING50 COMPANY_NAME;
  /*
  STRING50 MAIL_ADD;
  STRING30 MAIL_SUITE;
  STRING30 MAIL_CITY;
  STRING2 MAIL_STATE;
  STRING5 MAIL_ZIP_ORIG;
  STRING4 MAIL_ZIP4_ORIG;
  STRING1 MAIL_KEY;
  STRING15 COUNTY;
  STRING15 COUNTRY;
  STRING25 DISTRICT;
  STRING1 CITYLIMITS;
  STRING3 BIZ_AC;
  STRING10 BIZ_PHONE;
  STRING3 FAX_AC;
  STRING10 FAX_NUM;*/
  // STRING4 SIC;
  // STRING6 NAICS;
  STRING59 DESCRIPT;
  // STRING4 EMP_SIZE;
  // STRING2 OWN_SIZE;
  STRING2 CORPCODE;
  STRING4 SOS_CODE;
  STRING4 FILING_COD;
  STRING2 STATE_CODE;
  STRING2 STATUS;
  // STRING50 STAT_DES;
  // STRING2 LIC_STS;
  // STRING3 LIC_TYPE;
  STRING20 FILING_NUM;
  // STRING15 LICID;
  // STRING5 ACCT_NUM;
  // STRING15 CO_FEI;
  // STRING15 CTRL_NUM;
  // STRING8 START_DATE;
  STRING12 FILE_DATE;
  // STRING8 CCYYMMDD;
  // STRING8 FORM_DATE;
  STRING8 EXP_DATE;
  // STRING8 DISOL_DATE;
  // STRING8 RPT_DATE;
  // STRING8 RENEW_DATE;
  // STRING8 CHANG_DATE;
  // STRING8 APPT_DATE;
  // STRING8 FISC_DATE_;
  // STRING10 DURATION;
  /*
  STRING50 LOC_ADD;
  STRING30 LOC_SUITE;
  STRING30 LOC_CITY;
  STRING2 LOC_STATE;
  STRING5 LOC_ZIP_ORIG;
  STRING4 LOC_ZIP4_ORIG;
  STRING10 LOC_IDX;
  STRING50 OFC1_ADD;
  STRING30 OFC1_SUITE;
  STRING30 OFC1_CITY;
  STRING2 OFC1_STATE;
  STRING10 OFC1_ZIP_ORIG;
  STRING3 OFC1_AC;
  STRING10 OFC1_PHONE;
  STRING15 OFC1_FEIN;
  STRING12 OFC1_SSN;
  STRING15 OFC1_TYPE;
  STRING8 RA_DATE;
  STRING15 RA_FILE;
  STRING30 RA_NAME;
  STRING50 RA_ADD;
  STRING30 RA_SUITE;
  STRING30 RA_CITY;
  STRING2 RA_STATE;
  STRING10 RA_ZIP_ORIG;
  STRING3 RA_AC;
  STRING10 RA_PHONE;*/
  // STRING5 CLASS;
  // STRING10 STOCK_ISS;
  // STRING7 STOCK_PAR;
  // STRING10 STOCK_TYPE;
  // STRING7 STOCK_CAP;
  // STRING7 PAIDN_CAP;
  // STRING8 FEE;
  // STRING8 FEE_2;
  // STRING8 FEE_3;
  // STRING1 TAX_CL;
  // STRING10 ACT;
  // STRING10 CHAPTER;
  // STRING4 PAGE;
  // STRING4 VOLUME;
  // STRING20 COMMENTS;
  // STRING30 EMAIL_ADDR;
  // STRING20 USER_NAME;
  // STRING1 DSF;
  // STRING1 HMBASE;
  // STRING1 HO;
  // STRING1 SOLICIT;
  // STRING10 FIPS;
  // STRING14 RECORD_NO;
  // STRING4 MISC_CODE;
  // STRING1 AGENT_KEY;
  STRING8 PROC_DATE;
  STRING10 mail_prim_range;
  STRING2 mail_predir;
  STRING28 mail_prim_name;
  STRING4 mail_addr_suffix;
  STRING2 mail_postdir;
  STRING10 mail_unit_desig;
  STRING8 mail_sec_range;
  //STRING25 mail_p_city_name;
  STRING25 mail_v_city_name;
  STRING2 mail_st;
  STRING5 mail_zip;
  STRING4 mail_zip4;/*
  STRING4 mail_cart;
  STRING1 mail_cr_sort_sz;
  STRING4 mail_lot;
  STRING1 mail_lot_order;
  STRING2 mail_dpbc;
  STRING1 mail_chk_digit;
  STRING2 mail_record_type;
  STRING2 mail_ace_fips_st;
  STRING3 mail_fipscounty;
  STRING10 mail_geo_lat;
  STRING11 mail_geo_long;
  STRING4 mail_msa;
  STRING7 mail_geo_blk;
  STRING1 mail_geo_match;
  STRING4 mail_err_stat;
  STRING10 loc_prim_range;
  STRING2 loc_predir;
  STRING28 loc_prim_name;
  STRING4 loc_addr_suffix;
  STRING2 loc_postdir;
  STRING10 loc_unit_desig;
  STRING8 loc_sec_range;
  STRING25 loc_p_city_name;
  STRING25 loc_v_city_name;
  STRING2 loc_st;
  STRING5 loc_zip;
  STRING4 loc_zip4;
  STRING4 loc_cart;
  STRING1 loc_cr_sort_sz;
  STRING4 loc_lot;
  STRING1 loc_lot_order;
  STRING2 loc_dpbc;
  STRING1 loc_chk_digit;
  STRING2 loc_record_type;
  STRING2 loc_ace_fips_st;
  STRING3 loc_fipscounty;
  STRING10 loc_geo_lat;
  STRING11 loc_geo_long;
  STRING4 loc_msa;
  STRING7 loc_geo_blk;
  STRING1 loc_geo_match;
  STRING4 loc_err_stat;
  STRING5 ofc1_name_prefix;
  STRING20 ofc1_name_first;
  STRING20 ofc1_name_middle;
  STRING20 ofc1_name_last;
  STRING5 ofc1_name_suffix;
  STRING3 ofc1_name_score;
  STRING10 ofc1_prim_range;
  STRING2 ofc1_predir;
  STRING28 ofc1_prim_name;
  STRING4 ofc1_addr_suffix;
  STRING2 ofc1_postdir;
  STRING10 ofc1_unit_desig;
  STRING8 ofc1_sec_range;
  STRING25 ofc1_p_city_name;
  STRING25 ofc1_v_city_name;
  STRING2 ofc1_st;
  STRING5 ofc1_zip;
  STRING4 ofc1_zip4;
  STRING4 ofc1_cart;
  STRING1 ofc1_cr_sort_sz;
  STRING4 ofc1_lot;
  STRING1 ofc1_lot_order;
  STRING2 ofc1_dpbc;
  STRING1 ofc1_chk_digit;
  STRING2 ofc1_record_type;
  STRING2 ofc1_ace_fips_st;
  STRING3 ofc1_fipscounty;
  STRING10 ofc1_geo_lat;
  STRING11 ofc1_geo_long;
  STRING4 ofc1_msa;
  STRING7 ofc1_geo_blk;
  STRING1 ofc1_geo_match;
  STRING4 ofc1_err_stat;
  STRING10 ra_prim_range;
  STRING2 ra_predir;
  STRING28 ra_prim_name;
  STRING4 ra_addr_suffix;
  STRING2 ra_postdir;
  STRING10 ra_unit_desig;
  STRING8 ra_sec_range;
  STRING25 ra_p_city_name;
  STRING25 ra_v_city_name;
  STRING2 ra_st;
  STRING5 ra_zip;
  STRING4 ra_zip4;
  STRING4 ra_cart;
  STRING1 ra_cr_sort_sz;
  STRING4 ra_lot;
  STRING1 ra_lot_order;
  STRING2 ra_dpbc;
  STRING1 ra_chk_digit;
  STRING2 ra_record_type;
  STRING2 ra_ace_fips_st;
  STRING3 ra_fipscounty;
  STRING10 ra_geo_lat;
  STRING11 ra_geo_long;
  STRING4 ra_msa;
  STRING7 ra_geo_blk;
  STRING1 ra_geo_match;
  STRING4 ra_err_stat;*/
  STRING10 company_phone10;
  // STRING10 ofc1_phone10;
  // STRING10 ra_phone10;
  
  STRING50 corpcode_decode;
  STRING50 sos_code_decode;
  STRING10 filing_cod_decode;
  STRING15 status_decode;
  STRING8 file_date_decode;
  STRING8 proc_date_decode;
END;
