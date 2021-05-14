import dx_common;

export KeyType_BadNames := record
  string20 fname;
  string20 mname;
  string20 lname;
  unsigned4 cnt;
  //DF-28226 - fields defined for delta build
	dx_common.layout_metadata;
end;