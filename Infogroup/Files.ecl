IMPORT Infogroup, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

  /* Input File Versions */
	EXPORT Input := DATASET(Infogroup.Filenames(pversion, pUseProd).Data_lInputTemplate, Infogroup.Layouts.Input, FLAT);

	/* Base File Versions */
	tools.mac_FilesBase(Infogroup.Filenames(pversion, pUseProd).Base, Infogroup.Layouts.Base, Base);

END;