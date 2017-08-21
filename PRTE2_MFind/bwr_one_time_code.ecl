EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;

SHARED MakeSuperFiles(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, ''));
	RETURN 'SUCCESS';
END;

EXPORT DO := FUNCTION

MakeSuperKeys ('~prte::key::mfind::autokey::@version@::address');
MakeSuperKeys ('~prte::key::mfind::autokey::@version@::citystname');
MakeSuperKeys ('~prte::key::mfind::autokey::@version@::name');
MakeSuperKeys ('~prte::key::mfind::autokey::@version@::payload');
MakeSuperKeys ('~prte::key::mfind::autokey::@version@::stname');
MakeSuperKeys ('~prte::key::mfind::autokey::@version@::zip');
MakeSuperKeys ('~prte::key::mfind::@version@::did');
MakeSuperKeys ('~prte::key::mfind::@version@::vid');


MakeSuperFiles ('~PRTE::BASE::mfind@version@');

FileServices.CreateSuperFile ('~PRTE::IN::mfind');

RETURN 'SUCCESS';

End;

End;