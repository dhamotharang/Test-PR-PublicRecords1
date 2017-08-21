IMPORT PRTE2_UCC, UCCV2, standard, ut, doxie;

EXPORT Files := MODULE

	//Input files
	EXPORT Main_in	:= DATASET(PRTE2_UCC.Constants.IN_PREFIX + 'main', PRTE2_UCC.Layouts.Main_in,
														CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
														
	EXPORT Party_in := DATASET(PRTE2_UCC.Constants.IN_PREFIX + 'party', PRTE2_UCC.Layouts.Party_in,
														CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
														
	//Base Files
	EXPORT Main_base_ext	:= DATASET(PRTE2_UCC.Constants.BASE_PREFIX + 'main', PRTE2_UCC.Layouts.Main_ext, THOR); //Contains DI fields at the end
	EXPORT Main_base 			:= PROJECT(Main_base_ext, PRTE2_UCC.Layouts.Main);
	
	EXPORT Party_base_ext	:= DATASET(PRTE2_UCC.Constants.BASE_PREFIX + 'party', PRTE2_UCC.Layouts.Party_ext, THOR); //Contains DI fields at the end
	EXPORT Party_base			:= PROJECT(Party_base_ext, PRTE2_UCC.Layouts.Party);
	
	//Autokey File
	rec := RECORD
		Party_base.party_type;
		unsigned4 party_bits := 0;
		Party_base.company_name;
		Party_base.tmsid;
		Party_base.rmsid;
		Party_base.ssn;
		Party_base.fein;
		Party_base.did;
		Party_base.bdid;
		standard.Addr addr;
		standard.name name;
		unsigned1 zero := 0;
	END;

	rec tra(Party_base l) := TRANSFORM
		self.party_bits := (unsigned4) ut.bit_set(0,doxie.lookup_bit( 'PARTY_'+l.party_type ));
		self.addr.st := l.st;
		self.addr := l;
		self.addr := [];
		self.name := l;
		self := l;
	END;

		d2 := project(Party_base, tra(left));

	//split into debtor and creditor and make a double-wide record by joining on tmsid rmsid
	p := sort(d2(company_name = ''),tmsid,rmsid);
	c := sort(d2(company_name <> ''),tmsid,rmsid);

	dwr := RECORD
		d2.party_type;
		d2.party_bits;
		d2.zero;
		d2.tmsid;
		d2.rmsid;
		d2.did;
		d2.bdid;
		d2.company_name;
		d2.ssn;
		d2.fein;
		standard.Addr company_addr;
		standard.Addr person_addr;
		standard.Name person_name;
	END;

	dwr mdw(p l, c r) := TRANSFORM
		self.DID := l.DID;
		self.BDID := r.BDID;
		self.company_name := r.company_name;
		self.company_addr := r.addr;
		self.person_addr := l.addr;
		self.person_name := l.name;
		self.ssn := l.ssn;
		self := if(l.tmsid = '', r, l);
	END;

	b := join(p,c,left.tmsid = right.tmsid and 
					left.rmsid = right.rmsid and
					left.party_type = right.party_type,
					mdw(left, right), 
					full outer);
					
	EXPORT SearchAutokey := b;
	
END;