rel := doxie.comp_names;

r := record
  string9 ssn9 := rel.ssn;
	unsigned6 did := rel.did;
	rel.ssn_unmasked;
  end;
  
t := table(rel(ssn[1..5]<>''),r);

per := doxie.ssn_persons();

r1 := record
  string9 ssn9;
	unsigned6 did;
	typeof(rel.ssn_unmasked) ssn_unmasked;
  end;
  
r1 maker1(per l) := transform
	self.ssn9 := l.ssn;
	self.did := l.did;
	self.ssn_unmasked := l.ssn;
end;

t1 := project(per(ssn[1..5]<>''),maker1(left));
									
export comp_ssns := t+t1;