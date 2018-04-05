import standard, ut, doxie, codes; 

export file_SearchAutokey(
	dataset(LiensV2.Layout_liens_party) party_files = dataset([],LiensV2.Layout_liens_party),
	dataset(LiensV2.Layout_liens_main_module.layout_liens_main) main_files = dataset([],LiensV2.Layout_liens_main_module.layout_liens_main)
	) :=
FUNCTION


//***** PICK UP AN FILING STATE AS ADDITIONAL ADDRESS WHEN NOT ALREADY THERE
strec := record
	main_files.tmsid;
	string2 st;
end;

strec mftra(main_files l) := transform
	self.st := map(codes.valid_st(l.filing_jurisdiction) => l.filing_jurisdiction,
				   codes.valid_st(l.filing_state) => 		 l.filing_state,
				   '');
	self := l;
end;

mfst := dedup(sort(distribute(project(main_files, mftra(left))(st <> ''), hash(tmsid, st)), tmsid, -st, local), tmsid, local);


//***** GET THE PARTY FILE INTO A WORKABLE FORMAT
d1 :=  party_files;

rec := record
	d1.name_type;
	unsigned4 party_bits := 0;
	d1.cname;
	d1.tmsid;
	d1.rmsid;
	d1.ssn;
	d1.tax_id;
	standard.Addr addr;
	standard.name name;
	unsigned1 zero := 0;
	unsigned6 intdid;
	unsigned6 intbdid;
end;

rec tra(d1 l, string2 newst) := transform
	boolean addlrecord := newst <> ''; 	//this is for picking up the additional filing state record
	
	self.party_bits := (unsigned4) ut.bit_set(0,doxie.lookup_bit( 'PARTY_'+l.name_type[1..1] ));
	self.intdid := (unsigned6)l.did;
	self.intbdid := (unsigned6)l.bdid;
	self.addr.zip5 := 	if(~addlrecord, l.zip,	'');
	self.addr.st := 	if(~addlrecord,	l.st, 	newst);
	self.addr := 		if(~addlrecord,	l);
	self.addr := [];
	self.name := l;
	self := l;
end;

j := join(d1, mfst, 					//this is for picking up the additional filing state record
		  left.tmsid = right.tmsid and 
		  left.st <> right.st,
		  tra(left, right.st),
		  hash);
		  
d2 := distribute(project(d1, tra(left, '')) + j, hash(tmsid, rmsid));


//***** SPLIT INTO DEBTOR AND CREDITOR AND MAKE A DOUBLE-WIDE RECORD BY JOINING ON TMSID RMSID
p := d2(cname = '');
c := d2(cname <> '');

dwr := record
	d2.name_type;
	d2.party_bits;
	d2.zero;
	d2.tmsid;
	d2.rmsid;
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
			  left.rmsid = right.rmsid and 
			  left.name_type = right.name_type, 
			  mdw(left, right), 
			  full outer, local);

return dedup(sort(b, record, local), record, local);

END;