import _control, versioncontrol,Data_services;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module
	export Name							:= 'OIG';
	export foreign_environment 			:= if(VersionControl._Flags.IsDataland
																	,Data_services.foreign_prod
																	,Data_services.foreign_dataland
																);
												
	
	export thor_cluster_Files			:= 	if(pUseOtherEnvironment 
												,foreign_environment + 'thor_data400::'
												,Data_services.Data_location.Prefix('OIG')+'thor_data400::');

	export Groupname					:= VersionControl.Groupname();

end;
