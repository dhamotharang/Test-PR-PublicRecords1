import ingenix_natlprof, doxie;

file_in := ingenix_natlprof.Basefile_Provider_Did_keybuild;
											 
dist_providerid_base := distribute(file_in, hash(providerid));
sort_providerid_base := sort(dist_providerid_base, except did, did_score, local);
dedup_providerid_base := dedup(sort_providerid_base, except did, did_score, local);

export key_provider_id := index(dedup_providerid_base, 
                                {unsigned6 l_providerid := (unsigned6)providerid},
						  {dedup_providerid_base},
				            '~thor_data400::key::ing_provider_id_' + doxie.Version_SuperKey);