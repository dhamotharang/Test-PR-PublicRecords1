import ingenix_natlprof, standard, ut, doxie ; 

dProvider := ingenix_natlprof.Basefile_Provider_Did;

Autokey_rec := record
	dprovider.ProviderID;
	dprovider.AddressID;
	dprovider.FILETYP;
	dprovider.BirthDate;
	dprovider.PhoneNumber;
	unsigned6 did := 0;
	standard.Addr addr;
	standard.name name;
	unsigned1 zero  := 0;
	string1   blank := '';
	unsigned6 lookups := ut.bit_set(0,doxie.lookup_bit('PROV'))| ut.bit_set(0,0);
end;


Autokey_rec TrfAutoKey(dprovider l) := transform
    self.did                := (unsigned6) l.did;
	self.addr.prim_range    := l.prov_Clean_prim_range;
	self.addr.predir        := l.prov_Clean_predir;
	self.addr.prim_name     := l.prov_Clean_prim_name;
	self.addr.addr_suffix   := l.prov_Clean_addr_suffix;
	self.addr.postdir       := l.prov_Clean_postdir;
	self.addr.unit_desig    := l.prov_Clean_unit_desig;
	self.addr.sec_range     := l.prov_Clean_sec_range;
	self.addr.v_city_name   := l.prov_Clean_v_city_name;
	self.addr.st            := l.prov_Clean_st;
	self.addr.zip5          := l.prov_Clean_zip;
	self.addr.zip4          := l.prov_Clean_zip4;
	self.addr.addr_rec_type := l.prov_Clean_record_type;
	self.addr.fips_state    := l.prov_Clean_ace_fips_st;
	self.addr.fips_county   := l.prov_Clean_fipscounty;
	//self.addr.geo_lat;
	//self.addr.geo_long ;
	//self.addr.cbsa ;
	//self.addr.geo_blk ;
	//self.addr.geo_match ;
	//self.addr.err_stat;
	self.name.title         := l.Prov_Clean_title;
	self.name.fname         := l.Prov_Clean_fname;
	self.name.mname         := l.Prov_Clean_mname;
	self.name.lname         := l.Prov_Clean_lname;
	self.name.name_suffix   := l.Prov_Clean_name_suffix;
	self.name.name_score    := l.Prov_Clean_cleaning_score;	
	self                    := l;
	self                    := [];
end;

ds_autokey := project(dprovider, TrfAutoKey(left));

export file_SearchAutokey_Provider := ds_autokey;

