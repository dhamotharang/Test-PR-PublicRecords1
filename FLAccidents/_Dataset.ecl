import _control, versioncontrol;
export _Dataset(

	boolean	pUseProd = false

):=
module

	export Name										:= 'FLAccidents'								;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096									;

	export Groupname	:= if(	_Control.ThisEnvironment.name		 = 'Dataland'	,'thor400_88'
																																					,'thor400_60'
											);

end;