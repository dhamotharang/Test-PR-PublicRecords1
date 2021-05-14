EXPORT proc_build_all(string prev_version, string current_version, string dest_cluster = thorlib.group(), boolean skipDOPS=True) := FUNCTION

  CopyAllFiles:=	Copy_Linking_Files.fnCopyFromProd(prev_version, current_version, dest_cluster);
	
	DopsUpdate:= UpdateDops (current_version,skipDops); 
	Orbit_update:=build_orbit(current_version);
	 
  return_val := sequential(CopyAllFiles, DopsUpdate,orbit_Update);
	
  return return_val;
	 
	 End;
