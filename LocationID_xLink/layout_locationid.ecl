﻿import SALT37, LocationID_iLink;

export Layout_LocationID := record
  unsigned6 locid;
  string2 source;
  unsigned8 source_record_id;
  unsigned6 rid;
  unsigned8 aid;
  string8 dateseenfirst;
  string8 dateseenlast;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string2 dbpc;
  string2 rec_type;
  string4 err_stat;
  unsigned8 cntprimname;
  string28 prim_name_normalized;
  string4 predir_derived;
  string28 prim_name_derived;
  string4 addr_suffix_derived;
  string10 prim_range_derived;
  unsigned6 primnameinzipcnt;
  set of string numbers;
  string8 sec_range_derived;
end;