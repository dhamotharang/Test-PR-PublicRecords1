EXPORT proc_build_all(string prev_version, string current_version, string dest_cluster = thorlib.group(), boolean skipDOPS=True) := FUNCTION


  CopyAllFiles:=	Copy_FraudGov_Files.fnCopyFromProd(prev_version, current_version, dest_cluster);
	 
  DopsUpdate:= UpdateDops (current_version,skipDops); 
	
	DopsValidation:=keyValidations(current_version);
	
	Orbit_Create:=create_orbit_build(current_version);
	 
	return_val := sequential(CopyAllFiles,DopsUpdate,DopsValidation,Orbit_Create);
  
	return return_val;
	 
	 End;
