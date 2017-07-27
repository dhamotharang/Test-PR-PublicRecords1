export Layout_UCC_Party_In := record
string50  ucc_key;
string2   ucc_vendor;
string2   ucc_state_origin;
string8   ucc_process_date;
//
string20  event_key;
//
string20  party_key;
//
string20  collateral_key;
//
string1   trans_type;
string8   trans_date;
//
string1   std_type;
string8	  type_cd;
string60  type_desc;
string8   role_cd;
string60  role_desc;
string350 name;
string1   std_name_type;
string10  fein;
string8   inc_date;
string9   ssn;
string8   dob;
string8   status_cd;
string60  status_desc;
string8   eff_date;
string8   exp_date;
//
string8   address1_type_cd;
string60  address1_type_desc;
string70  address1_line1;
string70  address1_line2;
string70  address1_line3;
string70  address1_line4;
string70  address1_line5;
string70  address1_line6;
string8   address1_eff_date;
//
string8   address2_type_cd;
string60  address2_type_desc;
string70  address2_line1;
string70  address2_line2;
string70  address2_line3;
string70  address2_line4;
string70  address2_line5;
string70  address2_line6;
string8   address2_eff_date;
//
string30  phone_number;
string8   phone_number_type_cd;
string60  phone_number_type_desc;
string30  email_address;
string30  web_address;
//
string10        address1_prim_range;
string2         address1_predir;
string28        address1_prim_name;
string4         address1_addr_suffix;
string2         address1_postdir;
string10        address1_unit_desig;
string8         address1_sec_range;
string25        address1_p_city_name;
string25        address1_v_city_name;
string2         address1_st;
string5         address1_zip;
string4         address1_zip4;
string4         address1_cart;
string1         address1_cr_sort_sz;
string4         address1_lot;
string1         address1_lot_order;
string2         address1_dbpc;
string1         address1_chk_digit;
string2         address1_rec_type;
string2         address1_fips_st;
string3         address1_fips_county;
string10        address1_geo_lat;
string11        address1_geo_long;
string4         address1_msa;
string7         address1_geo_blk;
string1         address1_geo_match;
string4         address1_err_stat;
//
string10        address2_prim_range;
string2         address2_predir;
string28        address2_prim_name;
string4         address2_addr_suffix;
string2         address2_postdir;
string10        address2_unit_desig;
string8         address2_sec_range;
string25        address2_p_city_name;
string25        address2_v_city_name;
string2         address2_st;
string5         address2_zip;
string4         address2_zip4;
string4         address2_cart;
string1         address2_cr_sort_sz;
string4         address2_lot;
string1         address2_lot_order;
string2         address2_dbpc;
string1         address2_chk_digit;
string2         address2_rec_type;
string2         address2_fips_st;
string3         address2_fips_county;
string10        address2_geo_lat;
string11        address2_geo_long;
string4         address2_msa;
string7         address2_geo_blk;
string1         address2_geo_match;
string4         address2_err_stat;
//
string5  pname1_title;
string20 pname1_fname;
string20 pname1_mname;
string20 pname1_lname;
string5  pname1_name_suffix;
string3  pname1_name_score;
//
string5  pname2_title;
string20 pname2_fname;
string20 pname2_mname;
string20 pname2_lname;
string5  pname2_name_suffix;
string3  pname2_name_score;
//
string5  pname3_title;
string20 pname3_fname;
string20 pname3_mname;
string20 pname3_lname;
string5  pname3_name_suffix;
string3  pname3_name_score;
//
string5  pname4_title;
string20 pname4_fname;
string20 pname4_mname;
string20 pname4_lname;
string5  pname4_name_suffix;
string3  pname4_name_score;
//
string5  pname5_title;
string20 pname5_fname;
string20 pname5_mname;
string20 pname5_lname;
string5  pname5_name_suffix;
string3  pname5_name_score;
end;