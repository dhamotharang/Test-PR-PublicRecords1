
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

MakeSuperKeys ('~prte::key::voters::fcra::@version@::bocashell_voters_source_states_lookup');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::address');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::citystname');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::name');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::payload');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::phone2');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::ssn2');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::stname');
MakeSuperKeys ('~prte::key::voters::autokey::@version@::zip');
MakeSuperKeys ('~prte::key::voters::@version@::did');
MakeSuperKeys ('~prte::key::voters::@version@::history_vtid');
MakeSuperKeys ('~prte::key::voters::@version@::vtid');
MakeSuperKeys ('~prte::key::voters::@version@::bocashell_voters_source_states_lookup');

FileServices.CreateSuperFile ('~PRTE::IN::voters');

MakeSuperFiles ('~PRTE::BASE::voters@version@');

RETURN 'SUCCESS';

End;

End;