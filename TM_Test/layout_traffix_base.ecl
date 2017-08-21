export layout_traffix_base := record
unsigned4 seq;
unsigned6 group_id := 0;
unsigned6 bdid := 0;
unsigned2 bdid_score := 0;
unsigned6 did := 0;
unsigned2 score := 0;
Layout_Traffix_Test_In;
// business clean address
string10        prim_range;
string2         predir;
string28        prim_name;
string4         addr_suffix;
string2         postdir;
string10        unit_desig;
string8         sec_range;
string25        p_city_name;
string25        v_city_name;
string2         st;
string5         zip;
string4         zip4;
string4         cart;
string1         cr_sort_sz;
string4         lot;
string1         lot_order;
string2         dbpc;
string1         chk_digit;
string2         rec_type;
string2         fips_state;
string3         fips_county;
string10        geo_lat;
string11        geo_long;
string4         msa;
string7         geo_blk;
string1         geo_match;
string4         err_stat;
// clean phone
string10 phone10;
// clean DOB
string8 clean_dob;
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