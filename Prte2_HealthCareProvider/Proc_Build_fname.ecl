import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_fname(String pversion) := FUNCTION
fname_layout:=RECORD
  string28 lname;
  string2 st;
  string1 gender;
  unsigned6 lnpid;
  string20 fname_preferredname;
  string20 fname;
  string5 sname_normsuffix;
  string5 sname;
  string20 mname;
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string25 v_city_name;
  string5 zip;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  string25 c_lic_nbr;
  string2 lic_state;
  string10 npi_number;
  unsigned4 billing_tax_id;
  unsigned1 lname_len;
  unsigned1 fname_len;
  unsigned1 mname_len;
  unsigned1 c_lic_nbr_len;
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
  integer2 st_weight100;
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
  integer2 gender_weight100;
  integer2 sname_weight100;
  integer2 sname_normsuffix_weight100;
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
  integer2 prim_range_weight100;
  integer2 prim_name_weight100;
  integer2 sec_range_weight100;
  integer2 v_city_name_weight100;
  integer2 zip_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  integer2 c_lic_nbr_weight100;
  integer2 c_lic_nbr_e1_weight100;
  integer2 lic_state_weight100;
  integer2 npi_number_weight100;
  integer2 billing_tax_id_weight100;
  unsigned8 __internal_fpos__;
 END;
 
 fname_Build :=  DATASET([ ],fname_layout);
 fname_key := INDEX(fname_Build,
  {  lname,
   st,
   gender,
   lnpid,
   fname_preferredname,
   fname,
   sname_normsuffix,
   sname,
   mname,
   prim_range,
   prim_name,
   sec_range,
   v_city_name,
   zip,
   dob_year,
   dob_month,
   dob_day,
   c_lic_nbr,
  lic_state,
   npi_number,
   billing_tax_id,
   lname_len,
   fname_len,
   mname_len,
   c_lic_nbr_len,
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
  st_weight100,
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
  gender_weight100,
   sname_weight100,
   sname_normsuffix_weight100,
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
   prim_range_weight100,
   prim_name_weight100,
   sec_range_weight100,
   v_city_name_weight100,
   zip_weight100,
   dob_year_weight100,
   dob_month_weight100,
   dob_day_weight100,
   c_lic_nbr_weight100,
   c_lic_nbr_e1_weight100,
   lic_state_weight100,
   npi_number_weight100,
  billing_tax_id_weight100},{fname_Build},
	prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::fname'); 
  
	BUILDindex(fname_Key);
 
 return 'Successful';
 end;
