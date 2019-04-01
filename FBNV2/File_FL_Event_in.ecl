import address, ut;

export File_FL_Event_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Event::Sprayed',Layout_File_FL_in.Sprayed.Event, flat);
	export cleaned := DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Event::Cleaned',Layout_File_FL_in.Cleaned.Event, flat);
end;
 
