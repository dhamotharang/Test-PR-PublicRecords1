import _control, ut, versioncontrol, data_services, tools;

EXPORT _Dataset(boolean pUseOtherEnvironment = false) := module
	export foreign_prod 							:= if(VersionControl._Flags.IsDataland
																					,ut.foreign_prod
																					,'~'
																				 );
	export name												:= 	'prte::';
	export thor_cluster_files					:= 	if(pUseOtherEnvironment
																					,Data_Services.foreign_prod + name
																					,'~'+name
																					);
	export thor_cluster_persists			:= 	thor_cluster_files;
	export prte_thor_cluster_files		:= 	if(pUseOtherEnvironment
																					,Data_Services.foreign_prod + name
																					,'~'+ name
																					);
	export prte_thor_cluster_persists	:= 	prte_thor_cluster_files;
	export max_record_size						:= 	4096;
	export groupname									:= 	versioncontrol.groupname();
	export spray_groupname						:= 	tools.fun_Clustername_DFU();
end;

