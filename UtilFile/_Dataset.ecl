import _control, versioncontrol;
export _Dataset(

	boolean	pUseProd = false

):=
module

	export Name										:= 'UtilFile'								;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	
	export Groupname	:= if(	_Control.ThisEnvironment.name		 = 'Dataland'	,'thor400_88_dev'
																																					,'thor400_92'
											);

end;