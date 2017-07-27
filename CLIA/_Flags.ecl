IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT IsTesting := tools._Constants.IsDataland;

	EXPORT UseStandardizePersists := NOT IsTesting;	// for bug 26170 -- Missing dependency from persist to stored

	EXPORT FileExists := MODULE
		EXPORT Input := MODULE
		  EXPORT Main 					:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Main.Sprayed))) > 0;
			EXPORT Accreditation  := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Accreditation.Sprayed))) > 0;
			EXPORT Compliance     := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Compliance.Sprayed))) > 0;
			EXPORT Microscopy     := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Microscopy.Sprayed))) > 0;
			EXPORT Waiver         := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Waiver.Sprayed))) > 0;
		END;
		EXPORT Base := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Main.QA))) > 0;
	END;

  EXPORT Update := FileExists.Input.Main AND FileExists.Base;

END;