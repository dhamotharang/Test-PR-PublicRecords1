import _control, versioncontrol;

export _Dataset(

	boolean	pUseProd = false

):=
module

	export Name										:= 'Teletrack'								;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	//export max_record_size				:= 8192; //*** default 4096									;
	export max_record_size				:= 500000; 
	
	export Groupname	:= if(	_Control.ThisEnvironment.name		 = 'Dataland'	,'thor400_dev'
																																					,'thor400_44'
											);

end;