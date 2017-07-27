import _control, versioncontrol,ut;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module

	export foreign_environment := if(VersionControl._Flags.IsDataland
																	,ut.foreign_prod
																	,ut.foreign_dataland
																);
												
	export Name										:= 'Corp2'		;
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
																			,foreign_environment + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export foreign_prod := if(VersionControl._Flags.IsDataland
													,ut.foreign_prod
													,'~'
												);
	export thor_cluster_Persists	:= thor_cluster_Files		;

	export Groupname							:= VersionControl.Groupname();
	
	export bShouldSpray						:= false;	// controls whether the individual states should spray their own data
																					// false -- they don't(assumed that the data is already sprayed)
																					// true  -- they do

end;