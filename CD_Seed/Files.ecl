IMPORT tools,header,$;

r:= $.layouts;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
   export input := dataset(Filenames(pversion,pUseProd).lInputTemplate, layouts.Input, csv( separator(','),heading(1), terminator(['\n', '\r\n']), quote(['\'','"'])));
   
   /* Base File Versions */
   tools.mac_FilesBase(Filenames(pversion,pUseProd).Base_AsSrc, r.Base, Base_AsSrc);
   	 
END;