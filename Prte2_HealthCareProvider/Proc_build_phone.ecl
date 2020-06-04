import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_phone(String pversion) := FUNCTION

phone_layout:=RECORD
  string10 phone;
  unsigned6 lnpid;
  string20 fname_preferredname;
  string20 fname;
  string28 lname;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  string20 mname;
  string5 sname_normsuffix;
  string5 sname;
  string25 v_city_name;
  string2 st;
  string9 ssn;
  unsigned1 fname_len;
  unsigned1 lname_len;
  unsigned1 mname_len;
  unsigned1 ssn_len;
  integer2 phone_weight100;
  integer2 phone_cleanphone_weight100;
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
  integer2 v_city_name_weight100;
  integer2 st_weight100;
  integer2 ssn_weight100;
  integer2 ssn_e1_weight100;
  unsigned8 __internal_fpos__;
 END;

phone_Build :=  DATASET([ ],phone_layout);
 phone_key := INDEX(phone_Build,
{phone,
 lnpid,
 fname_preferredname,
 fname,
 lname,
 dob_year,
 dob_month,
 dob_day,
 mname,
 sname_normsuffix,
 sname,
 v_city_name,
 st,
 ssn,
 fname_len,
 lname_len,
 mname_len,
 ssn_len,
 phone_weight100,
 phone_cleanphone_weight100,
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
   sname_normsuffix_weight100,
   v_city_name_weight100,
   st_weight100,
   ssn_weight100,
   ssn_e1_weight100},{phone_Build},
	 prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::phone'); 
  
	BUILDindex(phone_Key);
 
 return 'Successful';
 end;