export layout_property_ids := RECORD
  unsigned6	did;
  unsigned6	bdid := 0;
  string12 fid;
  integer3 address_seq_no := -1;
  boolean current;
  string2 source_code;
END;
