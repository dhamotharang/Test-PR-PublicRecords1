export Layout_Infutor_FixedLength := record
  string58 name;
  string40 current_address_complete;
  string54 street;
  string27 city;
  string2 state;
  string5 zip;
  string4 zip4;
  string4 crrt;
  string6 effective_date;
  string9 ssn_1;
  string2 ssn_1_seq_number;
  string9 ssn_2;
  string1 dwelling_type;
  string3 fips_county;
  string10 phone_number;
  string8 original_filing_date;
  string8 last_activity_date;
  string6 dob;
  string1 gender;
  string32 alias1;
  string32 alias2;
  string32 alias3;
  string54 prev1_street;
  string31 prev1_city;
  string2 prev1_state;
  string5 prev1_zip;
//  string38 prev1_csz;
  string6 prev1_address_effective_date;
  string54 prev2_street;
  string31 prev2_city;
  string2 prev2_state;
  string5 prev2_zip;
//  string38 prev2_csz;
  string6 prev2_address_effective_date;
  string54 prev3_street;
  string31 prev3_city;
  string2 prev3_state;
  string5 prev3_zip;
//  string38 prev3_csz;
  string6 prev3_address_effective_date;
  string54 prev4_street;
  string31 prev4_city;
  string2 prev4_state;
  string5 prev4_zip;
//  string38 prev4_csz;
  string6 prev4_address_effective_date;
  string54 prev5_street;
  string31 prev5_city;
  string2 prev5_state;
  string5 prev5_zip;
//  string38 prev5_csz;
  string6 prev5_address_effective_date;
  string1 ncoa;
  string6 ncoa_date;
  string1 filler;
  string10 unique_id;
end;

/*
name := record
  //string3  prefix;
  string15 first_;
  string15 middle;
  string25 last_;
  string3  suffix;
end;

street := record
  string10 house_number;
  string2 pre_dir;
  string28 street_name;
  string4 street_suffix;
  string2 post_dir;
  string8 apt_no;
end;

csz := record
  string27 city;
  string2 st;
  string5 zip;
  string4 zip4;
end;
*/
/*
export Layout_Infutor_FixedLength := record
  string58 name;
  string40 current_address_complete;
  string54 street;
  string38 csz;
  string4 crrt;
  string6 effective_date;
  string9 ssn_1;
  string2 ssn_1_seq_number;
  string9 ssn_2;
  string1 dwelling_type;
  string3 fips_county;
  string10 phone_number;
  string8 original_filing_date;
  string8 last_activity_date;
  string6 dob;
  string1 gender;
  string32 alias1;
  string32 alias2;
  string32 alias3;
  string54 prev1_street;
  string38 prev1_csz;
  string6 prev1_address_effective_date;
  string54 prev2_street;
  string38 prev2_csz;
  string6 prev2_address_effective_date;
  string54 prev3_street;
  string38 prev3_csz;
  string6 prev3_address_effective_date;
  string54 prev4_street;
  string38 prev4_csz;
  string6 prev4_address_effective_date;
  string54 prev5_street;
  string38 prev5_csz;
  string6 prev5_address_effective_date;
  string1 ncoa;
  string6 ncoa_date;
  string1 filler;
  string10 unique_id;
end;
*/