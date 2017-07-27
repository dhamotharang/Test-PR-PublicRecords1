import header;

h0 := distribute(table(header.File_Headers(city_name<>''),{city_name,did}),hash(city_name));

h := dedup( sort( h0, city_name,did,local ), city_name,did,local ); // bring counts into line with person counts

rt := record
  h.city_name;
	unsigned cnt := count(group);
  end;
	
ta := table(h,rt,city_name,few);	

export Cities := ta(cnt>100) : persist('temp::dab::cities');
