import standard, ut, doxie, census_data, marriage_divorce_v2; 

d_srch := distribute(marriage_divorce_v2.file_mar_div_search,hash(record_id));
d_main := distribute(marriage_divorce_v2.file_mar_div_base,hash(record_id));

r00 := record
 d_srch;
 string2  state_origin;
 string35 county_party1;
 string35 county_party2;
 string35 county_marriage;
 string35 county_divorce;
 string8  party1_dob;
 string8  party2_dob;
end;

r00 t_get_filing_st(d_srch le, d_main ri) := transform
 self                 := le;
 self.state_origin    := ri.state_origin;
 self.county_party1   := ri.party1_county;
 self.county_party2   := ri.party2_county;
 self.county_marriage := ri.marriage_county;
 self.county_divorce  := ri.divorce_county;
 self.party1_dob      := ri.party1_dob;
 self.party2_dob      := ri.party2_dob;
end;

j1 := join(d_srch,d_main,
           left.record_id=right.record_id,
		   t_get_filing_st(left,right),
		   local
		  );

r0 := record
 recordof(d_srch);
 string35 county2;
 string8  party_dob;
end;

r0 t_norm(j1 le, integer c) := transform
 self.st        := choose(c,le.state_origin,   le.state_origin,  le.st,           le.st);
 self.county2   := stringlib.stringtouppercase(choose(c,le.county_marriage,le.county_divorce,le.county_party1,le.county_party2));
 self.party_dob := if(le.which_party='P1',le.party1_dob,if(le.which_party='P2',le.party2_dob,''));
 self           := le;
end;

p_norm0 := normalize(j1,4,t_norm(left,counter));
p_sort  := sort(p_norm0,record_id,nameasis,which_party,-county2);

r0 x1(r0 le, r0 ri) := transform
 self.county2 := if(ut.nneq(le.county2,ri.county2),le.county2,ri.county2);
 self         := le;
end;

p_rold := rollup(p_sort,left.record_id=right.record_id and left.nameasis=right.nameasis and ut.nneq(left.county2,right.county2),x1(left,right));

r2 := record
 marriage_divorce_v2.layout_mar_div_search;
 string8 party_dob;
end;

r2 t_get_zip(r0 le, census_data.Key_CountySt_Zip ri) := transform
 self.zip := if(le.zip<>'',le.zip,ri.zip5);
 self     := le;
end;

p_norm := join(p_rold,census_data.Key_CountySt_Zip,
               left.st=right.state_code and left.county2=right.county_name,
			   t_get_zip(left,right), left outer, lookup
			  );

r1 := record
	p_norm.did;
	p_norm.record_id;
	p_norm.party_type;
	p_norm.which_party;
	unsigned4 lookups;
	standard.addr addr;
	standard.name name;
	unsigned1 zero := 0;
	string1   blank:='';
	p_norm.party_dob;
end;

r1 t1(p_norm le) := transform
	party_bits := (unsigned4) ut.bit_set(1, doxie.lookup_bit( le.which_party ));

	self.did             := le.did;
	self.record_id       := le.record_id;
	self.party_type      := le.party_type;
	self.which_party     := le.which_party;
	self.lookups         := party_bits;
	self.addr.zip5       := le.zip;
	self.addr            := le;
	self.name            := le;
	self.name.name_score := '';
	self.party_dob       := le.party_dob;
	self.addr            := [];
end;

p1 := dedup(project(p_norm,t1(left)),record,all,local);

export file_SearchAutokey := p1;