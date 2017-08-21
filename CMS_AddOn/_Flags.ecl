IMPORT CMS_AddOn, VersionControl;

EXPORT _Flags(BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT IsTesting := VersionControl._Flags.IsDataland;

  EXPORT FileExists := MODULE
	  EXPORT Input := MODULE
			EXPORT AddOn := COUNT(NOTHOR(FileServices.SuperFileContents(CMS_AddOn.Filenames(, pUseProd).lInputTemplate))) > 0;
		END;

		EXPORT Base := COUNT(NOTHOR(FileServices.SuperFileContents(CMS_AddOn.Filenames().Base.QA))) > 0;
	END;

  EXPORT Update := FileExists.Input.AddOn AND FileExists.Base;

END;
