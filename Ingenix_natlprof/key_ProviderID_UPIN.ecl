import ingenix_natlprof, Doxie, data_services;


file_in := ingenix_natlprof.Basefile_ProviderUPIN(trim(upin,left,right)<>'');

dist_id_base := distribute(dedup(file_in,all), hash(UPIN));
sort_id_base := sort(dist_id_base, UPIN, local);

export key_ProviderID_UPIN := index(sort_id_base, 
                                {string6 l_UPIN 				:= (string6)UPIN;
                                 unsigned6 l_providerid := (unsigned6)providerid},{sort_id_base},
				            data_services.data_location.prefix() + 'thor_data400::key::ingenix_ProviderID_UPIN_' + Doxie.Version_SuperKey);