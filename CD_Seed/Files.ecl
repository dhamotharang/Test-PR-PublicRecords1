IMPORT tools,header;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
   export input := dataset(Filenames(pversion,pUseProd).lInputTemplate, layouts.Input, csv( separator(','),heading(1), terminator(['\n', '\r\n']), quote(['\'','"'])));
   
   /* Base File Versions */
   tools.mac_FilesBase(Filenames(pversion,pUseProd).Base_AsSrc, Layouts.Base, Base_AsSrc);
   
   tools.mac_FilesBase(Filenames(pversion,pUseProd).Base_AsHeader, Header.Layout_New_Records, BaseSeed_AsHeader);
	 
END;