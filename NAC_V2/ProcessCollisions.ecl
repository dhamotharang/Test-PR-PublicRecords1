/*
	process new NAC2 collisions
  this applies to NAC1 states only, so only SNAP/DSNAP programs are allowed
*/
EXPORT ProcessCollisions(DATASET($.Layout_Collisions2.Layout_Collisions) collisions, string version) := FUNCTION
				fixed := collisions(searchbenefittype in ['D','S'],casebenefittype in ['D','S']);
				col1 := Nac_V2.fn_collisions2To1(fixed);	// convert to nac1 format collisions
				$.fn_Despray_DBC1(col1);
				return COUNT(col1);
END;

 