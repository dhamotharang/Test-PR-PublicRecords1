IMPORT versioncontrol;

EXPORT Files(STRING pversion = '') := MODULE

   /* Input File Versions */
   versioncontrol.macInputFileVersions(Filenames(pversion).input, layouts.Input, Input,'CSV',,'\n','\t',1,40000);
      
	 /* Base File Versions */
   versioncontrol.macBuildFileVersions(Filenames(pversion).Base, layouts.Base, Base);
	  		
	/* Keybuild File */
   versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild);   
	 
END;

