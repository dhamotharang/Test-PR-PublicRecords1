import versioncontrol;

export Filenames(string pversion = '') := module
		export lInputTemplate				:= 	_Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::@version@';
		export lBaseTemplate				:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@';
		export lKeyTemplate					:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '_keybuild::@version@';
		export Input   							:= 	versioncontrol.mInputFilenameVersions(lInputTemplate,'edata12',,,,,_Dataset().groupname,,,'VARIABLE',,400000,'|',,);
		export Base    							:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
		export Keybuild 						:= 	versioncontrol.mBuildFilenameVersions(lKeyTemplate,pversion);
end;