import RoxieKeyBuild, dx_DemoWatchlistScreening;

EXPORT Proc_Build_Keys(string filedate) := function

//Buid Key
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_DemoWatchListScreening.Key_matches_entity_name, DemoWatchlistScreening.Files.base,
																						'~thor_data400::key::demo_watchlist_screening::@version@::matches_entity_name',
																						'~thor_data400::key::demo_watchlist_screening::'+filedate+'::matches_entity_name',build_match_key);


//Built Move
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::demo_watchlist_screening::@version@::matches_entity_name',
																			'~thor_data400::key::demo_watchlist_screening::'+filedate+'::matches_entity_name',mv_match_key);

//QA Move
Roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::demo_watchlist_screening::@version@::matches_entity_name','Q',qa_match_key,2);


return sequential(build_match_key, mv_match_key,qa_match_key);

end;