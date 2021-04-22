Export encrypted:=RECORD
  unsigned8 group_rid;
  unsigned2 key_version;
  string30 key_group;
  string key_encrypted;
  string query_encrypted;
  unsigned4 global_sid;
  unsigned8 record_sid;
  string report_options;
  unsigned8 __internal_fpos__;
 END;
