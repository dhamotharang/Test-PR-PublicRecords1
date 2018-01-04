import ingenix_natlprof, Doxie, data_services;

file_in := ingenix_natlprof.Basefile_ProviderLicense;

slim_rec := record
	string2	LicenseState;	
	string12	LicenseNumber;
	unsigned6 ProviderID;
end;

slim_rec slim_it(file_in l) := transform
	self.providerID := (unsigned6)l.providerID;
	self := l;
end;

file_in_slim := project(file_in, slim_it(left));

file_in_dst := distribute(file_in_slim, hash(LicenseState, LicenseNumber, ProviderID));
file_in_srt := sort(file_in_dst, LicenseState, LicenseNumber, ProviderID, local);
file_in_dep := dedup(file_in_srt, LicenseState, LicenseNumber, ProviderID, local);

export key_provider_license := index(file_in_dep, 
                                     {LicenseState, LicenseNumber},
                                     {providerID},
                                     data_services.data_location.prefix() + 'thor_data400::key::ing_provider_license_' + Doxie.Version_SuperKey);