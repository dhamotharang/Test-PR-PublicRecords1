export layout_BBB := record
unsigned1 level := 0;
unsigned6 bdid;
string7  bbb_id;
string100 company_name;
//string100 address;
string12 country;
string14 phone;
string8  phone_type;
string8  report_date;
string255 http_link;
string100 member_title := '';
string8  member_since_date := '';
// clean address
string10 prim_range;
string2  predir;
string28 prim_name;
string4  addr_suffix;
string2  postdir;
string10 unit_desig;
string8  sec_range;
//string25 p_city_name;
string25 v_city_name;
string2  st;
string5  zip;
string4  zip4;
string4  cart;
string1  cr_sort_sz;
string4  lot;
string1  lot_order;
string2  dbpc;
string1  chk_digit;
string2  rec_type;
string2  fips_state;
string3  fips_county;
string10 geo_lat;//
string11 geo_long;
string4  msa;
string7  geo_blk;
string1  geo_match;
string4  err_stat;
// clean pphone
string10 phone10;
/* ******** place holder */
string1 TypeOfBusiness := '';
end;