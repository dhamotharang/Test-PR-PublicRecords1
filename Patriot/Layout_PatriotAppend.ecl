export Layout_PatriotAppend := record
  boolean   known := false;
  boolean   name_match := false;
  unsigned4 number_with_same_name:=0; 
  unsigned4 first_seen:=0;
  unsigned2 relative_count:=0;
  end;