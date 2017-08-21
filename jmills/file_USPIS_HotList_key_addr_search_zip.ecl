//Output(USPIS_HotList.key_addr_search_zip);

#CONSTANT('DataLocationCC', 'NONAME');  
import USPIS_HotList;
key_in := USPIS_HotList.key_addr_search_zip;

layout_out := RECORD
  string5 zip;
  string10 prim_range;
  string28 prim_name;
  string4 addr_suffix;
  string2 predir;
  string2 postdir;
  string8 sec_range;
  string8 dt_first_reported;
  string8 dt_last_reported;
  string address;
  string suffix;
  string city;
  string state;
  string zip_code;
  string comments;
  string10 unit_desig;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
 END;

layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_USPIS_HotList_key_addr_search_zip := project(key_in,makelayout(left));