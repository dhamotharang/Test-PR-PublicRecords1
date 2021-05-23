import std, PromoteSupers,INQL_V2;

export proc_BuildBases_post(boolean isFCRA = false) := function
	

  daily  				:= 		sequential(                               INQL_V2.MOVE_FILES(isFCRA,true,).In_Bldg,
																		  INQL_V2.MOVE_FILES(isFCRA,true,).Bldg_To_Built_New
																		);
	
  
	return daily;
	
end;