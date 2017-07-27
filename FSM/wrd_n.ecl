export wrd_n(unsigned i) := function

//f := dataset([{'A'},{'AND'},{'ANDREW'},{'B'},{'BOB'},{'DAVID'},{'DAVE'},{'MATTHEW'},{'KELLY'},{'ROB'}],{STRING20 FNAME});

f0 := last_names(LabelValid(lname)=0);
f := table( f0, { string fname := stringlib.stringfilter(lname,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ') } );

str_r into_r(f le) := transform
  self.str := le.fname[1..i];
	self.rem := le.fname[i+1..];
  end;
		
wrds := project(f(length(trim(fname))>=i),into_r(left));

str_r_tot := record
  wrds.str;
	string rem := min(group,wrds.rem);
	unsigned4 cnt := count(group);
  end;

t := table(wrds,str_r_tot,str);

str_r into(str_r_tot le) := transform
  self := le;
  end;
	
	return project(t,into(left));

  end;
	