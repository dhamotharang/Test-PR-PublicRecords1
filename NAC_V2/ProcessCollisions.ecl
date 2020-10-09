/*
	process new NAC2 collisions
*/
EXPORT ProcessCollisions(DATASET($.Layout_Collisions2.Layout_Collisions) collisions, string version) := FUNCTION
				col1 := Nac_V2.fn_collisions2To1(collisions);	// convert to nac1 format collisions
				$.fn_Despray_DBC1(col1);
				return COUNT(col1);
END;
 