import ut;
c := AnnotatedCompanies_Only;

r1 := record
  c._type;
	unsigned cnt := sum(group,c.cnt);
	string1 master_type := 'C';
	end;
	
t := table(c,r1,_type,few);

tc := sum(t,cnt);

p := AnnotatedPeople_Only;



r2 := record
  p._type;
	unsigned cnt := sum(group,p.cnt);
	string1 master_type := 'P';
  end;

t1 := table(p,r2,_type,few);
t1c := sum(t1,cnt);

r3 := record
  string20 _type;
	unsigned NumberCompany;
	unsigned NumberPerson;
  end;

r3 jrec(t le,t1 ri) := transform
  self._type := IF(le._type='',ri._type,le._type);
	self.NumberCompany := le.cnt;
	self.NumberPerson := ri.cnt;
  end;

j := join(t,t1,left._type=right._type,jrec(left,right),full outer);

ut.MAC_Append_Weighted_Percentile(j,NumberCompany,PercentileCompany,o);
ut.MAC_Append_Weighted_Percentile(o,NumberPerson,PercentilePerson,o1);

export Token_Patterns := o1;