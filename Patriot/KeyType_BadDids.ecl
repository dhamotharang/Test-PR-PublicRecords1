export KeyType_BadDids := record
  unsigned6 did;
  unsigned4 other_count;
  unsigned4 first_seen;
  unsigned2 rel_count;
  unsigned8 dummy := 0;
  end;