IMPORT tools;

EXPORT Files(boolean isDaily = true, boolean isFCRA = true, string pVersion = '') := MODULE

 export Input
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).lInputTemplate, INQL_FFD.layouts.Input, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
	export History
		:= dataset(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).lInputHistTemplate, INQL_FFD.layouts.Input_Extended, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
			/* Base File pVersions */
	tools.mac_FilesBase(INQL_FFD.Filenames(isDaily,isFCRA,pVersion).Base, INQL_FFD.Layouts.Base, Base);
	
	/* Keybuild File */
	//pVersioncontrol.macBuildFilepVersions(Filenames(pVersion).keybuild, layouts.keybuild, keybuild); 
	 
END;