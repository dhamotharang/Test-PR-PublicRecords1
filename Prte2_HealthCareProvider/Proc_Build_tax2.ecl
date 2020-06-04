import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_tax2(String pversion) := FUNCTION
tax2_layout:=RECORD
  unsigned4 tax_id;
  unsigned6 lnpid;
  string20 fname_preferredname;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname_normsuffix;
  string5 sname;
  string1 gender;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  string25 c_lic_nbr;
  string2 lic_state;
  unsigned1 fname_len;
  unsigned1 mname_len;
  unsigned1 lname_len;
  unsigned1 c_lic_nbr_len;
  integer2 tax_id_weight100;
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
  integer2 sname_weight100;
  integer2 sname_normsuffix_weight100;
  integer2 gender_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  integer2 c_lic_nbr_weight100;
  integer2 c_lic_nbr_e1_weight100;
  integer2 lic_state_weight100;
  unsigned8 __internal_fpos__;
 END;
 tax2_Build :=  DATASET([ ],tax2_layout);
 tax2_key := INDEX(tax2_Build,
  {  tax_id,
   lnpid,
   fname_preferredname,
   fname,
   mname,
   lname,
   sname_normsuffix,
   sname,
   gender,
   dob_year,
   dob_month,
   dob_day,
   c_lic_nbr,
  lic_state,
   fname_len,
   mname_len,
   lname_len,
   c_lic_nbr_len,
   tax_id_weight100,
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
   sname_weight100,
   sname_normsuffix_weight100,
   gender_weight100,
   dob_year_weight100,
   dob_month_weight100,
   dob_day_weight100,
   c_lic_nbr_weight100,
   c_lic_nbr_e1_weight100,
   lic_state_weight100},{tax2_Build},
	 prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::tax'); 
  
	BUILDindex(tax2_Key);
 
 return 'Successful';
 end;
