import _control, versioncontrol;
export _Dataset(

	boolean	pUseProd = false

):=
module

	export Name										:= 'ACA'								;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor_200::'
																			,'~thor_200::'
																		);
	export thor_cluster_keys			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export max_record_size				:= 4096									;

	export Groupname	:= versioncontrol.Groupname();

end;