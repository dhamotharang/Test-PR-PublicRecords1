export File_CA_Santa_Clara_in := module
	export raw 		 := dataset(Cluster.Cluster_In + 'in::FBNv2::CA::Santa_Clara::Sprayed',Layout_File_CA_Santa_Clara_in.Sprayed,
                            CSV(HEADING(1),SEPARATOR(','),QUOTE('"')));
                            
	export cleaned := dataset(Cluster.Cluster_In + 'in::FBNv2::CA::Santa_Clara::Cleaned',Layout_File_CA_Santa_Clara_in.Cleaned, flat);
end;
