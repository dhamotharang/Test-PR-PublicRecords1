IMPORT tools, Infutor_NARC,Scrubs_Infutor_NARC;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
   export input := dataset(Infutor_NARC.Filenames(pversion,pUseProd).lInputTemplate, Infutor_NARC.layouts.Input, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote([''])));

	 /* Base File Versions */
   tools.mac_FilesBase(Infutor_NARC.Filenames(pversion,pUseProd).Base, Scrubs_Infutor_NARC.Base_Layout_Infutor_NARC, base);
	 	 
	 
END;