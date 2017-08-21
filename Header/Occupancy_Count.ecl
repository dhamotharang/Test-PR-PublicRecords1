export Occupancy_Count(
	dataset(header.Layout_Header) h
	) :=
FUNCTION

hslim := record
  h.prim_range;
  h.prim_name;
  h.zip;
  h.sec_range;
  h.did;
  end;

hslim slimit(h l) := transform
	self := l;
end;

hs := project(h, slimit(left));

dhs := distribute(hs,hash(prim_range,prim_name,zip,sec_range));

ds := dedup( sort(dhs,prim_range,prim_name,zip,sec_range,did,local),
                     prim_range,prim_name,zip,sec_range,did,local);

acnt := record
  ds.prim_range;
  ds.prim_name;
  ds.zip;
  ds.sec_range;
  integer4 cnt := count(group);
  end;

a_numbers := table(ds,acnt,ds.prim_range,ds.prim_name,ds.zip,ds.sec_range,local);

return a_numbers ;

END;