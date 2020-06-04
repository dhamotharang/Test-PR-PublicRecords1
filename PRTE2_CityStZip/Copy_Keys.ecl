EXPORT Copy_Keys(string current_version, string dest_cluster = thorlib.group()) := FUNCTION

 	return	proc_CopyFiles.fnCopyFromProd(current_version, dest_cluster);
	 
 	End;