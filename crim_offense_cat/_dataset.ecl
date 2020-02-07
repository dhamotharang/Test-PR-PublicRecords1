import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module
	shared debug_ver := '1';
	export Name										:= 'crim_offense_cat' + debug_ver;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor::',
																			'~thor::'
																		);
end;
