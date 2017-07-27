IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT IsTesting := tools._Constants.IsDataland;

	EXPORT UseStandardizePersists := NOT IsTesting;	// for bug 26170 -- Missing dependency from persist to stored

	EXPORT FileExists := MODULE
		EXPORT Input := MODULE
		  EXPORT License_Status := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.License_Status.Sprayed))) > 0;
			EXPORT Licensee  			:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Licensee.Sprayed))) > 0;
			EXPORT IL_License	  	:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.IL_License.Sprayed))) > 0;
		END;
		
		EXPORT Base := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Main.QA))) > 0;
	END;

  // Unless told otherwise, I'm forcing the existance of both input files to signify an update situation.
	// If a build size shrinks significantly, look to see if one (or both) of the input files is missing.
  EXPORT Update := (FileExists.Input.License_Status AND FileExists.Input.Licensee
	                    OR FileExists.Input.IL_License) AND FileExists.Base;

END;