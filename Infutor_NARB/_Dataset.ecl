import _control, versioncontrol, std;
export _Dataset(

	boolean	pUseProd = false

):=
module

	export Name										:= 'Infutor_NARB'								;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor_data400::'
																			,'~thor_data400::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 4096								;

	export Groupname	:= STD.System.Thorlib.Group( );

end;