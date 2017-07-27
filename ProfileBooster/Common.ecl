IMPORT Risk_Indicators, UT;

EXPORT Common := MODULE
	
//this works with dates in YYYYMMDD format
EXPORT integer monthsApart_YYYYMMDD(string8 d1, string8 d2, boolean roundUpPartial = false) := FUNCTION
	early := MIN(d1, d2);
	late := MAX(d1, d2);
  yrs := ((integer)late[1..4] - (integer)early[1..4]) * 12;
	months := (integer)late[5..6] - (integer)early[5..6];
  // round up partial month if requested
	partial := if(roundUpPartial and (integer) late[7..8] >= (integer) early[7..8], 1, 0);
	
	RETURN yrs + months + partial;
END;
	
END;