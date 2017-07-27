export Layout_MLPL_Combined_Output := record
  string20  acctno;
  unsigned2 penalt :=0;
  string2   data_source := ''; // set to ML or PL within Medlic_PL_Combined_Batch_Service
  string5   title;
  string20  fname;
  string20  mname;
  string20  lname;
  string5   name_suffix;
  // Individual street addr fields are only on PL output
  string10  prim_range;
  string2   predir;      
  string28  prim_name;
  string4   suffix;
  string2   postdir;
  string10  unit_desig;
  string8   sec_range;
  string25  p_city_name;
  string25  v_city_name;
  string2   st;
  string5   zip;
  string4   zip4;
  string30  did;   // allow room for 2
  string9   ssn;   // not in ML data (needs appended); best_ssn in PL
  string120 taxid; // up to 12 from ML separated by '; '.  1 from PL
  string20  license_number;  // Lic*_Number from ML; license_number in PL
  string2   license_state;   // Lic*_State from ML; source_st in PL
  string8   issue_date;      // Lic*_Eff_Date from ML; issue_dt in PL
  string8   expiration_date; // Lic*_Exp_Date from ML; expiration_date in PL
  string1   expired_flag;    // set like done in PL_Batch_Service
  string8   last_renewal_date;      // only on PL output
  string8   first_known_issue_date; // set in Medlic_PL_Combined_Batch_Service rollup
  string60  profession_or_board;    // only on PL output
  string60  license_type;           // only on PL output
end;
