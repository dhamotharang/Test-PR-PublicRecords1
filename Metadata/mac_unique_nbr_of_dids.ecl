export mac_unique_nbr_of_dids(infile,outval) := macro

 r1 := record
  unsigned6 did;
 end;
 
 r1 t1(infile le) := transform
  self := le;
 end;
 
 p1 := project(infile,t1(left));
 f1 := p1(did>0);
 
 f1_dist := distribute(f1,hash(did));
 f1_sort := sort(f1_dist,did,local);
 f1_dupd := dedup(f1_sort,did,local);
 
 outval := count(f1_dupd);

endmacro;