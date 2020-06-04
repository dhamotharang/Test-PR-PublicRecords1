import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_source_rid(String pversion) := FUNCTION
source_rid_layout:=RECORD
  unsigned8 source_rid;
  string2 src;
  unsigned6 lnpid;
  string20 fname_preferredname;
  string20 fname;
  string28 lname;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  string25 v_city_name;
  string2 st;
  string1 gender;
  string20 mname;
  string5 sname_normsuffix;
  string5 sname;
  unsigned1 fname_len;
  unsigned1 lname_len;
  unsigned1 mname_len;
  integer2 source_rid_weight100;
  integer2 src_weight100;
  integer2 fname_weight100;
  integer2 fname_mainname_weight100;
  integer2 fname_mainname_fuzzy_weight100;
  integer2 fname_initial_char_weight100;
  integer2 fname_p_weight100;
  integer2 fname_e1_weight100;
  integer2 fname_e1p_weight100;
  integer2 fname_e2_weight100;
  integer2 fname_e2p_weight100;
  integer2 fname_preferredname_weight100;
  unsigned8 fname_mainname_cnt;
  integer2 lname_weight100;
  integer2 lname_mainname_weight100;
  integer2 lname_mainname_fuzzy_weight100;
  integer2 lname_initial_char_weight100;
  integer2 lname_p_weight100;
  integer2 lname_e1_weight100;
  integer2 lname_e1p_weight100;
  integer2 lname_e2_weight100;
  integer2 lname_e2p_weight100;
  unsigned8 lname_mainname_cnt;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  integer2 v_city_name_weight100;
  integer2 st_weight100;
  integer2 gender_weight100;
  integer2 mname_weight100;
  integer2 mname_mainname_weight100;
  integer2 mname_mainname_fuzzy_weight100;
  integer2 mname_initial_char_weight100;
  integer2 mname_p_weight100;
  integer2 mname_e1_weight100;
  integer2 mname_e1p_weight100;
  integer2 mname_e2_weight100;
  integer2 mname_e2p_weight100;
  unsigned8 mname_mainname_cnt;
  integer2 sname_weight100;
  integer2 sname_normsuffix_weight100;
  unsigned8 __internal_fpos__;
 END;
 
 source_rid_Build :=  DATASET([ ],source_rid_layout);
 source_rid_key := INDEX(source_rid_Build,
 {source_rid,
 src,
 lnpid,
 fname_preferredname,
 fname,
 lname,
 dob_year,
 dob_month,
 dob_day,
 v_city_name,
 st,
 gender,
 mname,
 sname_normsuffix,
 sname,
 fname_len,
 lname_len,
 mname_len,
 source_rid_weight100,
 src_weight100,
 fname_weight100,
 fname_mainname_weight100,
 fname_mainname_fuzzy_weight100,
 fname_initial_char_weight100,
 fname_p_weight100,
 fname_e1_weight100,
 fname_e1p_weight100,
 fname_e2_weight100,
 fname_e2p_weight100,
 fname_preferredname_weight100,
 fname_mainname_cnt,
 lname_weight100,
 lname_mainname_weight100,
 lname_mainname_fuzzy_weight100,
lname_initial_char_weight100,
 lname_p_weight100,
 lname_e1_weight100,
 lname_e1p_weight100,
 lname_e2_weight100,
 lname_e2p_weight100,
 lname_mainname_cnt,
 dob_year_weight100,
 dob_month_weight100,
 dob_day_weight100,
 v_city_name_weight100,
 st_weight100,
 gender_weight100,
 mname_weight100,
 mname_mainname_weight100,
 mname_mainname_fuzzy_weight100,
 mname_initial_char_weight100,
 mname_p_weight100,
 mname_e1_weight100,
 mname_e1p_weight100,
 mname_e2_weight100,
 mname_e2p_weight100,
 mname_mainname_cnt,
  sname_weight100,
 sname_normsuffix_weight100},{source_rid_Build},
	 prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::source::rid'); 
  
	BUILDindex(source_rid_Key);
 
 return 'Successful';
 end;
