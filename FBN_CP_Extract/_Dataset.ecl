import _control, versioncontrol;

export _Dataset(boolean pUseOtherEnvironment = false,string bldType = '') := module
	export Name										:= 	if (	bldType='E',
																						'FBN_Experian_Extract',
																						if (	bldType='F',
																										'FBN_Florida_Extract',
																										'FBN_Extract'
																								)
																				);
	export thor_cluster_Files			:= 	'~thor_data400::';
	export thor_cluster_Persists	:= 	thor_cluster_Files;
	export max_record_size				:= 	12000;
	export Groupname							:= 	versioncontrol.groupname();
end;