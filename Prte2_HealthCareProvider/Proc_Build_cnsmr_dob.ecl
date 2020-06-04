import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_cnsmr_dob(String pversion) := FUNCTION
cnsmr_dob_layout:=RECORD
  unsigned2 cnsmr_dob_year;
  unsigned1 cnsmr_dob_month;
  unsigned1 cnsmr_dob_day;
  string20 fname;
  string28 lname;
  unsigned6 lnpid;
  string20 mname;
  string2 st;
  string25 v_city_name;
  string9 cnsmr_ssn;
  string1 gender;
  string5 sname_normsuffix;
  string5 sname;
  unsigned1 fname_len;
  unsigned1 lname_len;
  unsigned1 mname_len;
  unsigned1 cnsmr_ssn_len;
  unsigned2 cnsmr_dob_year_weight100;
  unsigned2 cnsmr_dob_month_weight100;
  unsigned2 cnsmr_dob_day_weight100;
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
  integer2 st_weight100;
  integer2 v_city_name_weight100;
  integer2 cnsmr_ssn_weight100;
  integer2 cnsmr_ssn_e1_weight100;
  integer2 gender_weight100;
  integer2 sname_weight100;
  integer2 sname_normsuffix_weight100;
	unsigned8 __internal_fpos__;
 END;
 
 cnsmr_dob_Build :=  DATASET([ ],cnsmr_dob_layout);
 cnsmr_dob_key := INDEX(cnsmr_dob_Build,
   {cnsmr_dob_year,
   cnsmr_dob_month,
   cnsmr_dob_day,
   fname,
   lname,
   lnpid,
   mname,
   st,
   v_city_name,
   cnsmr_ssn,
   gender,
   sname_normsuffix,
   sname,
   fname_len,
   lname_len,
   mname_len,
   cnsmr_ssn_len,
   cnsmr_dob_year_weight100,
   cnsmr_dob_month_weight100,
   cnsmr_dob_day_weight100,
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
   st_weight100,
   v_city_name_weight100,
   cnsmr_ssn_weight100,
   cnsmr_ssn_e1_weight100,
   gender_weight100,
   sname_weight100,
   sname_normsuffix_weight100},{cnsmr_dob_Build},
	 prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::cnsmr::dob'); 
  
	BUILDindex(cnsmr_dob_Key);
 
 return 'Successful';
 end;
