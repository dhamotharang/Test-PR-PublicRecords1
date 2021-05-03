import dx_common;

export KeyType_BadDids := record
  unsigned6 did;
  unsigned4 other_count;
  unsigned4 first_seen;
  unsigned2 rel_count;
  unsigned8 dummy := 0;
  //DF-28226 - fields defined for delta build
	dx_common.layout_metadata;
  end;
  