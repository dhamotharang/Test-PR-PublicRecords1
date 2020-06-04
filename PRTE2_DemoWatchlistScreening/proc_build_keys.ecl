import RoxieKeyBuild, dx_DemoWatchlistScreening, PRTE2_Common,_control,PRTE ;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo= '') := function

//Buid Key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(prte2_DemoWatchListScreening.Keys.matches_entity_name, 
																						prte2_demoWatchlistScreening.constants.keyname + '@version@::matches_entity_name',
																						prte2_demoWatchlistScreening.constants.keyname + filedate+'::matches_entity_name',
																						build_match_key);


//Built Move
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(prte2_demoWatchlistScreening.constants.keyname + '@version@::matches_entity_name',
																			prte2_demoWatchlistScreening.constants.keyname + filedate+'::matches_entity_name',
																			mv_match_key);

//QA Move
Roxiekeybuild.MAC_SK_Move_v2(prte2_demoWatchlistScreening.constants.keyname+ '@version@::matches_entity_name','Q',qa_match_key,2);

//---------- making DOPS optional -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 							:= is_running_in_prod AND NOT skipDOPS;
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:= PRTE.UpdateVersion('WatchlistScreeningKeys', filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	PerformUpdateOrNot	:= IF(doDOPS,updatedops,NoUpdate);
	//----------------------------------------------------------------

return sequential(build_match_key, mv_match_key,qa_match_key/*, PerformUpdateOrNot*/);

end;