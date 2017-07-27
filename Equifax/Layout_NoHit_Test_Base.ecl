import Business_Header_SS;

export Layout_NoHit_Test_Base := record
unsigned4 seq;
unsigned6 bdid := 0;
unsigned2 bdid_score := 0;
string1   bdid_from_contact := 'N';
unsigned6 did := 0;
unsigned2 score := 0;
Layout_NoHit_Test_In;
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
// principal clean name
string5  title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
string3  name_score;
// business clean address
string10        prin_prim_range;
string2         prin_predir;
string28        prin_prim_name;
string4         prin_addr_suffix;
string2         prin_postdir;
string10        prin_unit_desig;
string8         prin_sec_range;
string25        prin_p_city_name;
string25        prin_v_city_name;
string2         prin_st;
string5         prin_zip;
string4         prin_zip4;
string4         prin_cart;
string1         prin_cr_sort_sz;
string4         prin_lot;
string1         prin_lot_order;
string2         prin_dbpc;
string1         prin_chk_digit;
string2         prin_rec_type;
string2         prin_fips_state;
string3         prin_fips_county;
string10        prin_geo_lat;
string11        prin_geo_long;
string4         prin_msa;
string7         prin_geo_blk;
string1         prin_geo_match;
string4         prin_err_stat;
// clean phones
string10  phone10;
// ssn, fein
string9   ssn;
string9   fein;
// Best Business info
Business_Header_SS.Layout_Best_Append;
end;