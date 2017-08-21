import ut;
export File_CA_San_Diego_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::San_diego::Sprayed',Layout_File_CA_San_diego_in.Sprayed , flat);
	export cleaned := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::San_diego::Cleaned',Layout_File_CA_San_diego_in.Cleaned , flat);
	
	export cleaned_Old := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::San_diego',Layout_File_CA_San_diego_in.Cleaned_Old , flat);
end;