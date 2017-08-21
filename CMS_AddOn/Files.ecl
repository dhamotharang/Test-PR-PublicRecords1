IMPORT CMS_AddOn, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

  /* Input File Versions */
  EXPORT Input := DATASET(CMS_AddOn.Filenames(pversion, pUseProd).lInputTemplate, CMS_AddOn.Layouts.Input, CSV(SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));

	/* Base File Versions */
  tools.mac_FilesBase(CMS_AddOn.Filenames(pversion, pUseProd).Base, CMS_AddOn.Layouts.Base, Base);

END;