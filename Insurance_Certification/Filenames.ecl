import versioncontrol, _Control;

export Filenames(string psuffix = '', string pversion = '') := module
	export lInputTemplate	:= 	_Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::@version@::'+psuffix;
	export lBaseTemplate	:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::'+psuffix;
	export lKeyTemplate	  := 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::@version@::'+psuffix;		
	export Input   				:= 	versioncontrol.mInputFilenameVersions(lInputTemplate,_Control.IPAddress.bctlpedata11,,,,,_Dataset().groupname,,,'VARIABLE',,400000,'|',,);
	export Base    				:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
	export Keybuild				:= 	versioncontrol.mBuildFilenameVersions(lKeyTemplate,pversion);		

end;
