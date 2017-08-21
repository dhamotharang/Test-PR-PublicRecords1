export Layout_BayArea2000_Executive_Base := record
unsigned6 did := 0;
unsigned2 score := 0;
string ExecutiveName;
string ExecutiveTitle;
Layout_BayArea2000_Test_Norm;
// business clean address
string10        bus_prim_range;
string2         bus_predir;
string28        bus_prim_name;
string4         bus_addr_suffix;
string2         bus_postdir;
string10        bus_unit_desig;
string8         bus_sec_range;
string25        bus_p_city_name;
string25        bus_v_city_name;
string2         bus_st;
string5         bus_zip;
string4         bus_zip4;
string4         bus_cart;
string1         bus_cr_sort_sz;
string4         bus_lot;
string1         bus_lot_order;
string2         bus_dbpc;
string1         bus_chk_digit;
string2         bus_rec_type;
string2         bus_fips_state;
string3         bus_fips_county;
string10        bus_geo_lat;
string11        bus_geo_long;
string4         bus_msa;
string7         bus_geo_blk;
string1         bus_geo_match;
string4         bus_err_stat;
// clean phone
string10  phone10;
// principal clean name
string5  title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
string3  name_score;
// Best Business info
  string10  bus_best_phone := '';
  string9   bus_best_fein := '';
  string120 bus_best_CompanyName := '';
  string120 bus_best_addr1 := '';
  string30  bus_best_city := '';
  string2	  bus_best_state := '';
  string5	  bus_best_zip :='';
  string4	  bus_best_zip4 := '';
// Best Contact Info
  string10 	best_phone := '';
  string5		best_title := '';
  string20	best_fname := '';
  string20	best_mname := '';
  string20	best_lname := '';
  string5		best_name_suffix := '';
  string120 	best_addr1 := '';
  string30	best_city := '';
  string2		best_state := '';
  string5		best_zip :='';
  string4		best_zip4 := '';
  unsigned3	best_addr_date := 0;
  string8  	best_dob := '';
  string8  	best_dod := '';
end;