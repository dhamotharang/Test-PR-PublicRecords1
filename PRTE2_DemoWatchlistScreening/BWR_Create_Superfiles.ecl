IMPORT std;

EXPORT BWR_Create_Superfiles := MODULE

	SHARED MakeSuperKeys(string name) := FUNCTION
		STD.File.CreateSuperFile(RegExReplace('@version@', name, 'qa'));
		STD.File.CreateSuperFile(RegExReplace('@version@', name, 'father'));
		STD.File.CreateSuperFile(RegExReplace('@version@', name, 'grandfather'));
		STD.File.CreateSuperFile(RegExReplace('@version@', name, 'delete'));
		RETURN 'SUCCESS';
	END;

	SHARED MakeSuperFiles(string name) := FUNCTION
		STD.File.CreateSuperFile(RegExReplace('@version@', name, '_built'));
		STD.File.CreateSuperFile(RegExReplace('@version@', name, '_father'));
		STD.File.CreateSuperFile(RegExReplace('@version@', name, '_grandfather'));
		STD.File.CreateSuperFile(RegExReplace('@version@', name, '_delete'));
		STD.File.CreateSuperFile(RegExReplace('@version@', name, ''));
		RETURN 'SUCCESS';
	END;

	EXPORT DO := FUNCTION
		MakeSuperKeys(PRTE2_DemoWatchlistScreening.Constants.keyname + '@version@::matches_entity_name');
		MakeSuperFiles(PRTE2_DemoWatchlistScreening.Constants.base_filename + '@version@');
		STD.File.CreateSuperFile(PRTE2_DemoWatchlistScreening.Constants.incoming_filename);
		
		RETURN 'SuperFiles Created';
	End; //Do Function

End;