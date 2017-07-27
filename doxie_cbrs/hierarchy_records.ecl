import business_header,doxie;
doxie.mac_header_field_Declare()
d := doxie_cbrs.dca_hierarchy_prs;
i := doxie_cbrs.infousa_hierarchy_prs;

inf := if(count(d) > count(i), d, i);

outrec := record
	inf.level;
	doxie_cbrs.Layout_BH_Best_String;
end;

besrec := record
	inf.name;
	outrec;
end;

//get best info
doxie_cbrs.mac_best_records(inf, bes, besrec, true)
s := sort(bes, level);

//patch name
outrec form(s l) := transform
	self.company_name := if(l.company_name = '', l.name, l.company_name);
	self.level := 0;	//blank out and reseed below
	self := l;
end;

namepatch := project(s, form(left));

//use a level indicator
outrec iter(outrec l, outrec r) := transform
	self.level := l.level + 1;
	self := r;
end;

export hierarchy_records := iterate(namepatch, iter(left, right));