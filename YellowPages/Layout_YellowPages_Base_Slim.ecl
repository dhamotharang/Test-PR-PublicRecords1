EXPORT Layout_YellowPages_Base_Slim := RECORD
UNSIGNED6  bdid := 0;
STRING10  primary_key;
STRING125 business_name;
STRING100 orig_street;
STRING75  orig_city;
STRING2   orig_state;
STRING9   orig_zip;
STRING9   orig_latitude;
STRING10  orig_longitude;
STRING10  orig_phone10;
STRING10  phone10;
STRING140 heading_string;
STRING8   sic_code;
STRING1   toll_free_indicator;
STRING1   fax_indicator;
STRING6   pub_date;
STRING9   index_value;
STRING6   naics_code;
STRING50  web_address;
STRING35  email_address;
STRING1   employee_code;
STRING10  executive_title;
STRING33  executive_name;
STRING1   derog_legal_indicator;
STRING1   record_type;
STRING1   addr_suffix_flag;
STRING10  prim_range;
STRING2   predir;
STRING28  prim_name;
STRING4   suffix;
STRING2   postdir;
STRING10  unit_desig;
STRING8   sec_range;
STRING25  p_city_name;
STRING25  v_city_name;
STRING2   st;
STRING5   zip;
STRING4   zip4;
STRING4   cart;
STRING1   cr_sort_sz;
STRING4   lot;
STRING1   lot_order;
STRING2   dpbc;
STRING1   chk_digit;
STRING2   rec_type;
STRING2   ace_fips_st;
STRING3   county;
STRING10  geo_lat;
STRING11  geo_long;
STRING4   msa;
STRING7   geo_blk;
STRING1   geo_match;
STRING4   err_stat;
STRING1   bus_name_flag;
STRING25  aka_name;
STRING5   title;
STRING20  fname;
STRING20  mname;
STRING20  lname;
STRING5   name_suffix;
STRING3   name_score;
STRING5   exec_title;
STRING20  exec_fname;
STRING20  exec_mname;
STRING20  exec_lname;
STRING5   exec_name_suffix;
STRING3   exec_name_score;STRING25  nn_fix_city;
STRING2   nn_fix_state;
STRING5   nn_fix_zip;
STRING1   nn_fix_ace_flag;
STRING25  nn_fix_alt_city1;
STRING5   nn_fix_alt_zip1;
STRING25  nn_fix_alt_city2;
STRING5   nn_fix_alt_zip2;
STRING2   n_fix_state;
STRING1   address_override := '';  // 'N' if replaced from NPA clean address
                                   // 'X' if replaced from NPA/NXX clean address
                                   // 'G' if replaced from Gong clean address
STRING1   phone_override := '';    // 'G' if replaced from Gong phone
STRING4   phone_type := '';
STRING2   source := '';            // 'Y' if source from Yellow Pages
                                   // 'GG' or 'GB' if source from Gong Business Listings

END;