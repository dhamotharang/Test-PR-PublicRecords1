IMPORT tools;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
   export input_lt := dataset(Filenames(pversion,pUseProd).lInputLtTemplate, layouts.Input_LT, csv( separator(','),heading(1), terminator(['\n', '\r\n']), quote(['\'','"']), MAXLENGTH(40000)));
   export input_pd := dataset(Filenames(pversion,pUseProd).lInputPdTemplate, layouts.Input_PD, csv( separator(','),heading(1), terminator(['\n', '\r\n']), quote(['\'','"']), MAXLENGTH(40000)));
	 	 
	 /* Base File Versions */
   tools.mac_FilesBase(Filenames(pversion,pUseProd).Base, layouts.Base, base);
	 	 
	/* Keybuild File */
   //versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;