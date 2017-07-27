import header,ut;

h := person_names_only;

h1 := record
  h.lname;
	unsigned4 cnt := sum(group,h.cnt);
  end;
	
t1 := table(h,h1,lname);


export Last_Names := t1 : persist('temp::dab::last_names');
