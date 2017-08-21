import _control, data_services, versioncontrol;

export _Dataset(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module
	export Name											:= 'ECRulings';
	export foreign_environment 			:= if(VersionControl._Flags.IsDataland
																				,data_services.foreign_prod
																				,data_services.foreign_dataland
																			 );
												
	
	export thor_cluster_Files				:= 	if(pUseOtherEnvironment 
																				,foreign_environment + 'thor_data400::'
																				,'~thor_data400::'
																			 );

	export Groupname					:= VersionControl.Groupname();

end;
