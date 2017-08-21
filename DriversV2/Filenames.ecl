// Code originally created by Sandy Butler.

import DriversV2, ut, versioncontrol;

export Filenames(string pversion = '',string suffix) := module
		shared append_name 				:=  ut.CleanSpacesAndUpper(suffix);
		export lInputTemplate			:= 	DriversV2.Constants.cluster + 'in::'   + 'dl2' + '::@version@::' + append_name;
		export lBaseTemplate			:= 	DriversV2.Constants.cluster + 'base::' + 'dl2' + '::@version@::' + append_name;
		export lKeybuildTemplate	:= 	DriversV2.Constants.cluster + 'temp::' + 'dl2' + '::@version@::' + append_name;		
		export Input   						:= 	versioncontrol.mInputFilenameVersions(lInputTemplate,,,,,,,pversion);
		export Base    						:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
		export Keybuild						:= 	versioncontrol.mBuildFilenameVersions(lKeybuildTemplate,pversion);
end;