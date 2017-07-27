export Layout_Address_Clean_Components_Altered := record
// standard 182 bytes returned from cleaning
qstring10 prim_range := '';
string2   predir := '';
qstring28 prim_name := '';
qstring4  addr_suffix := '';
string2   postdir := '';
qstring10 unit_desig := '';
qstring8  sec_range := '';
qstring25 p_city_name := '';
qstring25 v_city_name := '';
string2   st := '';
qstring5  zip5 := '';
qstring4  zip4 := '';
qstring4  cart := '';
string1   cr_sort_sz := '';
qstring4  lot := '';
string1   lot_order := '';
string2   dbpc := '';
string1   chk_digit := '';
string2   rec_type := '';
qstring5  county := '';
qstring10 lat := '';
qstring11 long := '';
qstring4  msa := '';
qstring7  geo_blk := '';
string1   geo_match := '';
qstring4  err_stat := '';
// flag to indicate clean error type
unsigned1 clean_errors:= 0;
end;