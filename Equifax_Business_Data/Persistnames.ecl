IMPORT lib_fileservices, ut;

EXPORT Persistnames( 

			BOOLEAN	pUseOtherEnvironment = FALSE	//if true on dataland, use prod, if true on prod, use dataland

) := MODULE
	
	EXPORT Root := Equifax_Business_Data._Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + Equifax_Business_Data._Constants().Name;
	
	EXPORT StandardizeInput			 := Root + '::standardize_Input';
	EXPORT StandardizeNameAddr	 := Root + '::standardize_NameAddr';
	EXPORT AppendIds						 := Root + '::Append_Ids.Bdid_xlinkids';


	EXPORT dall_filenames := DATASET([
															
															{StandardizeInput},
	                            {StandardizeNameAddr},
		                          {AppendIds}
																		
															], lib_fileservices.FsLogicalFileNameRecord);
END;