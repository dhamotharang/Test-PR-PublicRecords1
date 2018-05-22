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

MakeSuperFiles ('~PRTE::BASE::lnpr::relate@version@');

FileServices.CreateSuperFile ('~PRTE::IN::lnpr::relate');

RETURN 'SUCCESS';

End;

End;