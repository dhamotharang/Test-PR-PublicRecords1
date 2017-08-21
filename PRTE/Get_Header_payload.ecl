import prte_csv,ut,NID,Doxie,address;

export Get_Header_payload := function

	ds1:=PRTE_CSV.Header.dthor_data400__key__header__data;

	ds2:=join(ds1,PRTE_CSV.Header.dthor_data400__key__header__fname_small
		,left.did=right.did
		and left.st=right.st
		and left.zip=(string)right.zip
		and left.prim_name=right.prim_name
		and left.dob=right.dob
		,left outer
		,keep(1)
		);
	ds3:=join(ds2,PRTE_CSV.Header.dthor_data400__key__header__relatives
		,left.did=right.person1
		,left outer
		,keep(1)
		);

	ds:=join(ds3,PRTE_CSV.Header.dthor_data400__key__header__st_city_fname_lname
		,left.did=right.did
		and left.fname=(qstring)right.fname
		and left.lname=(qstring)right.lname
		and left.dob=right.dob
		and left.st=right.st
		,keep(1)
		,left outer
		);

	prte_csv.ge_header_base.layout_payload proj_recs(ds l) := transform
		self.zip := '59981';
		self.ssn4 := ((string)l.ssn)[6..9];
		self.ssn5 := ((string)l.ssn)[1..5];
		self.s1 := ((string)l.ssn)[1..1];
		self.s2 := ((string)l.ssn)[2..2];
		self.s3 := ((string)l.ssn)[3..3];
		self.s4 := ((string)l.ssn)[4..4];
		self.s5 := ((string)l.ssn)[5..5];
		self.s6 := ((string)l.ssn)[6..6];
		self.s7 := ((string)l.ssn)[7..7];
		self.s8 := ((string)l.ssn)[8..8];
		self.s9 := ((string)l.ssn)[9..9];
		self.dph_lname := metaphonelib.DMetaPhone1(l.lname);
		self.minit := l.mname[1];
		self.addr_suffix := l.suffix;
		self.city_code := if(l.city_code=0,doxie.Make_CityCode(l.city_name),l.city_code);
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		self.yob := (integer)l.dob[1..4];
		self.l4 := l.lname[1..4];
		self.f3 := l.fname[1..3];
		self := l;
		self := [];
	end;

	before_itr := project( ds,proj_recs(left));

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := transform
		self := r;
	end;

	retds1 := iterate(before_itr,itr_hdr(left,right));

	prte_csv.ge_header_base.layout_payload get_lookup_dids(retds1 l) := transform
		lookups := 	  doxie.lookup_setter(2,			'SEX') |
							doxie.lookup_setter(3, 		'CRIM') |
							doxie.lookup_setter(4, 			'CCW') |
							doxie.lookup_setter(3, 			'VEH') |
							doxie.lookup_setter(4, 			'DL') |
							doxie.lookup_setter(3, 		'REL') |
							doxie.lookup_setter(3, 		'FIRE') |
							doxie.lookup_setter(3, 		'FAA') |
							doxie.lookup_setter(3, 		'VESS') |
							doxie.lookup_setter(3, 		'PROF') |
							doxie.lookup_setter(3, 		'BUS') | 
							doxie.lookup_setter(3, 		'PROP') | 
							doxie.lookup_setter(3, 		'BK') |
							doxie.lookup_setter(3, 		'PAW') | 
							doxie.lookup_setter(3, 		'BC') | 
							doxie.lookup_setter(3, 	'PROP_ASSES') | 
							doxie.lookup_setter(3, 	'PROP_DEEDS') | 
							doxie.lookup_setter(3, 	'PROV') | 
							doxie.lookup_setter(3, 	'SANC') | ut.bit_set(0,0);
		self.lookup_did := if (l.lookup_did=0, lookups, l.lookup_did);
		self.lookups     := if (l.lookups=0, lookups, l.lookups);
		self := l;
	end;

	retds := project(retds1,get_lookup_dids(left));

	return retds;
	
end;