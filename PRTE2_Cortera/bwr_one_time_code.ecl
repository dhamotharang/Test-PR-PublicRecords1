
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

MakeSuperKeys ('~prte::key::cortera::@version@::executive_linkid');

MakeSuperKeys ('~prte::key::cortera::@version@::attr_linkid');

MakeSuperKeys ('prte::key::cortera::@version@::hdr_linkid');

MakeSuperKeys ('prte::key::cortera::@version@::linkids');


MakeSuperFiles ('~prte::base::cortera::header@version@');

MakeSuperFiles ('~ prte::base::cortera::attributes@version@');


FileServices.CreateSuperFile ('~prte::in::cortera::boca');

FileServices.CreateSuperFile ('~prte::in::cortera::Insurance');


RETURN 'SUCCESS';

End;

End;