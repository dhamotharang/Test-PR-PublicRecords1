import versioncontrol;

export _Dataset(boolean pUseProd = false) := module
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'thor::',
																			'~thor::' //this is the one I'm allowed to use
																		);
end;
