EXPORT proc_build_all(string prev_version, string current_version, string dest_cluster = thorlib.group(), boolean skipDOPS=True) := FUNCTION

  CopyAllFiles:=	Copy_Linking_Files.fnCopyFromProd(prev_version, current_version, dest_cluster);
	
	//DopsUpdate:= UpdateDops (current_version,skipDops); 
	 
  //return_val := sequential(CopyAllFiles, DopsUpdate);
	
	return_val := sequential(CopyAllFiles);
	
  return return_val;
	 
	 End;