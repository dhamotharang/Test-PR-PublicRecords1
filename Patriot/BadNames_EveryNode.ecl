bn2 := record
  bad_names;
  unsigned2 dist_place;
  end;

bn2 dup(bad_names le,unsigned2 cnt) := transform
  self := le;
  self.dist_place := cnt;
  end;

b_ndist := distribute(normalize(bad_names,thorlib.nodes(),dup(left,counter)),dist_place);

shared BadNames_EveryNode := b_ndist;