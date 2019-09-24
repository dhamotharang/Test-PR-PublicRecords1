IMPORT lib_fileservices, ut;

EXPORT Persist_Names(BOOLEAN	pUseOtherEnvironment = FALSE) := MODULE
	
	EXPORT Root := Database_USA._Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + Database_USA._Constants().Name;
	
	EXPORT StandardizeInput			 := Root + '::standardize_Input';
	EXPORT StandardizeNameAddr	 := Root + '::standardize_NameAddr';
	EXPORT Append_Ids						 := Root + '::Append_Ids_xlinkids';


	EXPORT dall_filenames := DATASET([
															
															{StandardizeInput},
	                            {StandardizeNameAddr},
		                          {Append_Ids}
																		
															], lib_fileservices.FsLogicalFileNameRecord);
END;