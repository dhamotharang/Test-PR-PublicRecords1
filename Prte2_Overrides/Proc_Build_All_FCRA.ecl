

EXPORT proc_build_all_FCRA(string prev_version, string current_version, string dest_cluster = thorlib.group(), boolean skipDOPS=True) := FUNCTION
	 
	  CopyFCRAFiles:=	Copy_Overrides_FCRA.fnCopyFromProd(prev_version, current_version, dest_cluster);
		
		DopsUpdateFCRA:= UpdateDops_FCRA (current_version,skipDops); 
	 	 	 
	  return_val := sequential(CopyFCRAFiles,DopsUpdateFCRA);
	   
	 return return_val;

END;