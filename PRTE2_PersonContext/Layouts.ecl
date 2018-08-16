Import PersonContext;

EXPORT Layouts := module

export In_layout := record
String20 FIRST_NAME;
String20 MIDDLE;
String20 LAST_NAME;
String50 Unparsed_Addr;
String10 HOUSE; 
String20 STREET_NAME;
String25 CITY;
String2 STATE;
String5 ZIPCODE;
String8 DATE_OF_BIRTH;
String9 SSN;
String10 Alert1;
String20 Alert2;
string CS_UniqueID;
String4 CS_Timestamp_year;
String2 CS_Timestamp_month;
String2 CS_Timestamp_day;
String2 CS_Timestamp_Hour24;
String2 CS_Timestamp_minute;
String2 CS_Timestamp_second;
String2 CS_StatementID;
String2 CS_Statement_Type;
String2 CS_DataGroup;
String250 CS_Content;
String10 cust_name;
String10 bug_num;
End;

Export In_Layout_Work2:= record
In_Layout;
UNSIGNED8 rec_seq;
end;


Export In_Layout_Work3:= record
In_Layout_Work2;
  string Lexid;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string2 ace_fips_st;
  string3 fipscounty;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
End;


Export Layout_deltakey_personcontext := record
PersonContext.layouts.Layout_deltakey_personcontext;
End;


End;
