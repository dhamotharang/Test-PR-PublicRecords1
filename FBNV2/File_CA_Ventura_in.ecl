import address, ut;

export File_CA_Ventura_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::Ventura::Sprayed',Layout_File_CA_Ventura_in.Sprayed, 
																			csv(separator('~'),quote('"'),terminator('\r\n')));
	export cleaned := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::Ventura::Cleaned',Layout_File_CA_Ventura_in.Cleaned, thor);
end;