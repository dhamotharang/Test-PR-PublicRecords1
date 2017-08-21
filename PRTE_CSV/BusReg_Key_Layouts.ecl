EXPORT BusReg_Key_Layouts := MODULE

  EXPORT rthor_data400__key__busreg__company_bdid	:= RECORD
    UNSIGNED6 bdid;
    UNSIGNED6 br_id;
    STRING8 dt_first_seen;
    STRING8 dt_last_seen;
    STRING1 record_type;
    STRING8 record_date;
    STRING40 ofc1_name;
    STRING5 ofc1_title;
    STRING25 first_name;
    STRING1 mi;
    STRING25 last_name;
    STRING5 suffix;
    STRING1 gender;
    STRING1 ownr_code;
    STRING1 xcode;
    STRING50 company_name;
    STRING50 mail_add;
    STRING30 mail_suite;
    STRING30 mail_city;
    STRING2 mail_state;
    STRING5 mail_zip_orig;
    STRING4 mail_zip4_orig;
    STRING1 mail_key;
    STRING15 county;
    STRING15 country;
    STRING25 district;
    STRING1 citylimits;
    STRING3 biz_ac;
    STRING10 biz_phone;
    STRING3 fax_ac;
    STRING10 fax_num;
    STRING4 sic;
    STRING6 naics;
    STRING59 descript;
    STRING4 emp_size;
    STRING2 own_size;
    STRING2 corpcode;
    STRING4 sos_code;
    STRING4 filing_cod;
    STRING2 state_code;
    STRING2 status;
    STRING50 stat_des;
    STRING2 lic_sts;
    STRING3 lic_type;
    STRING20 filing_num;
    STRING15 licid;
    STRING5 acct_num;
    STRING15 co_fei;
    STRING15 ctrl_num;
    STRING8 start_date;
    STRING12 file_date;
    STRING8 ccyymmdd;
    STRING8 form_date;
    STRING8 exp_date;
    STRING8 disol_date;
    STRING8 rpt_date;
    STRING8 renew_date;
    STRING8 chang_date;
    STRING8 appt_date;
    STRING8 fisc_date_;
    STRING10 duration;
    STRING50 loc_add;
    STRING30 loc_suite;
    STRING30 loc_city;
    STRING2 loc_state;
    STRING5 loc_zip_orig;
    STRING4 loc_zip4_orig;
    STRING10 loc_idx;
    STRING50 ofc1_add;
    STRING30 ofc1_suite;
    STRING30 ofc1_city;
    STRING2 ofc1_state;
    STRING10 ofc1_zip_orig;
    STRING3 ofc1_ac;
    STRING10 ofc1_phone;
    STRING15 ofc1_fein;
    STRING12 ofc1_ssn;
    STRING15 ofc1_type;
    STRING8 ra_date;
    STRING15 ra_file;
    STRING30 ra_name;
    STRING50 ra_add;
    STRING30 ra_suite;
    STRING30 ra_city;
    STRING2 ra_state;
    STRING10 ra_zip_orig;
    STRING3 ra_ac;
    STRING10 ra_phone;
    STRING5 class;
    STRING10 stock_iss;
    STRING7 stock_par;
    STRING10 stock_type;
    STRING7 stock_cap;
    STRING7 paidn_cap;
    STRING8 fee;
    STRING8 fee_2;
    STRING8 fee_3;
    STRING1 tax_cl;
    STRING10 act;
    STRING10 chapter;
    STRING4 page;
    STRING4 volume;
    STRING20 comments;
    STRING30 email_addr;
    STRING20 user_name;
    STRING1 dsf;
    STRING1 hmbase;
    STRING1 ho;
    STRING1 solicit;
    STRING10 fips;
    STRING14 record_no;
    STRING4 misc_code;
    STRING1 agent_key;
    STRING8 proc_date;
    STRING10 mail_prim_range;
    STRING2 mail_predir;
    STRING28 mail_prim_name;
    STRING4 mail_addr_suffix;
    STRING2 mail_postdir;
    STRING10 mail_unit_desig;
    STRING8 mail_sec_range;
    STRING25 mail_p_city_name;
    STRING25 mail_v_city_name;
    STRING2 mail_st;
    STRING5 mail_zip;
    STRING4 mail_zip4;
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
    STRING4 ra_err_stat;
    STRING10 company_phone10;
    STRING10 ofc1_phone10;
    STRING10 ra_phone10;
    UNSIGNED8 __internal_fpos__;
  END;

  old := RECORD
    STRING40 ofc1_name;
    STRING5 ofc1_title;
    STRING25 first;
    STRING1 mi;
    STRING25 last;
    STRING5 suffix;
    STRING1 gender;
    STRING1 ownr_code;
    STRING1 xcode;
    STRING50 company;
    STRING50 mail_add;
    STRING30 mail_suite;
    STRING30 mail_city;
    STRING2 mail_state;
    STRING5 mail_zip;
    STRING4 mail_zip4;
    STRING1 mail_key;
    STRING15 county;
    STRING15 country;
    STRING25 district;
    STRING1 citylimits;
    STRING3 biz_ac;
    STRING10 biz_phone;
    STRING3 fax_ac;
    STRING10 fax_num;
    STRING4 sic;
    STRING6 naics;
    STRING59 descript;
    STRING4 emp_size;
    STRING2 own_size;
    STRING2 corpcode;
    STRING4 sos_code;
    STRING4 filing_cod;
    STRING2 state_code;
    STRING2 status;
    STRING50 stat_des;
    STRING2 lic_sts;
    STRING3 lic_type;
    STRING20 filing_num;
    STRING15 licid;
    STRING5 acct_num;
    STRING15 co_fei;
    STRING15 ctrl_num;
    STRING8 start_date;
    STRING12 file_date;
    STRING8 ccyymmdd;
    STRING8 form_date;
    STRING8 exp_date;
    STRING8 disol_date;
    STRING8 rpt_date;
    STRING8 renew_date;
    STRING8 chang_date;
    STRING8 appt_date;
    STRING8 fisc_date_;
    STRING10 duration;
    STRING50 loc_add;
    STRING30 loc_suite;
    STRING30 loc_city;
    STRING2 loc_state;
    STRING5 loc_zip;
    STRING4 loc_zip4;
    STRING10 loc_idx;
    STRING50 ofc1_add;
    STRING30 ofc1_suite;
    STRING30 ofc1_city;
    STRING2 ofc1_state;
    STRING10 ofc1_zip;
    STRING3 ofc1_ac;
    STRING10 ofc1_phone;
    STRING15 ofc1_fein;
    STRING12 ofc1_ssn;
    STRING15 ofc1_type;
    STRING40 ofc2_name;
    STRING5 ofc2_title;
    STRING50 ofc2_add;
    STRING50 ofc2_csz;
    STRING15 ofc2_fein;
    STRING12 ofc2_ssn;
    STRING40 ofc3_name;
    STRING5 ofc3_title;
    STRING50 ofc3_add;
    STRING50 ofc3_csz;
    STRING15 ofc3_fein;
    STRING12 ofc3_ssn;
    STRING40 ofc4_name;
    STRING5 ofc4_title;
    STRING50 ofc4_add;
    STRING50 ofc4_csz;
    STRING15 ofc4_fein;
    STRING12 ofc4_ssn;
    STRING40 ofc5_name;
    STRING5 ofc5_title;
    STRING50 ofc5_add;
    STRING50 ofc5_csz;
    STRING15 ofc5_fein;
    STRING12 ofc5_ssn;
    STRING40 ofc6_name;
    STRING5 ofc6_title;
    STRING50 ofc6_add;
    STRING50 ofc6_csz;
    STRING15 ofc6_fein;
    STRING12 ofc6_ssn;
    STRING8 ra_date;
    STRING15 ra_file;
    STRING30 ra_name;
    STRING50 ra_add;
    STRING30 ra_suite;
    STRING30 ra_city;
    STRING2 ra_state;
    STRING10 ra_zip;
    STRING3 ra_ac;
    STRING10 ra_phone;
    STRING5 class;
    STRING10 stock_iss;
    STRING7 stock_par;
    STRING10 stock_type;
    STRING7 stock_cap;
    STRING7 paidn_cap;
    STRING8 fee;
    STRING8 fee_2;
    STRING8 fee_3;
    STRING1 tax_cl;
    STRING10 act;
    STRING10 chapter;
    STRING4 page;
    STRING4 volume;
    STRING20 comments;
    STRING30 email;
    STRING20 user_name;
    STRING1 dsf;
    STRING1 hmbase;
    STRING1 ho;
    STRING1 solicit;
    STRING10 fips;
    STRING14 record_no;
    STRING4 misc_code;
    STRING1 agent_key;
    STRING8 proc_date;
    STRING2 crlf;
  END;

  layout_clean_name := RECORD
    STRING5 title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
    STRING3 name_score;
  END;

  layout_clean182_fips := RECORD
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip;
    STRING4 zip4;
    STRING4 cart;
    STRING1 cr_sort_sz;
    STRING4 lot;
    STRING1 lot_order;
    STRING2 dbpc;
    STRING1 chk_digit;
    STRING2 rec_type;
    STRING2 fips_state;
    STRING3 fips_county;
    STRING10 geo_lat;
    STRING11 geo_long;
    STRING4 msa;
    STRING7 geo_blk;
    STRING1 geo_match;
    STRING4 err_stat;
  END;

  cleaned_dates := RECORD
    UNSIGNED4 start_date;
    UNSIGNED4 file_date;
    UNSIGNED4 ccyymmdd;
    UNSIGNED4 form_date;
    UNSIGNED4 exp_date;
    UNSIGNED4 disol_date;
    UNSIGNED4 rpt_date;
    UNSIGNED4 renew_date;
    UNSIGNED4 chang_date;
    UNSIGNED4 appt_date;
    UNSIGNED4 fisc_date_;
    UNSIGNED4 proc_date;
  END;

  cleaned_phones := RECORD
    STRING10 biz_phone;
    STRING10 ofc1_phone;
    STRING10 ra_phone;
  END;

 
  EXPORT rthor_data400__key__busreg__company_linkids := RECORD
    UNSIGNED6 ultid;
    UNSIGNED6 orgid;
    UNSIGNED6 seleid;
    UNSIGNED6 proxid;
    UNSIGNED6 powid;
    UNSIGNED6 empid;
    UNSIGNED6 dotid;
    UNSIGNED2 ultscore;
    UNSIGNED2 orgscore;
    UNSIGNED2 selescore;
    UNSIGNED2 proxscore;
    UNSIGNED2 powscore;
    UNSIGNED2 empscore;
    UNSIGNED2 dotscore;
    UNSIGNED2 ultweight;
    UNSIGNED2 orgweight;
    UNSIGNED2 seleweight;
    UNSIGNED2 proxweight;
    UNSIGNED2 powweight;
    UNSIGNED2 empweight;
    UNSIGNED2 dotweight;
    UNSIGNED6 bdid;
    UNSIGNED1 bdid_score;
    UNSIGNED6 br_id;
    UNSIGNED4 dt_first_seen;
    UNSIGNED4 dt_last_seen;
    UNSIGNED4 dt_vendor_first_reported;
    UNSIGNED4 dt_vendor_last_reported;
    STRING1 record_type;
    UNSIGNED4 record_date;
    old rawfields;
    layout_clean_name clean_officer1_name;
    layout_clean_name clean_officer2_name;
    layout_clean_name clean_officer3_name;
    layout_clean_name clean_officer4_name;
    layout_clean_name clean_officer5_name;
    layout_clean_name clean_officer6_name;
    layout_clean182_fips clean_mailing_address;
    layout_clean182_fips clean_location_address;
    layout_clean182_fips clean_ra_address;
    layout_clean182_fips clean_officer1_address;
    layout_clean182_fips clean_officer2_address;
    layout_clean182_fips clean_officer3_address;
    layout_clean182_fips clean_officer4_address;
    layout_clean182_fips clean_officer5_address;
    layout_clean182_fips clean_officer6_address;
    cleaned_dates clean_dates;
    cleaned_phones clean_phones;
    STRING100 clean_mailing_address1;
    STRING50 clean_mailing_address2;
    STRING100 clean_location_address1;
    STRING50 clean_location_address2;
    STRING100 clean_ra_address1;
    STRING50 clean_ra_address2;
    STRING100 clean_officer1_address1;
    STRING50 clean_officer1_address2;
    STRING100 clean_officer2_address1;
    STRING50 clean_officer2_address2;
    STRING100 clean_officer3_address1;
    STRING50 clean_officer3_address2;
    STRING100 clean_officer4_address1;
    STRING50 clean_officer4_address2;
    STRING100 clean_officer5_address1;
    STRING50 clean_officer5_address2;
    STRING100 clean_officer6_address1;
    STRING50 clean_officer6_address2;
    UNSIGNED8 append_mailrawaid;
    UNSIGNED8 append_mailaceaid;
    UNSIGNED8 append_locrawaid;
    UNSIGNED8 append_locaceaid;
    UNSIGNED8 append_rarawaid;
    UNSIGNED8 append_raaceaid;
    UNSIGNED8 append_off1rawaid;
    UNSIGNED8 append_off1aceaid;
    UNSIGNED8 append_off2rawaid;
    UNSIGNED8 append_off2aceaid;
    UNSIGNED8 append_off3rawaid;
    UNSIGNED8 append_off3aceaid;
    UNSIGNED8 append_off4rawaid;
    UNSIGNED8 append_off4aceaid;
    UNSIGNED8 append_off5rawaid;
    UNSIGNED8 append_off5aceaid;
    UNSIGNED8 append_off6rawaid;
    UNSIGNED8 append_off6aceaid;
    UNSIGNED8 source_rec_id;
    INTEGER1 fp;	
  END; 
 
  EXPORT rthor_data400__key__busreg__contact_bdid := RECORD
    UNSIGNED6 bdid;
    UNSIGNED6 did;
    UNSIGNED6 br_id;
    STRING8 dt_first_seen;
    STRING8 dt_last_seen;
    STRING1 record_type;
    STRING40 name;
    STRING5 title;
    STRING50 add;
    STRING50 csz;
    STRING15 fein;
    STRING12 ssn;
    STRING10 phone;
    STRING5 name_prefix;
    STRING20 name_first;
    STRING20 name_middle;
    STRING20 name_last;
    STRING5 name_suffix;
    STRING3 name_score;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip;
    STRING4 zip4;
    STRING4 cart;
    STRING1 cr_sort_sz;
    STRING4 lot;
    STRING1 lot_order;
    STRING2 dpbc;
    STRING1 chk_digit;
    STRING2 rec_type;
    STRING2 ace_fips_st;
    STRING3 fipscounty;
    STRING10 geo_lat;
    STRING11 geo_long;
    STRING4 msa;
    STRING7 geo_blk;
    STRING1 geo_match;
    STRING4 err_stat;
    UNSIGNED8 __internal_fpos__;
  END;
 
END;