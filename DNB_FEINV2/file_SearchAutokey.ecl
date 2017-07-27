import standard, ut, doxie; 

dbusiness := DNB_FEINv2.File_DNB_Fein_base_main ;
rec := record
	
	dbusiness.clean_cname;
	dbusiness.tmsid;
	dbusiness.fein;
	unsigned6 intbdid;
	//standard.Addr addr;
	standard.Addr company_addr;
	unsigned1 zero := 0;
	string1 blank := '' ; 
end;

rec tra(dbusiness l) := transform
    self.company_addr.st := l.st;
	self.company_addr.zip5 := l.zip ; 
	self.company_addr.addr_rec_type := l.rec_type ;  
	self.company_addr.fips_state := l.county[1..2] ;
	self.company_addr.fips_county := l.county[3..5]; 
//	self.cbsa  := 
	self.company_addr := l;
	self.company_addr := [];
	self.intbdid := (unsigned6)l.bdid;
	self := l;
end;

d2 := distribute(project(dbusiness, tra(left)), hash(tmsid));
export file_SearchAutokey := d2;


