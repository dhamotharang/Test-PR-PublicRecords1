import std;

export proc_BuildKeys(string pVersion = '', boolean fcra = false, boolean pDaily = false) := function

  seq := sequential(
						if(pDaily
						,INQL_v2.MOVE_FILES(fcra).Built_To_DailyBase_Bldg  //Copy contents of daily built base files to in_bldg_daily
						,INQL_v2.MOVE_FILES(fcra).Built_To_WeeklyBase_Bldg //Copy Contents of weekly built base files to in_bldg_weekly
					 )
					,INQL_v2.Build_Keys(pVersion, fcra, pDaily).all  //start building of Key files
				);

	return seq;
	
end;
