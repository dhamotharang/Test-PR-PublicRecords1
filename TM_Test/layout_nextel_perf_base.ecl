import Business_Header_SS;

export layout_nextel_perf_base := record
unsigned4 seq;
unsigned6 group_id := 0;
unsigned6 bdid := 0;
unsigned2 bdid_score := 0;
layout_nextel_perf_in;
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
// clean phones
string10  phone10;
// Best Business info
Business_Header_SS.Layout_Best_Append;
end;