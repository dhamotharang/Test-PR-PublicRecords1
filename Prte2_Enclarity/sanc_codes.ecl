Export sanc_codes:=RECORD
  string10 sanc_code;
  string100 sanc_desc;
  string2 src;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string1 record_type;
  unsigned8 source_rid;
 END;
