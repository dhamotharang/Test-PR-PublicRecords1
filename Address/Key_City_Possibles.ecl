import header, data_services;
h := header.File_Headers;
r := record
  h.city_name;
	h.zip;
  end;
	
t := table(h(city_name<>'',(unsigned)zip<>0),r);

rt := record
  t.city_name;
	t.zip;
	unsigned4 cnt := count(group);
  end;	
	
t1 := table(t,rt,city_name,zip)(cnt>100);	

cp := record
  string30 city1;
	string30 city2;
  end;
	
cp tp(t1 le,t1 ri) := transform
  self.city1 := le.city_name;
	self.city2 := ri.city_name;
  end;

j := join(t1,t1,left.zip=right.zip,tp(left,right),atmost(100));

sj := dedup(sort(j,city1,city2),city1,city2);
	
export Key_City_Possibles := index(sj,{sj},{},data_services.data_location.prefix() + 'thor_data400::key::city1.city2');