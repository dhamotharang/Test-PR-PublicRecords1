export Layout_DID := record
 string3   orig_name_prefix;
 string15  orig_first_name;
 string15  orig_middle_name;
 string25  orig_last_name;
 string3   orig_name_suffix;
 string40  orig_addr_street_blob;
 string10  orig_house_number;
 string2   orig_predir;
 string28  orig_street_name;
 string4   orig_street_suffix;
 string2   orig_postdir;
 string8   orig_apt_no;
 string27  orig_city;
 string2   orig_st;
 string5   orig_zip;
 string4   orig_zip4;
 string9   ssn;
 string10  phone;
 string8   orig_dob_dd_appended;
 string1   orig_gender;
 string6   effective_dt;
 
 unsigned6 boca_id:=0;
 string1   infutor_or_mktg_ind;
 
 string1   which_ssn:='';
 
 string5   title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string3   name_score;
 
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
 
 unsigned6 did:=0;
end;