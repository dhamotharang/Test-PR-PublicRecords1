import header,ut;

h := header.file_headers;

hr := record
  h.did;
  unsigned8 dfs := if ( h.dt_vendor_first_reported=0 or h.dt_first_seen > 0 and h.dt_first_seen<h.dt_vendor_first_reported,
                    h.dt_first_seen,h.dt_vendor_first_reported);
  end;

ht := table(h,hr);

hm := record
  ht.did;
  unsigned8 df := min(group,ht.dfs);
  end;

export First_Seens := table(ht,hm,ht.did,local) : persist('Patriot_First_Seens');