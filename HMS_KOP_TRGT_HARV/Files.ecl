IMPORT tools, hms_kop_trgt_harv;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
 

   /* Input File Versions */
	 	 
	 	 
	 EXPORT trgt_harv_input := dataset(Filenames(pversion,pUseProd).trgtharv_lInputTemplate, layouts.layout_in, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 /* Base File Versions */
   
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).koptrgtharv_Base, hms_kop_trgt_harv.layouts.layout_base, koptrgtharv_Base);	 
		 
	/* Keybuild File */
   //versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;