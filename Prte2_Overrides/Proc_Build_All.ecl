

EXPORT proc_build_all(string prev_version, string current_version, string dest_cluster = thorlib.group(), boolean skipDOPS=True) := FUNCTION
  	  
	 //NON_FCRA	
	 
	 CopyNonFCRAFiles:=	Copy_Overrides.fnCopyFromProd(prev_version, current_version, dest_cluster);
	 DopsUpdateNonFCRA:= UpdateDops (current_version,skipDops);
	 
	  //FCRA   
	  //CopyFCRAFiles:=	Copy_Overrides_FCRA.fnCopyFromProd(prev_version, current_version, dest_cluster);
		//DopsUpdateFCRA:= UpdateDops_FCRA (current_version,skipDops); 
		
	 //return_val := sequential(CopyFCRAFiles,CopyNONFCRAFiles,DopsUpdateFCRA,DopsUpdateNonFCRA);
	 
	   return_val := sequential(CopyNONFCRAFiles,DopsUpdateNonFCRA);
	 	   
	 return return_val;

END;