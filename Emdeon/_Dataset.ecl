IMPORT _control, versioncontrol;

EXPORT _Dataset(BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT Name										:= 'claims'							;
	EXPORT thor_cluster_Files			:= 	IF(pUseProd 
																			,VersionControl.foreign_prod + 'enclarity_emdeon::',
																			'~enclarity_emdeon::'
																		);
	EXPORT thor_cluster_Persists	:= thor_cluster_Files		;
	EXPORT max_record_size				:= 40000;

	EXPORT Groupname	:= versioncontrol.Groupname();

END;