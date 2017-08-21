//This file was generated as a starting point only.  
//You must check and customize this process BEFORE running it.


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

MakeSuperKeys ('~prte::key::paw::@version@::autokey::address');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::addressb2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::citystname');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::citystnameb2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::fein2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::name');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::nameb2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::namewords2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::payload');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::phone2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::phoneb2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::ssn2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::stname');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::stnameb2');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::zip');
MakeSuperKeys ('~prte::key::paw::@version@::autokey::zipb2');
MakeSuperKeys ('~prte::key::paw::@version@::bdid');
MakeSuperKeys ('~prte::key::paw::@version@::companyname_domain');
MakeSuperKeys ('~prte::key::paw::@version@::contactid');
MakeSuperKeys ('~prte::key::paw::@version@::did');
MakeSuperKeys ('~prte::key::paw::@version@::linkids');
MakeSuperKeys ('~prte::key::paw::@version@::did_fcra');


MakeSuperFiles ('~PRTE::BASE::paw@version@');

FileServices.CreateSuperFile ('~PRTE::IN::paw');

RETURN 'SUCCESS';

End;

End;