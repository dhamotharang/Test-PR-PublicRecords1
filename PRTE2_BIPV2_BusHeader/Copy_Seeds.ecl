EXPORT copy_seeds(string current_version, string dest_cluster = thorlib.group()) := FUNCTION

 	return	Copy_Files.fnCopyFromProd(current_version, dest_cluster);
	 
 	End;