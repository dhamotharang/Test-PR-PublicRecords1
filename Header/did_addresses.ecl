import mdr;
h := Header.File_Headers(header.Blocked_data());

hslim := record
  h.prim_range;
  h.prim_name;
  h.predir;
  h.suffix;
  h.zip;
  h.sec_range;
  h.did;
  unsigned8 first_seen := get_header_first_seen(h);
  unsigned8 last_seen := get_header_last_seen(h);
  end;

hs := table(h(prim_name!=''),hslim);

ds := distribute(hs,hash(prim_range,prim_name,zip,predir));

gds := group(sort(ds,prim_range,prim_name,zip,predir,suffix,did,sec_range,local),prim_range,prim_name,zip,predir,local);

hslim  combine_time(hslim le, hslim ri) := transform
  self.first_seen := if ( ri.first_seen <> 0 and ri.first_seen < le.first_seen, ri.first_seen, le.first_seen );
  self.last_seen := if ( ri.last_seen <> 0 and ri.last_seen > le.last_seen, ri.last_seen, le.last_seen );
  self := le;
  end;

rup := rollup(gds,left.prim_range=right.prim_range and
                  left.prim_name=right.prim_name and
                  left.zip=right.zip and
                  left.predir=right.predir and
                  left.suffix=right.suffix and
                  left.did=right.did and
                  left.sec_range=right.sec_range,combine_time(left,right));

export did_addresses := rup : persist('DID_Addresses');