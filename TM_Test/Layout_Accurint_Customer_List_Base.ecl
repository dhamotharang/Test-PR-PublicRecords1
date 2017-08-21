import Business_Header_SS;

export Layout_Accurint_Customer_List_Base := record
unsigned4 seq;
unsigned6 bdid := 0;
unsigned2 bdid_score := 0;
Layout_Accurint_Customer_List;
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
// fein
string9   fein;
// Best Business info
Business_Header_SS.Layout_Best_Append;
// Profile Risk Information
unsigned1 PRScore := 0;
unsigned1 busreg_flag := 0;
unsigned1 corp_flag := 0;
unsigned1 dnb_flag := 0;
unsigned1 irs5500_flag := 0;
unsigned1 st_flag := 0;
unsigned1 ucc_flag := 0;
unsigned1 yp_flag := 0;
unsigned1 tier1srcs := 0;
unsigned1 t1scr5 := 0;
unsigned1 currphn := 0;
unsigned1 currcorp := 0;
unsigned1 currbr := 0;
unsigned1 currdnb := 0;
unsigned1 currucc := 0;
unsigned1 curry := 0;
unsigned1 currt1cnt := 0;
unsigned1 currt1src4 := 0;
unsigned2 year_lj := 0;
unsigned1 lj := 0;
unsigned1 ustic := 0;
unsigned1 t1x := 0;
unsigned2 OFAC_cnt := 0;
unsigned2 cnt_B := 0;
end;