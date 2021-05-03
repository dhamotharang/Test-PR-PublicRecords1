import standard, ut, doxie,ln_propertyv2; 

export file_search_autokey(boolean isFast) := function

//filter excludes care-of's from the autokeys

dParty := LN_PropertyV2_Fast.CleanSearch(isFast, isfast)(source_code[1]!='C');

rec := record
	dparty.phone_number;
	dParty.cname;
	dParty.ln_fares_id;
	dParty.source_code;
	dParty.did;
	dParty.bdid;
	dParty.app_SSN; 
	dParty.app_tax_id; 
	standard.Addr addr;
	standard.name name;
	unsigned1 zero := 0;
end;

rec tra(dParty l) := transform
	self.addr.st := l.st;
	self.addr.addr_suffix := l.suffix ; 
	self.addr.zip5 := l.zip ;
	self.addr.fips_state := l.county[1..2] ;
	self.addr.fips_county := l.county[3..5];
	self.addr.addr_rec_type := l.rec_type;  
	self.addr.cbsa := l.msa;
	self.name.name_score := '' ;  
	self.name := l;
	self.addr := l;
	self.cname := if(trim(l.cname) in ln_propertyv2.furniture_words or trim(l.nameasis) in ln_propertyv2.furniture_words,'',l.cname);
	self := l ; 
end;

d2 := distribute(project(dParty, tra(left)), hash(ln_fares_id));

dwr := record
	string1		fid_type;
	unsigned4	lookups;
	
	string10 phone;
	string10 bphone;
	d2.zero;
	d2.ln_fares_id ;
	d2.did;
	d2.bdid;
	d2.cname;
	d2.app_SSN; 
	d2.app_tax_id; 
	standard.Addr company_addr;
	standard.Addr person_addr;
	standard.Name person_name;
end;

dwr mdw(d2 L) := transform
	ft								:= LN_PropertyV2.fn_fid_type(L.ln_fares_id);
	pt								:= L.source_code[1];
	self.fid_type			:= ft;
	self.lookups			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt )));
	
	isPerson					:= (L.cname='');
	noAddr						:= row([],standard.Addr);
	noName						:= row([],standard.Name);
	
	self.DID          := if(isPerson, L.DID,					0);
	self.person_addr	:= if(isPerson, L.addr,					noAddr);
	self.person_name	:= if(isPerson, L.name,					noName);
	self.phone				:= if(isPerson, L.phone_number,	'');
	self.app_SSN			:= if(isPerson, L.app_SSN,			'');
	
	self.BDID         := if(isPerson, 0,							L.BDID);
	self.cname        := if(isPerson, '',							L.cname);
	self.company_addr := if(isPerson, noAddr,					L.addr);
	self.bphone       := if(isPerson, '',							L.phone_number);
	self.app_tax_id   := if(isPerson, '',							L.app_tax_id);
	
	self := L;
end;

b := project(d2, mdw(left));

return dedup(sort(b, record, local), record, local);
end;