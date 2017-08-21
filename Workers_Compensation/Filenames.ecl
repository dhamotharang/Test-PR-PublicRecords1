import versioncontrol;

export Filenames(string pversion = '') := module
	export lInputTemplate 		:= 	_Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::@version@';
	export lBaseTemplate			:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@';
	export lKeyTemplate 			:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::@version@';
	export lBaseFullTemplate	:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '_Full' +  '::@version@';
	export lKeyFullTemplate 	:= 	_Dataset().thor_cluster_files + 'base::' + _Dataset().name + '_keybuild_full' + '::@version@';
	export Input   						:= 	versioncontrol.mInputFilenameVersions(lInputTemplate,'edata12',,,,,_Dataset().groupname,,,'VARIABLE',,400000,'\t',,);
	export Base    						:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
	export Keybuild 					:= 	versioncontrol.mBuildFilenameVersions(lKeyTemplate,pversion);
	export Base_Full    			:= 	versioncontrol.mBuildFilenameVersions(lBaseFullTemplate,pversion);
	export Keybuild_Full 			:= 	versioncontrol.mBuildFilenameVersions(lKeyFullTemplate,pversion);
end;