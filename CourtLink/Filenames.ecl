import versioncontrol;

export Filenames(string pversion = '') := module
	export lInputTemplate	:= _Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::@version@::LitDebt';
	export lBaseTemplate	:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::LitDebt';
	export Input   			:= versioncontrol.mInputFilenameVersions(lInputTemplate,'edata12',,,,,_Dataset().groupname,,,'VARIABLE',,400000,'\t','\r\n',);
	export Base    			:= versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
                                                                        
	export dAll_filenames 	:= Base.dAll_filenames;
end;