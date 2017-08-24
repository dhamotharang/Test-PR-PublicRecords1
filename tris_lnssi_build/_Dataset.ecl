import versioncontrol,data_services;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'tris_lnssi';
	export thor_cluster_Files			:= 	if(pUseProd 
																			,data_services.foreign_prod + '~thor_data400::',
																			'~thor_data400::'
																		);
																		
	export Groupname	:= VersionControl.Groupname;

end;