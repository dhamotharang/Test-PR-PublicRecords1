import versioncontrol;

export Filenames(string pversion = '') := module
		export lBaseTemplate			:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name+'::@version@::data';
		export Base    					:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
end;