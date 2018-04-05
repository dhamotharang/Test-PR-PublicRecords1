import lib_fileservices;

export Persistnames( boolean	pUseOtherEnvironment = false			//if true on dataland, use prod, if true on prod, use dataland
										) := module
	
	export Root := _Constants(pUseOtherEnvironment).Thor_Cluster_Persists + 'persist::' + _Constants().Name;
	
	export StandardizeInput	:= root + '::standardize_Input'			;
	export StandardizeAddr	:= root + '::standardize_Addr'	;
	export AppendIds				:= root + '::Append_Ids.Bdid_xlinkids';

	export dall_filenames := dataset([ {StandardizeInput}
																		,{StandardizeAddr}
																		,{AppendIds}
																		], lib_fileservices.FsLogicalFileNameRecord
																	 );
	
end;