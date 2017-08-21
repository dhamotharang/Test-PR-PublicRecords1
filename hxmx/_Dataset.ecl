IMPORT _control, versioncontrol;

EXPORT _Dataset(boolean pUseProd = FALSE) := MODULE

	EXPORT Name										:= 'hxmx_claims'							;
	EXPORT thor_cluster_Files			:= 	IF (pUseProd 
																			,VersionControl.foreign_prod + 'thor400_data::',
																			'~thor400_data::'
																		);
	EXPORT thor_cluster_Persists	:= thor_cluster_Files		;
	EXPORT max_record_size				:= 40000;

	EXPORT Groupname	:= versioncontrol.Groupname();

END;