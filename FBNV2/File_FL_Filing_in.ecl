import address, ut;

export File_FL_Filing_in := module
	export raw 		 			:= DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Filing::Sprayed',Layout_File_FL_in.Sprayed.Filing, flat);
	export cleaned 			:= DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Filing::Cleaned',Layout_File_FL_in.Cleaned.Filing, flat);
end;
 