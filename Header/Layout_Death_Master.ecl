export Layout_Death_Master := record
string8  filedate;
string1  rec_type;
string1  rec_type_orig;
string9  ssn;
string20 lname;
string4  name_suffix;
string15 fname;
string15 mname;
string1  VorP_code;
string8  dod8;
string8  dob8;
string2  st_country_code;
string5  zip_lastres;
string5  zip_lastpayment;
string2	 state;
string3	 fipscounty;
string2  crlf;
string1  state_death_flag := '';
string3	 death_rec_src := '';
//CCPA-17 
UNSIGNED4			global_sid := 0;
UNSIGNED8			record_sid := 0;      
end;