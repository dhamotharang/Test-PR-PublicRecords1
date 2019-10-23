import address;
export File_CA_Orange_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::Orange::Sprayed',Layout_File_CA_Orange_in.Sprayed, csv(Separator(','), quote('"'), Terminator('\n'), heading(35)));
	export cleaned := DATASET(Cluster.Cluster_In + 'in::fbnv2::ca::orange::cleaned',Layout_File_CA_Orange_in.Cleaned, thor);
end;