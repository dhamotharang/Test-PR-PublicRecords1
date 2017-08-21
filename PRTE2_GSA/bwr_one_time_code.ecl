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

		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::address');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::addressb2');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::citystname');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::citystnameb2');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::name');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::nameb2');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::namewords2');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::payload');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::stname');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::stnameb2');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::zip');
		MakeSuperKeys ('~prte::key::gsa::autokey::@version@::zipb2');
		MakeSuperKeys ('~prte::key::gsa::@version@::bdid');
		MakeSuperKeys ('~prte::key::gsa::@version@::did');
		MakeSuperKeys ('~prte::key::gsa::@version@::gsa_id');
		MakeSuperKeys ('~prte::key::gsa::@version@::linkids');
		MakeSuperKeys ('~prte::key::gsa::@version@::lnpid');

		MakeSuperFiles ('~PRTE::BASE::gsa@version@');

		FileServices.CreateSuperFile ('~PRTE::IN::gsa');

		RETURN 'SUCCESS';

	End;

End;