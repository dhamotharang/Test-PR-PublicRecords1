EXPORT Copy_Files(string current_version, string dest_cluster = thorlib.group()) := FUNCTION

 	return	proc_CopyFiles.fnCopyFromProd(current_version, 'thor400_sta01');
	 
 	End;