import Header, mdr;

EXPORT as_header(dataset(layouts.base) pFile = dataset([],layouts.base), boolean pForHeaderBuild=false, boolean pFastHeader= false) := function
	
    withUID := cd_seed.As_source(,true);
    
    Header.Layout_New_Records tr2(withUID l) := transform
		self.src:=MDR.sourceTools.src_Consumer_Disclosure_feed;
		self.rid:=0;
		self.did:=0;
		self.dt_first_seen            :=(unsigned) (l.dt_first_seen / 100);
		self.dt_last_seen             :=(unsigned) ( l.dt_last_seen / 100);
		self.dt_vendor_first_reported :=(unsigned) ( l.dt_vendor_first_reported / 100);
		self.dt_vendor_last_reported  :=(unsigned) ( l.dt_vendor_last_reported / 100);
		self.dt_nonglb_last_seen      := 0;
		self.rec_type                 := '1';
		self.vendor_id                := if(l.orig_vendor_id<>''
                                            ,l.orig_vendor_id
                                            ,(string)hash(
                                                trim(l.fname)+','+
                                                trim(l.mname)+','+
                                                trim(l.lname)+','+
                                                trim(l.orig_ssn)+','+
                                                trim(l.orig_dob)
                                                )
                                          );
		self.ssn       := l.orig_ssn;
		SELF.dob       := (integer)l.orig_dob;
		self.phone     := l.orig_phone;
		self.city_name := l.v_city_name;
		self.suffix    := l.addr_suffix;
		self.county    := l.fips_county;
		self := l;
	end;

	ah := project(withUID, tr2(left));

	return ah;
    
end;