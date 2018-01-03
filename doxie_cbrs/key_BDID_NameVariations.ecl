import doxie, business_header,ut, data_services;

bf := business_header.File_Business_Header_Best;
rel := table(business_header.File_Business_Relatives(name or name_Address or name_phone),	
						 {bdid1, bdid2});

rec := record
	unsigned6 bdid;
	unsigned1 seq;
	unsigned6 bdid2;
end;	

temprec := record
	rec;
	qstring120 name;
end;

string cleanname(string n, unsigned1 pos) := 
	if(stringlib.stringfilterout(ut.word(n, pos),'X#1234567890') = '', '', ut.word(n, pos));

temprec addname(rel l, bf r) := transform
	self.bdid := l.bdid1;
	self.seq := 255;
	self.bdid2 := l.bdid2;
	self.name := trim(
							 cleanname(r.company_name, 1) + ' ' + cleanname(r.company_name, 2) + ' ' + cleanname(r.company_name, 3) + ' ' + 
							 cleanname(r.company_name, 4) + ' ' + cleanname(r.company_name, 5) + ' ' + cleanname(r.company_name, 6) + ' ' +
							 cleanname(r.company_name, 7) + ' ' + cleanname(r.company_name, 8) + ' ' + cleanname(r.company_name, 9), left, right);
end;

j := join(rel, bf, left.bdid2 = right.bdid, addname(left, right), hash);
s := dedup(group(sort(distribute(j, hash(bdid)), bdid, name, local), bdid, local), name);

temprec iter(temprec l, temprec r) := transform
	self.seq := if(l.seq < 255, l.seq + 1, r.seq);
	self := r;
end;

i := iterate(s, iter(left, right));

ut.MAC_Slim_Back(i,rec,islim)

export key_BDID_NameVariations := index(islim,
{bdid, seq},
{bdid2},
data_services.data_location.prefix() + 'thor_data400::key::cbrs.bdid_NameVariations_' + doxie.Version_SuperKey);