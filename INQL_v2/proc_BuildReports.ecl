import std, PromoteSupers;

export proc_BuildReports(boolean isFCRA = false) := function
	
	nonfcra_weekly_version 		:= inql_v2._Versions.nonfcra_daily_base:INDEPENDENT;
	fcra_weekly_version 			:= inql_v2._Versions.fcra_daily_base:INDEPENDENT;
	
	nonfcra_reports_build 		:= 	sequential(
																					INQL_v2.Build_Reports(nonfcra_weekly_version, false);
																					);

	fcra_reports_build		    := sequential(
																					INQL_v2.Build_Reports(fcra_weekly_version, true);
																					);
	
	return if(isFCRA, fcra_reports_build, nonfcra_reports_build); 
	
end;