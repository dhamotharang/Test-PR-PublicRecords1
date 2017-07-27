import ingenix_natlprof, Doxie;

file_in := ingenix_natlprof.Basefile_ProviderNPI(trim(npi,left,right)<>'');

dist_id_base := distribute(file_in, hash(filetyp,providerid));
sort_id_base := dedup(sort(dist_id_base, npi, local), all,local);

export key_providerID_NPI := index(sort_id_base, 
                                {string10 l_NPI	:= (string10)NPI},{sort_id_base},
				            '~thor_data400::key::ingenix_ProviderID_NPI_' + Doxie.Version_SuperKey);