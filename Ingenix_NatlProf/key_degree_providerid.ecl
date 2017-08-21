import ingenix_natlprof, Doxie;


file_in := ingenix_natlprof.Basefile_ProviderDegree;

id_base := dedup(file_in,all);

export key_degree_providerid := index(id_base, 
                                {unsigned6 l_providerid := (unsigned6)providerid},{id_base},
				            '~thor_data400::key::ingenix_degree_providerid_' + Doxie.Version_SuperKey);


