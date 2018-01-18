import ingenix_natlprof, Doxie, data_services;

file_in := ingenix_natlprof.Basefile_Provider_Did;
provider_did_base := file_in((unsigned6)did<>0);

slim_rec := record
     unsigned6 did;
	unsigned6 providerid;
end;

slim_rec slim_it(provider_did_base l) := transform
	self.did := (unsigned6)l.did;
	self.providerid := (unsigned6)l.providerid;
end;

provider_did_slim := project(provider_did_base, slim_it(left));

dist_did_base := distribute(provider_did_slim, hash(did, providerid));
sort_did_base := sort(dist_did_base, did, providerid, local);
dedup_did_base := dedup(sort_did_base, did, providerid, local);

export key_provider_did := index(dedup_did_base, 
                                 {unsigned6 l_did := did},
                                 {providerid},
                                 data_services.data_location.prefix() + 'thor_data400::key::ing_provider_did_' + Doxie.Version_SuperKey);