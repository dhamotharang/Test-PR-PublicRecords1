import ingenix_natlprof, standard, ut, doxie; 

dSanctions := ingenix_natlprof.Basefile_Sanctions;

Autokey_rec := record
	dSanctions.SANC_ID;
	dSanctions.FILETYP;
	dSanctions.SANC_TIN;
	dSanctions.SANC_DOB;
	standard.Addr addr;
	standard.name name;
	unsigned6 did     := 0;
	// Provider Screening Batch Phase2 project, added sanc_busnme and revised zero length
	dSanctions.SANC_BUSNME;
	unsigned6 zero    := 0;
	string1   blank   := '';
	unsigned6 lookups := ut.bit_set(0,doxie.lookup_bit('SANC'))| ut.bit_set(0,0);
end;

Autokey_rec TrfAutoKey(dSanctions l) := transform
	// Provider Screening Batch Phase2 enhancements project:
	//   - Added temp boolean and made person names assignments conditional on it.
	//   - Added sanc_busnme to output and made it conditional as well.
  boolean is_company := if(l.sanc_busnme<>'',true,false);
	
	// People/business common address fields
	self.addr.prim_range    := l.ProvCo_Address_Clean_prim_range;
	self.addr.predir        := l.ProvCo_Address_Clean_predir;
	self.addr.prim_name     := l.ProvCo_Address_Clean_prim_name;
	self.addr.addr_suffix   := l.ProvCo_Address_Clean_addr_suffix;
	self.addr.postdir       := l.ProvCo_Address_Clean_postdir;
	self.addr.unit_desig    := l.ProvCo_Address_Clean_unit_desig;
	self.addr.sec_range     := l.ProvCo_Address_Clean_sec_range;
	self.addr.v_city_name   := l.ProvCo_Address_Clean_v_city_name;
	self.addr.st            := if(trim(l.ProvCo_Address_Clean_st) <> '',
	                                   l.ProvCo_Address_Clean_st, l.sanc_state);
	self.addr.zip5          := l.ProvCo_Address_Clean_zip;
	self.addr.zip4          := l.ProvCo_Address_Clean_zip4;
	self.addr.addr_rec_type := l.ProvCo_Address_Clean_record_type;
	self.addr.fips_state    := l.ProvCo_Address_Clean_ace_fips_st;
	self.addr.fips_county   := l.ProvCo_Address_Clean_fipscounty;	
	
	// people fields
	self.name.title         := if(~is_company,l.Prov_Clean_title,'');
	self.name.fname         := if(~is_company,l.Prov_Clean_fname,'');
	self.name.mname         := if(~is_company,l.Prov_Clean_mname,'');
	self.name.lname         := if(~is_company,l.Prov_Clean_lname,'');
	self.name.name_suffix   := if(~is_company,l.Prov_Clean_name_suffix,'');
	self.name.name_score    := if(~is_company,l.Prov_Clean_cleaning_score,'');
	self.did                := if(~is_company,(unsigned6) l.did,0);

  // Business fields
	self.SANC_BUSNME           := if(is_company,l.SANC_BUSNME,'');
	
	// Common fields
	self := l;
	self := [];
end;

ds_autokey := project(dSanctions, TrfAutoKey(left));

export file_SearchAutokey_Sanctions := ds_autokey;