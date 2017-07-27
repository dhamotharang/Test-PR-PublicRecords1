IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT IsTesting := tools._Constants.IsDataland;

	EXPORT FileExists := MODULE
		EXPORT Input := MODULE
		  EXPORT Death    := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Death.Sprayed))) > 0;
		  EXPORT Death_IL := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Death_IL.Sprayed))) > 0;
		END;
		
		EXPORT Base := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Main.QA))) > 0;
	END;

  EXPORT Update := (FileExists.Input.Death OR FileExists.Input.Death_IL) AND FileExists.Base;

END;