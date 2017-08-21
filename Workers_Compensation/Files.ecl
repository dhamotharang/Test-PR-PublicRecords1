IMPORT versioncontrol;

EXPORT Files(STRING pversion = '') := MODULE

   /* Input File Versions */
   versioncontrol.macInputFileVersions(Filenames(pversion).input, layouts.Input, Input,'CSV',,'\n','\t',1,40000);
      
	 /* Base File Versions Expanded */
   versioncontrol.macBuildFileVersions(Filenames(pversion).Base, layouts.Base, Base);
	 
	 /* Base File Versions */
   versioncontrol.macBuildFileVersions(Filenames(pversion).Base_Full, layouts.Base_Full, Base_Full);
	 
	/* Keybuild File */
   versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.Keybuild, keybuild);   
	 
	 	/* Keybuild File Expanded */
   versioncontrol.macBuildFileVersions(Filenames(pversion).Keybuild_Full, layouts.Keybuild_Full, keybuild_full);  
	 
END;

