import std, PromoteSupers;

export proc_BuildBases_post(boolean isFCRA = false) := function
	
		
  daily  				:= 		sequential(
																		  //INQL_v2.ConsolidateInputs(isFCRA).do
																		  INQL_v2.CLEAR_FILES(isFCRA).In_Bldg;
																		);
	
  
	return daily;
	
end;