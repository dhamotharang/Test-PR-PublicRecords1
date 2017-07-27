import ingenix_natlprof, doxie, Data_Services;

file_in := Ingenix_NatlProf.Basefile_ProviderSanctions;
											 
dist_providerid_base := distribute(file_in, hash(providerid));
sort_providerid_base := sort(dist_providerid_base,record,local);
dedup_providerid_base := dedup(sort_providerid_base,record,local);

export key_ProviderSanctions_id :=index(dedup_providerid_base, 
                                {unsigned6 l_providerid := (unsigned6)providerid},
						  {dedup_providerid_base},'~thor_data400::key::ing_ProviderSanctions_id_' + doxie.Version_SuperKey);
								

								
