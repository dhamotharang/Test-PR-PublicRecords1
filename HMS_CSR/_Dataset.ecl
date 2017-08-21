import _control, versioncontrol,HMS_CSR;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'hms_csr';
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + '~thor400_data::',
																			'~thor400_data::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;