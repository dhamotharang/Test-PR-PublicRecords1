import _control, Data_Services, versioncontrol;

export _Dataset(boolean pUseOtherEnvironment = false) := module
	export foreign_prod 					:= if(VersionControl._Flags.IsDataland
																			,Data_Services.foreign_prod
																			,'~'
																		 );
	export name										:= 	'Business_Header';
	export thor_cluster_files			:= 	if(pUseOtherEnvironment
																			,Data_Services.foreign_prod + 'prte::'
																			,'~prte::'
																			);
	export thor_cluster_persists	:= 	thor_cluster_files;
	export max_record_size				:= 	4096;
	export groupname							:= 	versioncontrol.groupname();
end;