﻿Import Prte2;
Export billing_group_key:=RECORD
  string38 billing_group_key;
  string38 group_key;
  string11 prac_addr_confidence_score;
  string11 bill_addr_confidence_score;
  string20 addr_key;
  string10 addr_phone;
  string10 sloc_phone;
  string38 sloc_group_key;
  string50 bill_npi;
  string50 bill_tin;
  string10 cam_latest;
  string10 cam_earliest;
  unsigned5 cbm1;
  unsigned5 cbm3;
  unsigned5 cbm6;
  unsigned5 cbm12;
  unsigned5 cbm18;
  string1 pgk_works_for;
  string1 pgk_is_affiliated_to;
  string80 sloc_type;
  string80 billing_type;
  unsigned6 pid;
  string2 src;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string1 record_type;
  unsigned8 source_rid;
  unsigned8 lnpid;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  string100 prepped_name;
  string1 normed_name_rec_type;
  string100 clean_company_name;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string1 nametype;
  unsigned8 nid;
  string50 prepped_addr1;
  string39 prepped_addr2;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_st;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
  unsigned8 aceaid;
  unsigned4 clean_cam_latest;
  unsigned4 clean_cam_earliest;
  string10 clean_phone;
  string10 clean_sloc_phone;
  string8 clean_dob;
  unsigned4 best_dob;
  string9 clean_ssn;
  string9 best_ssn;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  PRTE2.LAYOUTS.DEFLT_CPA;
 END;
