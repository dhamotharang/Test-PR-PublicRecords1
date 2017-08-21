//This file was generated as a starting point only.  
//You must check and customize this process BEFORE running it.


EXPORT BWR_ONE_TIME_CODE := MODULE

	SHARED MakeSuperFiles(string name) := FUNCTION
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_built'),,true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_father'),,true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_grandfather'),,true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_delete'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, ''),,true);
		RETURN 'SUCCESS';
	END;
	
	SHARED MakeSuperKeys(string name) := FUNCTION
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'),,true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'),,true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'),,true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'),,true);
		RETURN 'SUCCESS';
	END;


EXPORT DO := FUNCTION

MakeSuperKeys ('~prte::key::header.adl.infutor.knowx_@version@');
MakeSuperKeys ('~prte::key::header.teaser_did_@version@');
MakeSuperKeys ('~prte::key::header.teaser_search_@version@');
MakeSuperKeys ('~prte::key::infutor::best.did_@version@');

MakeSuperFiles ('~prte::base::infutor_best_did@version@');

RETURN 'SUCCESS';

End;

End;