IMPORT tools;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE


   /* Input File Versions */
   export input := dataset(IDA.Filenames(pversion,pUseProd).lInputTemplate_built, IDA.Layouts.Input, CSV(HEADING(1),SEPARATOR('|')));

   /* Cleaned Input */

   export cleanedinput :=DATASET('~thor_data400::in::clean::ida::built',IDA.Layouts.input,csv(heading(1), separator('|'),terminator(['\n', '\r\n']), quote('"')));


	 /*Accumulative Base File Versions */
   tools.mac_FilesBase(IDA.Filenames(pversion,pUseProd).Base, IDA.layouts.Base, Base);
	 
	 /*Daily Base File Versions */
   tools.mac_FilesBase(IDA.Filenames(pversion,pUseProd).BaseDaily, IDA.layouts.Base, BaseDaily);
	 
	 /*Despray File Versions */
   tools.mac_FilesBase(IDA.Filenames(pversion,pUseProd).Despray, IDA.layouts.Despray, Despray);
	 	 
	/* Keybuild File */
   //versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
	 
END;