import std, PromoteSupers, wk_ut,INQL_V2;

export proc_BuildBases(string version = '', boolean isFCRA = false, boolean pDaily = true) := function
	
	nonfcra_daily_version 	:= if(version = '', inql_v2._Versions.nonfcra_next_daily_base, version):INDEPENDENT;
	fcra_daily_version 			:= if(version = '', inql_v2._Versions.fcra_next_daily_base, version):INDEPENDENT;
	nonfcra_weekly_version 	:= if(version = '', inql_v2._Versions.nonfcra_daily_base, version):INDEPENDENT;
	fcra_weekly_version 		:= if(version = '', inql_v2._Versions.fcra_daily_base, version):INDEPENDENT;
	
  notify_post_ecl					:= 'notify(INQL_v2._CRON_ECL(\'BASE POST\',' + isFCRA + ',true).EVENT_NAME, \'*\');';
	     	
  nonfcra_daily_build    		:= sequential(
	                                             IF( INQL_v2._Flags(isFCRA,version).NonFCRA_Daily_Base_Consolidate_ToBuild,
												     INQL_v2.Build_Base(nonfcra_daily_version, false, true).inql_all,
													 INQL_v2.Build_Base(nonfcra_daily_version, false, true).inql_delta)
													,INQL_v2.Build_Base(nonfcra_daily_version, false, true).inql_DidVille
													,INQL_v2.Build_Base(nonfcra_daily_version, false, true).SBA_all		
													,INQL_v2.Build_Base(nonfcra_daily_version, false, true).Batch_PIIs_all
													,INQL_v2.MOVE_FILES(false,true,'weekly').Base_To_Building
													,wk_ut.CreateWuid(notify_post_ecl, INQL_v2._Constants.NONFCRA_THOR, INQL_v2._Constants.NON_FCRA_ESP)
												);
	
	nonfcra_history_build 		:= 	sequential(
																			 INQL_v2.Build_Base(nonfcra_weekly_version, false, false).inql_all
																			,INQL_v2.Build_Base(nonfcra_weekly_version, false, false).BillGroups_DID_all
																			);
	
	fcra_daily_build 					:= sequential(
																					INQL_v2.Build_Base(fcra_daily_version, true, true).inql_all
																				 ,wk_ut.CreateWuid(notify_post_ecl, INQL_v2._Constants.FCRA_THOR, INQL_v2._Constants.FCRA_ESP)
																			   );

	fcra_history_build		  := sequential(
																			 INQL_v2.MOVE_FILES(true,true,'weekly').Base_To_Building  // move daily base to building weekly  	
																			,INQL_v2.Build_Base(fcra_weekly_version, true, false).inql_all
																			,INQL_v2.Build_Base(fcra_weekly_version, true, false).BillGroups_DID_all
																			 );	
	
	nonfcra_build := 	if(pDaily, nonfcra_daily_build, nonfcra_history_build);
	
  fcra_build 		:= 	if(pDaily, fcra_daily_build, fcra_history_build);
	
	return if(isFCRA, fcra_build, nonfcra_build); 
	
end;