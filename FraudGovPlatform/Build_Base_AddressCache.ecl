Import ut,tools,FraudShared; 

EXPORT Build_Base_AddressCache (
   string pversion
	,dataset(Layouts.Base.AddressCache)	inAddressCache_IDDT		= Files().Input.AddressCache_IDDT.Sprayed
	,dataset(Layouts.Base.AddressCache)	inAddressCache_KNFD		= Files().Input.AddressCache_KNFD.Sprayed
) := 
module 

	pDataset_sort := sort(inAddressCache_IDDT + inAddressCache_KNFD , address_id, -address_cleaned);
	pDataset_dedup := dedup(pDataset_sort, address_id);
	
	tools.mac_WriteFile(Filenames(pversion).Base.AddressCache.New,pDataset_dedup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
	);
	
end;
