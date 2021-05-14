import std, PromoteSupers;

export proc_BuildBases_post(boolean isFCRA = false) := function
	

  daily  				:= 		sequential(
																		  notify(INQL_v2._CRON_ECL('FILES CONSOLIDATE',isFCRA,true).EVENT_NAME, '*');
																		  INQL_v2.CLEAR_FILES(isFCRA).In_Bldg;
																		);
	
  
	return daily;
	
end;