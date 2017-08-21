IMPORT Infogroup, VersionControl;

EXPORT _Flags(BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT IsTesting := VersionControl._Flags.IsDataland;

  EXPORT FileExists := MODULE
	  EXPORT Input := COUNT(NOTHOR(FileServices.SuperFileContents(Infogroup.Filenames(, pUseProd).Data_lInputTemplate))) > 0;

		EXPORT Base := COUNT(NOTHOR(FileServices.SuperFileContents(Infogroup.Filenames().Base.QA))) > 0;
	END;

  EXPORT Update := FileExists.Input AND FileExists.Base;

END;
