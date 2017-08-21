import _control, ut, versioncontrol;

export _Dataset(boolean pUseOtherEnvironment = false) := module
	export foreign_prod 							:= if(VersionControl._Flags.IsDataland
																					,ut.foreign_prod
																					,'~'
																				 );
	export name												:= 	'prte_csv';
	export thor_cluster_files					:= 	if(pUseOtherEnvironment
																					,ut.foreign_prod + 'thor_data400::'
																					,'~thor_data400::'
																					);
	export thor_cluster_persists			:= 	thor_cluster_files;
	export prte_thor_cluster_files		:= 	if(pUseOtherEnvironment
																					,ut.foreign_prod + 'prte::'
																					,'~prte::'
																					);
	export prte_thor_cluster_persists	:= 	prte_thor_cluster_files;
	export max_record_size						:= 	4096;
	export groupname									:= 	versioncontrol.groupname();
end;