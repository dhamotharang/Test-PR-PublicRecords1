
import header, death_master,standard, ut, doxie, address; 

fdeath := distribute(header.File_Did_Death_MasterV2, hash(state_death_id));
fsupp  := distribute(header.file_death_master_supplemental, hash(state_death_id));

//project base file into layout
rec := record
	unsigned6 did;
	fdeath.ssn;
	string8 dob;
	standard.Addr addr;
	fdeath.fname;
	fdeath.mname;
	fdeath.lname;
	fdeath.state_death_id;
	unsigned1 zero := 0;
	string1  blank:='';
	string2 src := '';
  string1 glb_flag := '';
end;

rec tformat(fdeath l) := transform
	self.addr.st := if(l.state <> '', l.state, l.st_country_code);
	self.addr.zip5 := if(trim(l.zip_lastres) != '', l.zip_lastres, l.zip_lastpayment);
	self.addr := [];
	self.dob  := l.dob8;
	self.did  := (unsigned6)L.did;
	self := l;
end;

base := project(fdeath, tformat(left));

//create some additional addresses using supp file
rec taddl(fdeath l, fsupp r) := transform
	self.addr.cbsa := r.msa;
	self.addr.st   := map(ut.valid_st(r.state) => r.state,
												ut.valid_st(r.SOURCE_STATE) => r.SOURCE_STATE,
												'');
	self.addr := r;
	self.dob  := l.dob8;
	self.did  := (unsigned6)L.did;
	self := l;
end;

addl := join(fdeath(state_death_id <> ''), fsupp,
					   left.state_death_id = right.state_death_id,
						 taddl(left, right),
						 keep(1),
						 local);

export file_SearchAutokey := 
//throw out the record with the less complete duplicate address
	dedup(sort(base + addl, state_death_id, addr.zip5, addr.st, -addr.prim_range, -addr.prim_name, -addr.v_city_name, local),
			  state_death_id, addr.zip5, addr.st, local);


 


