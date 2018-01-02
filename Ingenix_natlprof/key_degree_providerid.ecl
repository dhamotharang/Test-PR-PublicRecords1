import ingenix_natlprof, Doxie, data_services;


file_in := ingenix_natlprof.File_in_Providerdegree;
//provider_did_base := ingenix_natlprof.Basefile_Provider_Did((unsigned8)did<>0);

dist_id_base := distribute(dedup(file_in,all), hash(providerid));
sort_id_base := sort(dist_id_base, providerid, local);
//dedup_id_base := dedup(sort_id_base, providerid, local);

export key_degree_providerid := index(sort_id_base, 
                                {unsigned6 l_providerid := (unsigned6)providerid},{sort_id_base},
				            data_services.data_location.prefix() + 'thor_data400::key::ingenix_degree_providerid_' + Doxie.Version_SuperKey);


