IMPORT lib_fileservices, ut;

EXPORT Persistnames( BOOLEAN	pUseOtherEnvironment = FALSE) := MODULE	//if true on dataland, use prod, if true on prod, use dataland

	EXPORT Root := OPM._Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + OPM._Constants().Name;
	
  EXPORT StandardizeInput			 := Root + '::standardize_Input';
	EXPORT StandardizeNameAddr	 := Root + '::standardize_NameAddr';
	EXPORT AppendIds						 := Root + '::Append_Ids.xlinkids';

	EXPORT dall_filenames := DATASET([{StandardizeInput},
																		{StandardizeNameAddr},
																		{AppendIds}																		
																	  ], lib_fileservices.FsLogicalFileNameRecord
																	);
END;