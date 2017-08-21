IMPORT tools;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
  export input := dataset(Filenames(pversion,pUseProd).lInputTemplate, layouts.Input, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['\'','"'])));

	// EXPORT input	:= DATASET('~thor_data400::in::link2tek_test',layouts.input, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 /* Base File Versions */
   tools.mac_FilesBase(Filenames(pversion,pUseProd).Base, layouts.Base, base);

	 // EXPORT base	:= DATASET('~thor_data400::base::link2tek::20130930', layouts.base, flat, __compressed__);	 
	/* Keybuild File */
   // versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;