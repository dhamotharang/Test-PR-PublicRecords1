
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

MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::address');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::addressb2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::citystname');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::citystnameb2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::name');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::nameb2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::namewords2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::payload');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::phone2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::phoneb2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::stname');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::stnameb2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::zip');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::zipb2');
MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::ssn2');
 MakeSuperKeys ('~prte::key::fbnv2::@version@::autokey::fein2');
 
MakeSuperKeys ('~prte::key::fbnv2::@version@::bdid');
MakeSuperKeys ('~prte::key::fbnv2::@version@::did');
MakeSuperKeys ('~prte::key::fbnv2::@version@::filing_number');
MakeSuperKeys ('~prte::key::fbnv2::@version@::linkids');
MakeSuperKeys ('~prte::key::fbnv2::@version@::rmsid_business');
MakeSuperKeys ('~prte::key::fbnv2::@version@::rmsid_contact');


MakeSuperFiles ('~PRTE::BASE::fbnv2::business@version@');

MakeSuperFiles ('~PRTE::BASE::fbnv2::contact@version@');

FileServices.CreateSuperFile ('~PRTE::IN::fbnv2::business');

FileServices.CreateSuperFile ('~PRTE::IN::fbnv2::contact');

RETURN 'SUCCESS';

End;

End;