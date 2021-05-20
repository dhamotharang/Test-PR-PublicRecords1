import std, PromoteSupers, wk_ut;

export proc_BuildBases_prep(boolean isFCRA = false) := Module
	
  prefix := if(isFCRA,'thor10_231','thor100_21');	
	fcra   := if(isFCRA,'fcra','nonfcra');
																
	notify_ecl											:= 'notify(INQL_v2._CRON_ECL(\'BASE BUILD\',' + isFCRA + ',true).EVENT_NAME, \'*\');';
										
	//Starting the base building process.
	export daily 						:= sequential(
																			 notify(INQL_v2._CRON_ECL('FILES SCRUB',isFCRA,true).EVENT_NAME,'*')
																			,INQL_v2.MOVE_FILES(isFCRA).Batchr3Move
																			,INQL_v2.MOVE_FILES(isFCRA).Current_To_In_Bldg_New
																			,INQL_v2.MOVE_FILES(isFCRA).Current_To_In_Bldg 
																			,if (~isFCRA , INQL_v2.File_MBS.CreateFile())
																		    ,wk_ut.CreateWuid(notify_ecl,INQL_v2._Constants.PROD_THOR,INQL_v2._Constants.PROD_ESP)
																			);
	
end;