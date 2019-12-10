import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'crim_offense_cat';
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor::',
																			'~thor::'
																		);
end;
