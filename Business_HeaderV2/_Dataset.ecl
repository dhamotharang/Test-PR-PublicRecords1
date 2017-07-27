import _control, versioncontrol, ut;
export _Dataset(

	boolean	pUseProd = false

):=
module

	export Name										:= 'Business_Header'		;
	export foreign_prod 					:= if(VersionControl._Flags.IsDataland
																			,ut.foreign_prod
																			,'~'
																		);
	export thor_cluster_Files			:= 	if(pUseProd 
																			,foreign_prod + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname	:= if(	_Control.ThisEnvironment.name		 = 'Dataland'	,'thor_dataland_linux'
																																					,'thor_dell400'
											);

end;