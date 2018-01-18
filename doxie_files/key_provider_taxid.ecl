import ingenix_natlprof, doxie, data_services;

file_in := ingenix_natlprof.Basefile_Provider_Did(TaxID<>'');

slim_rec := record
	unsigned6	ProviderID;
	string10	TaxID;
end;

slim_rec slim_it(file_in l) := transform
	self.ProviderID := (unsigned6)l.ProviderID;
	self := l;
end;

file_slim := project(file_in,slim_it(left));
file_slim_srt := sort(file_slim, record);
file_slim_dep := dedup(file_slim_srt, record);

export key_provider_taxid :=  index(file_slim_dep,
                                    {l_taxid := TaxID},
                                    {ProviderID},
                                    data_services.data_location.prefix() + 'thor_data400::key::ingenix_provider_taxid_' + Doxie.Version_SuperKey);