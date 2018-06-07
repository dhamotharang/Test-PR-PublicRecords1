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

makeSuperKeys ('~prte::key::insuranceheader::allpossiblessns::@version@');
makeSuperKeys ('~prte::key::insuranceheader::did::@version@');
makeSuperKeys ('~prte::key::insuranceheader::dln::@version@');

MakeSuperFiles ('~PRTE::Ancillary::AncillaryTemp@version@');

MakeSuperFiles ('~PRTE::Ancillary::AncillaryTempB@version@');

MakeSuperfiles ('~prte::base::insuranceheader::allpossiblessns@version@');

RETURN 'SUCCESS';

End;

End;