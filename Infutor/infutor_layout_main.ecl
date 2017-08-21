export infutor_layout_main := module

export temp_rec := record
 
 infutor.File_Infutor ;
 unsigned6 boca_id:=0;
 string8   orig_dob_dd_appended;
 
 string55  prev1_addr_street_blob;
 string27  prev1_city;
 string2   prev1_st;
 string5   prev1_zip;
 
 string55  prev2_addr_street_blob;
 string27  prev2_city;
 string2   prev2_st;
 string5   prev2_zip;
 
 string55  prev3_addr_street_blob;
 string27  prev3_city;
 string2   prev3_st;
 string5   prev3_zip;
 
 string55  prev4_addr_street_blob;
 string27  prev4_city;
 string2   prev4_st;
 string5   prev4_zip;

 string55  prev5_addr_street_blob;
 string27  prev5_city;
 string2   prev5_st;
 string5   prev5_zip; 
end;
export r_norm_ssn := record 

 string3  orig_name_prefix;
 string15 orig_first_name;
 string15 orig_middle_name;
 string25 orig_last_name;
 string3  orig_name_suffix;
 string9  ssn ; 
 string1  dwelling_type;
 string3  fips_county;
 string10 phone;
 string8  orig_filing_dt;
 string8  last_activity_dt;
 string8  orig_dob_dd_appended ; 
 string1  orig_gender;
 string32 alias1;
 string32 alias2;
 string32 alias3;
 
 string40 orig_addr_street_blob;
 string10 orig_house_number;
 string2  orig_predir;
 string28 orig_street_name;
 string4  orig_street_suffix;
 string2  orig_postdir;
 string8  orig_apt_no;
 string27 orig_city;
 string2  orig_st;
 string5  orig_zip;
 string4  orig_zip4;
 string4  orig_crrt;
 
 string6  effective_dt;
 string1  ncoa_cd;
 string6  ncoa_dt;
 string10 unique_id;
 string1  record_type;
 unsigned6 boca_id:=0;
 string1   which_ssn:='';

  string88  prev1_addr;
  string55  prev1_addr_street_blob;
 string27   prev1_city;
 string2    prev1_st;
 string5    prev1_zip;
 string6    prev1_addr_effective_dt;
 
 string88  prev2_addr;
 string55  prev2_addr_street_blob;
 string27  prev2_city;
 string2   prev2_st;
 string5   prev2_zip;
 string6   prev2_addr_effective_dt;
  
 string88  prev3_addr;
 string55  prev3_addr_street_blob;
 string27  prev3_city;
 string2   prev3_st;
 string5   prev3_zip;
 string6   prev3_addr_effective_dt;
 
 string88  prev4_addr;
 string55  prev4_addr_street_blob;
 string27  prev4_city;
 string2   prev4_st;
 string5   prev4_zip;
 string6   prev4_addr_effective_dt;
 
 string88  prev5_addr;
 string55  prev5_addr_street_blob;
 string27  prev5_city;
 string2   prev5_st;
 string5   prev5_zip;
 string6   prev5_addr_effective_dt;
  
end;

export r_norm_name := record 
 
 r_norm_ssn ; 
 string61 name ;
 string2   name_type := '';
 string55 addr_street_blob :='';
 string27 city := '';
 string2  st := '';
 string5  zip := '';
 string4  zip4 := '';
 string2   addr_type := '';
 string1   flag := ''; 

end;

export r_norm_name_clean := record 

  string61 name ;
  string2 name_type ; 
  string73 clean_name ; 
 
end;
export r_norm_clean_addr := record 

 string55 addr_street_blob :='';
 string27 city := '';
 string2  st := '';
 string5  zip := '';
 string4  zip4 := '';
 string2   addr_type := '';
 string182 clean_addr := ''; 
 unsigned8 RawAID:=0;
end; 


export r_final := record 

 r_norm_name ; 
 string73 clean_name ; 
end;

export layout_base_tracker := record 

 string3  orig_name_prefix;
 string15 orig_first_name;
 string15 orig_middle_name;
 string25 orig_last_name;
 string3  orig_name_suffix;
 string9  ssn ; 
 string10 phone;
 string8  orig_filing_dt;
 string8  last_activity_dt;
 string8  orig_dob_dd_appended ; 
 string1  orig_gender;
 string32 alias1;
 string32 alias2;
 string32 alias3;
 
 string40 orig_addr_street_blob;
 string10 orig_house_number;
 string2  orig_predir;
 string28 orig_street_name;
 string4  orig_street_suffix;
 string2  orig_postdir;
 string8  orig_apt_no;
 string27 orig_city;
 string2  orig_st;
 string5  orig_zip;
 string4  orig_zip4;
 string4  orig_crrt;
 string6  effective_dt;

  string88  prev1_addr;
  string6   prev1_addr_effective_dt;
  string88  prev2_addr;
  string6   prev2_addr_effective_dt;
  string88  prev3_addr;
  string6   prev3_addr_effective_dt;
  string88  prev4_addr;
  string6   prev4_addr_effective_dt;
  string88  prev5_addr;
  string6   prev5_addr_effective_dt;
 
 string5   title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string3   name_score;
 string2   name_type ; 
 string10  prim_range;
 string2   predir;
 string28  prim_name;
 string4   addr_suffix;
 string2   postdir;
 string10  unit_desig;
 string8   sec_range;
 string25  p_city_name;
 string25  v_city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string4   cart;
 string1   cr_sort_sz;
 string4   lot;
 string1   lot_order;
 string2   dbpc;
 string1   chk_digit;
 string2   rec_type;
 string5   county;
 string10  geo_lat;
 string11  geo_long;
 string4   msa;
 string7   geo_blk;
 string1   geo_match;
 string4   err_stat;
 string2   addr_type ; 
 
 string1  dwelling_type;
 string3  fips_county;
 string1   ncoa_cd;
 string6   ncoa_dt;
 string10  unique_id;
 string1   record_type;
 unsigned6 boca_id;
 string1   which_ssn;
 unsigned6 did:=0;
 string9   append_ssn := ''; 
 unsigned8 RawAID:=0;
end;

export rHdr := RECORD
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;
end;