
import standard, ut, doxie,address, fcra, Bankruptcyv2;

export BKSearchForPayloadAutokey(boolean isFCRA = false) := function

	file_bankruptcy_search := dataset(ut.foreign_prod_boca + 'thor_data400::base::bankruptcy::search',
	BankruptcyV2.layout_bankruptcy_search ,flat)(court_code+case_number not in bankruptcyv2.Suppress.court_code_caseno);
	
	
			/* add integer did field */
		d := table(file_bankruptcy_search, {file_bankruptcy_search, idid := (integer8)did});

		/* suppress WA cellphones */
		ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

		/* removed extra field */
		d1 := project(o, transform(BankruptcyV2.layout_bankruptcy_search, self := left));

	// d1 :=  BankruptcyV2.file_bankruptcy_search_keybuild;

	rec := record
		d1.name_type;
		unsigned4 party_bits := 0;
		d1.cname;
		d1.tmsid;
		string9 ssn;
		string9 tax_id;
		standard.Addr addr;
		standard.name name;
		unsigned1 zero := 0;
		unsigned6 intdid;
		unsigned6 intbdid;
	end;

	//Capture Both SSN, App_SSN

	d1 all_ssn(d1 le,integer C):=transform
		self.ssn    := choose(C,le.ssn,le.app_ssn);
		self.tax_id := choose(C,le.tax_id,le.app_tax_id);
		self :=le;
	end;

	Both_SSN :=normalize(d1,2, all_ssn(left,counter));

	rec tra(d1 l) := transform
		self.party_bits := (unsigned4) ut.bit_set(0,doxie.lookup_bit( 'PARTY_'+l.name_type ));
		self.addr.st := l.st;
		self.addr.addr_rec_type := l.rec_type;
		self.addr.zip5 := l.zip ; 
		self.addr.fips_state     := l.county[1..2] ; 
		self.addr.fips_county    :=  l.county[3..5] ; 
		self.addr.cbsa   := l.msa ; 
		self.addr := l;
		self.addr := [];
		self.name := l;
		self.intdid := (unsigned6) l.did; 
		self.intbdid := (unsigned6) l.bdid ; 
		self.ssn := if((unsigned6)L.ssn <> 0,  L.ssn, L.app_ssn);
		self.tax_id := if((unsigned6)L.tax_id <> 0,  L.tax_id, L.app_tax_id);
		self := l;
	end;

	d2 := dedup(sort(distribute(project(Both_SSN, tra(left)), hash(tmsid)),record,local),record,local);

	c := d2(cname <> '') ;
	p := d2(cname = '') ;

	dwr := record
		d2.name_type;
		d2.party_bits;
		d2.zero;
		d2.tmsid;
		d2.intDID;
		d2.intBDID;
		d2.cname;
		d2.ssn;
		d2.tax_id;
		standard.Addr company_addr;
		standard.Addr person_addr;
		standard.Name person_name;
	end;

	dwr mdw(p l, c r) := transform
		self.intDID := l.intDID;
		self.intBDID := r.intBDID;
		self.cname := r.cname;
		self.tax_id := r.tax_id;
		self.company_addr := r.addr;
		self.person_addr := l.addr;
		self.person_name := l.name;
		self.ssn := l.ssn;
		self := if(l.tmsid = '', r, l);
	end;


	b := join(p,c,left.tmsid = right.tmsid and 
			  left.name_type = right.name_type, 
			  mdw(left, right), 
			  full outer, local);


	return dedup(sort(b, record, local), record, local);
end;
