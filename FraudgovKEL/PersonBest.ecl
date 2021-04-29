IMPORT FraudgovKEL, FraudGovPlatform,doxie,Suppress;
/*
RECORD
  unsigned8 record_id;
  unsigned6 did;
  unsigned6 fdn_file_info_id;
  string10 best_phone;
  string9 best_ssn;
  string9 max_ssn;
  string5 best_title;
  string20 best_fname;
  string20 best_mname;
  string20 best_lname;
  string5 best_name_suffix;
  string120 best_addr1;
  string30 best_city;
  string2 best_state;
  string5 best_zip;
  string4 best_zip4;
  string6 best_addr_date;
  string8 best_dob;
  string8 best_dod;
  string3 verify_best_phone;
  string3 verify_best_ssn;
  string3 verify_best_address;
  string3 verify_best_name;
  string3 verify_best_dob;
  string3 score_any_ssn;
  string3 score_any_addr;
  string3 any_addr_date;
  string3 score_any_dob;
  string3 score_any_phn;
  string3 score_any_fzzy;
  string errorcode;
 END;
*/

PersonBestPrep := FraudGovPlatform.files().base.bestinfo.built;
EXPORT PersonBest := PersonBestPrep;