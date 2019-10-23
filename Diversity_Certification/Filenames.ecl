import versioncontrol, _Control;

export Filenames(string pversion = '') := module
		export lInputTemplate			:= _Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::@version@::allStates';
		export lBaseTemplate			:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::allStates';
		export lKeybuildTemplate	:= _Dataset().thor_cluster_files + 'temp::' + _Dataset().name + '::@version@::allStates';	
		export Input   						:= versioncontrol.mInputFilenameVersions(lInputTemplate,_Control.IPAddress.bctlpedata11,,,,,_Dataset().groupname,,,'VARIABLE',,_Dataset().max_record_size,'|','\\n,\\r\\n','[\'\']');
		export Base    						:= versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
	  export Keybuild						:= versioncontrol.mBuildFilenameVersions(lKeybuildTemplate,pversion);		

end;