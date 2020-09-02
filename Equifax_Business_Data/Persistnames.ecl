IMPORT lib_fileservices, ut;

EXPORT Persistnames( 

			BOOLEAN	pUseOtherEnvironment = FALSE	//if true on dataland, use prod, if true on prod, use dataland

) := MODULE
	
	EXPORT Root := Equifax_Business_Data._Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + Equifax_Business_Data._Constants().Name;
	
	EXPORT StandardizeInput			    := Root + '::standardize_Input';
	EXPORT StandardizeInputContacts := Root + '::standardize_InputContacts';
	EXPORT StandardizeNameAddr	    := Root + '::standardize_NameAddr';	
	EXPORT StandardizeNameContacts  := Root + '::standardize_NameContacts';
	EXPORT AppendIds						    := Root + '::Append_Ids.xlinkids';
	EXPORT AppendDIdsContacts		    := Root + '::Append_DIds_Contacts';
	EXPORT CompanyContactJoin       := Root + '::CompanyContactJoin';
	EXPORT CompanyContactDedup      := Root + '::CompanyContactDedup';
	EXPORT AsBusinessContact        := Root + '::AsBusinessContact';


	EXPORT dall_filenames := DATASET([
															
															{StandardizeInput},
															{StandardizeInputContacts},
	                            {StandardizeNameAddr},
	                            {StandardizeNameContacts},
		                          {AppendIds},
															{AppendDIdsContacts},
															{CompanyContactJoin},
															{CompanyContactDedup},
															{AsBusinessContact}
																		
															], lib_fileservices.FsLogicalFileNameRecord);
END;