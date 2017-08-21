import header, standard;

d1 := Infutor.File_Infutor_keybuild;

rec := record
	d1.did;
	d1.ssn;
	d1.phone ;
	string8 dob;
	d1.name_type; 
	d1.addr_type ; 
	standard.Addr addr;
    standard.name name;
	d1.boca_id;
	unsigned1 zero := 0;
	string1  blank:='';
end;

rec tformat(d1 l) := transform
	self.addr.zip5 := l.zip;
	self.dob  := l.orig_dob_dd_appended;
	self.ssn := if((unsigned6)L.ssn <> 0,  L.ssn, L.append_ssn);
	self.addr.fips_state := l.county[1..2] ; 
	self.addr.fips_county := l.county[3..5]; 
	self.addr.cbsa := l.msa ; 
	self.addr.addr_rec_type :=l.rec_type;
	self.name := l;
	self.addr := l;
	self := l;
end;

export file_infutor_autokey := project(d1, tformat(left));