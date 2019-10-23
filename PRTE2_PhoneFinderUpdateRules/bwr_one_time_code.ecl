
EXPORT BWR_ONE_TIME_CODE := MODULE


SHARED MakeSuperFiles(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, ''));
	RETURN 'SUCCESS';
END;

EXPORT DO := FUNCTION

MakeSuperFiles (Constants.base_phonefinder_update_rules + '@version@');

FileServices.CreateSuperFile (Constants.in_phonefinder_update_rules);

RETURN 'SUCCESS';

End;

End;