import versioncontrol;

export Filenames(string psuffix = '', string pversion = '') := module
		export lInputTemplate			:= 	_Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::@version@::'+psuffix;
		export lBaseTemplate			:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::'+psuffix;
		export lKeybuildTemplate	:= 	_Dataset().thor_cluster_files + 'temp::' + _Dataset().name + '::@version@::'+psuffix;		
		export Input   						:= 	versioncontrol.mInputFilenameVersions(lInputTemplate,'edata12',,,,,_Dataset().groupname,,,'VARIABLE',,400000,'|',,);
		export Base    						:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
		export Keybuild						:= 	versioncontrol.mBuildFilenameVersions(lKeybuildTemplate,pversion);		

end;