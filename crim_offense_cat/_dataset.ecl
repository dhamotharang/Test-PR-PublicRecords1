import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module
	debug_ver := '';
	debug_ver_safe := if(pUseProd, '', debug_ver);
	export Name										:= 'crim_offense_cat' + debug_ver_safe;
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor::',
																			'~thor::'
																		);
end;
