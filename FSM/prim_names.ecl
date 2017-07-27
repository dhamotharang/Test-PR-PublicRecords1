import header;


h0 := distribute(table(header.File_Headers(prim_name<>''),{prim_name,did}),hash(prim_name));

h := dedup( sort( h0, prim_name,did, local ), prim_name,did,local );

h1 := record
  h.prim_name;
	unsigned4 cnt := count(group);
  end;
	
t1 := table(h,h1,prim_name,local);


export prim_names := t1 : persist('temp::dab::prim_names');

