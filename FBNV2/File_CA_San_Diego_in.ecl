import ut, FBNV2;
export File_CA_San_Diego_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::fbnv2::ca::san_diego::sprayed',FBNV2.Layout_File_CA_San_diego_in.Sprayed ,CSV(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
	export cleaned := DATASET(Cluster.Cluster_In + 'in::fbnv2::ca::san_diego::cleaned',FBNV2.Layout_File_CA_San_diego_in.Cleaned , flat);									
end;