// returns boolean for provided date (YYYYMMDD) being in Daylight Savings Time
// based on second Sunday in March and First Sunday in November rules.


export isDaylightTime(string d) := function
	day := (unsigned1) (d[7..8]);

	month := (unsigned1) (d[5..6]);

	unsigned1 dayofweek := ut.DaysSince1900(d[1..4],d[5..6],d[7..8]) % 7;

	
	return MAP( month >= 4 and month <= 10 			=> TRUE,
		          month = 12 or month <= 2 				=> FALSE,
							month = 11 => MAP(day > 6 						=> FALSE,
							                  day - dayofweek > 0 => FALSE,
																TRUE),
							MAP( day > 13 							=> TRUE,
							     day < 8 								=> FALSE,
									 day-7 - dayofweek > 0 	=> TRUE,
									 FALSE ) );
end;