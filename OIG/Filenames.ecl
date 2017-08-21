import versioncontrol, OIG;

export Filenames(string pversion = '') := module
		export lBaseTemplate			:= 	OIG._Dataset().thor_cluster_files + 'base::' + OIG._Dataset().name+'::@version@::data';
		export lKeybuildTemplate		:= 	OIG._Dataset().thor_cluster_files + 'temp::' + OIG._Dataset().name +'::@version@::data';
		export Base    					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
		export Keybuild					:= 	versioncontrol.mBuildFilenameVersions(lKeybuildTemplate,pversion);

end;