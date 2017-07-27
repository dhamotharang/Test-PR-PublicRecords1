export layout_search_out := record
 unsigned3 dt_first_seen; //new
 unsigned3 dt_last_seen; //new
 unsigned3 dt_vendor_first_reported; //new
 unsigned3 dt_vendor_last_reported; //new
 string1   vendor_source_flag; //previously string5 -> new values 'F' for 'FAR_F', 'S' for 'FAR_S', 'O' for 'OKCTY', and 'D' for 'DAYTN'
 string12  ln_fares_id;
 string8   process_date;
 string2   source_code;
 string1   which_orig :='';      //remove default when build logic accounts for this field
 string1   conjunctive_name_seq; //new
 string5   title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string80  cname;
 string80  nameasis;
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
 string10  phone_number;
 string1	 flip_name := '';
 string1	 prop_addr_propagated_ind := '';
end;