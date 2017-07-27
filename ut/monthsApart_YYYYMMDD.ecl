//this works with dates in YYYYMMDD format
// JIRA https://track.hpccsystems.com/browse/HPCC-16520
export integer monthsApart_YYYYMMDD(string8 d1, string8 d2, boolean roundUpPartial = false) := FUNCTION
	early := MIN(d1, d2);
	late := MAX(d1, d2);
  yrs := ((integer)late[1..4] - (integer)early[1..4]) * 12;
	months := (integer)late[5..6] - (integer)early[5..6];
  // round up partial month if requested
	partial := if(roundUpPartial and (integer) late[7..8] > (integer) early[7..8], 1, 0);
	
	return yrs + months + partial;
end :DEPRECATED('Use Std.Date.MonthsBetween Instead'); 