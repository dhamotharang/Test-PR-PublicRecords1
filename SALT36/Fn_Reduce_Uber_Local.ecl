EXPORT Fn_Reduce_Uber_Local(DATASET(layout_uber_plus) f) := FUNCTION
  // The file need NOT be distributed at this point; it will still reduce the record count ...
  RETURN DEDUP( SORT(f,uid,word,field,SALT_Partition,dt_first_usable,dt_last_usable,LOCAL),uid,word,field,SALT_Partition,dt_first_usable,dt_last_usable,LOCAL );
  END;
