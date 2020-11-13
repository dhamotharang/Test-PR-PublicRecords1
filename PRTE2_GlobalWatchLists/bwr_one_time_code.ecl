
EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'built'));
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

MakeSuperKeys ('~prte::key::globalwatchlists::countries_@version@');
MakeSuperKeys ('~prte::key::globalwatchlists::globalwatchlists_key_@version@');
MakeSuperKeys ('~prte::key::globalwatchlists::seq_@version@');

MakeSuperKeys ('~prte::key::globalwatchlists::@version@::addlinfo');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::address');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::countries');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::country_aka');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::country_index');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::entities');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::id_numbers');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::names');
MakeSuperKeys ('~prte::key::globalwatchlists::@version@::name_index');
MakeSuperKeys ('~prte::base::globalwatchlistsv2::@version@::country_tokens');
MakeSuperKeys ('~prte::base::globalwatchlistsv2::@version@::name_tokens');

 MakeSuperKeys ('~prte::key::patriot_file_full_@version@');
 MakeSuperKeys ('~prte::key::baddids_@version@');
 MakeSuperKeys ('~prte::key::patriot_bdid_file_@version@');
 MakeSuperKeys ('~prte::key::patriot_did_file_@version@');
 MakeSuperKeys ('~prte::key::annotated_names_@version@');
 MakeSuperKeys ('~prte::key::patriot::baddies_with_name_@version@');

 MakeSuperKeys ('~prte::key::baddids::delta_rid_@version@');
 MakeSuperKeys ('~prte::key::annotated_names::delta_rid_@version@');
 MakeSuperKeys ('~prte::key::patriot_file_full::delta_rid_@version@');

 MakeSuperFiles ('~PRTE::BASE::globalwatchlists::GlobalWatchKeyLists@version@');

 FileServices.CreateSuperFile ('~PRTE::IN::globalwatchlists::GlobalWatchKeyLists');

 FileServices.CreateSuperFile ('~PRTE::IN::patriot::scorenames');

RETURN 'SUCCESS';

End;

End;