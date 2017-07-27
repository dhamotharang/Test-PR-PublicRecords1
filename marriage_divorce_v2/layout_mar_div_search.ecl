export layout_mar_div_search := record
  
  unsigned6 did;
	  
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  
  unsigned6 record_id;
	string5   vendor;

  string1   party_type;
  string3   which_party;
  string1   name_sequence;  //this could be useful when re-cleaning conjunctive name data
  
  string5   title;
  string20  fname;
  string20  mname;
  string20  lname;
  string5   name_suffix;
  string1   nameasis_name_format;
  string100 nameasis;
  
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
  
	string8 dob;
  string3 age;
  string2 birth_state;
  string30 race;
  string35 party_county;
  string20 previous_marital_status;
  string20 how_marriage_ended;
  string2 times_married;
  string8 last_marriage_end_dt;

 unsigned8 persistent_record_id;
end; 