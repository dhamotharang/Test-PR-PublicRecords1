// based on code that used to be at the top of UCCV2.proc_autokeybuild

import standard, ut, doxie; 

dParty := File_UCC_Party_base;

rec := record
	dParty.party_type;
	unsigned4 party_bits := 0;
	dParty.company_name;
	dParty.tmsid;
	dParty.rmsid;
	dParty.ssn;
	dParty.fein;
	dParty.did;
	dParty.bdid;
	standard.Addr addr;
	standard.name name;
	unsigned1 zero := 0;
end;

rec tra(dParty l) := transform
	self.party_bits := (unsigned4) ut.bit_set(0,doxie.lookup_bit( 'PARTY_'+l.party_type ));
	self.addr.st := l.st;
	self.addr := l;
	self.addr := [];
	self.name := l;
	self := l;
end;

d2 := distribute(project(dParty, tra(left)), hash(tmsid,rmsid));

//split into debtor and creditor and make a double-wide record by joining on tmsid rmsid
p := d2(company_name = '');
c := d2(company_name <> '');

dwr := record
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
end;

dwr mdw(p l, c r) := transform
	self.DID := l.DID;
	self.BDID := r.BDID;
	self.company_name := r.company_name;
	self.company_addr := r.addr;
	self.person_addr := l.addr;
	self.person_name := l.name;
	self.ssn := l.ssn;
	self := if(l.tmsid = '', r, l);
end;

b := join(p,c,left.tmsid = right.tmsid and 
			  left.rmsid = right.rmsid and
				left.party_type = right.party_type,
				mdw(left, right), 
				full outer, local);

export file_SearchAutokey := b;
