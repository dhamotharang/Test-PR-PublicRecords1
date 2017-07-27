import header;

h := person_names_only;

h1 := record
  h.fname;
	unsigned4 cnt := sum(group,h.cnt);
  end;
	
t1 := table(h,h1,fname);


export First_Names := t1 : persist('temp::dab::first_names');