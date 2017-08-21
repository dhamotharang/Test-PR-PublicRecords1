export Fn_Reduce_Uber_Local(dataset(layout_uber_plus) f) := function
  // The file need NOT be distributed at this point; it will still reduce the record count ...
  return dedup( sort(f,uid,word,field,local),uid,word,field,local );
  end;
