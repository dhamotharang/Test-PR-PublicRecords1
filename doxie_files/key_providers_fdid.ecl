import ut,ingenix_natlprof, autokey, doxie;

//start providers autokeys
prov_auto_skip_set := ['S'];

f_prov := ingenix_natlprof.Basefile_Provider_Did;

xl_prov := RECORD
	f_prov;
	unsigned6 fdid;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('PROV'))| ut.bit_set(0,0);
END;

xl_prov xpand(f_prov le,integer prov_cntr) :=  TRANSFORM 
	SELF.fdid := prov_cntr + autokey.did_adder('PROV'); 
	SELF := le; 
END;
DS_prov := PROJECT(f_prov,xpand(LEFT,COUNTER));

DS_prov_slim_rec := record
	unsigned6 fdid;
	unsigned6 providerid;
end;

DS_prov_slim_rec slim_it(DS_prov l) := transform
     self.providerid := (unsigned6)l.providerid;
	self := l;
end;

DS_prov_slim := project(DS_prov, slim_it(left));

export key_providers_fdid := index(DS_prov_slim,{fdid},{providerid},
                                   '~thor_data400::key::ingenix_providers_fdids_' + doxie.Version_SuperKey);