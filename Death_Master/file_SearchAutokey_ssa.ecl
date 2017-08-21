import header, death_master,standard, ut, doxie, address, codes; 

fdeath := distribute(Death_Master.File_DeathMaster_Building_ssa, hash(state_death_id));
fsupp  := distribute(header.file_death_master_supplemental_ssa, hash(state_death_id));

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
	self.addr.st					:=	IF(l.state <> '', l.state, ut.stFips2stAbbrev(l.st_country_code));
	self.addr.zip5				:=	IF(TRIM(l.zip_lastres) != '', l.zip_lastres, l.zip_lastpayment);
	self.addr.fips_state	:=	l.st_country_code;
	self.addr.fips_county	:=	l.fipscounty;
	self.addr							:=	[];
	self.dob							:=	l.dob8;
	self.did							:=	(unsigned6)L.did;
	self.src							:=	l.src;
	self.glb_flag					:=	l.glb_flag;
	self									:=	l;
end;

base := project(fdeath, tformat(left));

//create some additional addresses using supp file
rec taddl(fdeath l, fsupp r) := transform
	self.addr.cbsa				:=	r.msa;
	self.addr.st					:=	MAP(codes.valid_st(r.state) => r.state,
																codes.valid_st(r.SOURCE_STATE) => r.SOURCE_STATE,
																'');
	self.addr.fips_state	:=	IF(TRIM(r.fips_state)<>'',
															r.fips_state,
															IF(TRIM(l.st_country_code)<>'',
																l.st_country_code,
																codes.st2FipsCode(self.addr.st)
															)
														);
	self.addr.fips_county	:=	IF(r.fips_county<>'',r.fips_county,l.fipscounty);
	self.addr							:=	r;
	self.dob							:=	l.dob8;
	self.did							:=	(unsigned6)L.did;
	self									:=	l;
end;

addl := join(fdeath(state_death_id <> ''), fsupp,
					   left.state_death_id = right.state_death_id,
						 taddl(left, right),
						 keep(1),
						 local);

export file_SearchAutokey_ssa := 
//throw out the record with the less complete duplicate address
	dedup(sort(base + addl, state_death_id, addr.zip5, addr.st, -addr.prim_range, -addr.prim_name, -addr.v_city_name, local),
			  state_death_id, addr.zip5, addr.st, local);


 


