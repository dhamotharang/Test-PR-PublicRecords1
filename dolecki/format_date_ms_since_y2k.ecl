/*This function returns a string date (kind of the inverse of ms_since_y2k */

import lib_date;

/*Basically this has to deal with positive and negative numbers differently.  It may
	make more sense to have this be 0AD/1BC based rather than 2000AD, but I didn't feel
	like deciding what to call year 0, etc. and since Y2K was such a "big" event, why
	not base the calendar around "the end of civilization" or whatever they called it.
	
	The 2004 in the 2000 & before half makes the calendar zero-based instead of 2000
	being one year after Y2K.  This also works to make 2000 a leap year.
	
	
	THIS CURRENTLY WON'T WORK WITH DATES < Y2K
 */
hack_offset(integer2 year) := 
	IF( year > 2000, 
		(year-2001) div 4 - (year-2001) div 100 + (year-2001) div 400,
		(year-2004) div 4 - (year-2000) div 100 + (year-2000) div 400)
	;

DaysSinceY2K(integer2 year, integer1 month, integer1 day) :=
	(year-2000)*365 + hack_offset(year) + lib_date.DayOfYear(year,month,day);

Layout_Date := RECORD
	integer2 year;
	integer1 month;
	integer1 day;
	integer1 hours;
	integer1 minutes;
	integer2 milliseconds;
END;

//Layout_Date componentize(integer6 ms) := TRANSFORM
//	self.milliseconds := ms % 1000;
	
	
integer6 calculate_year(integer6 days_since_y2k, year_estimate) :=
	IF( days_since_y2k >= DaysSinceY2K(year_estimate, 1, 1),
		IF( days_since_y2k < DaysSinceY2K(year_estimate+1, 1, 1), 
			year_estimate, year_estimate+1),
		year_estimate-1);
	
integer6 calculate_year_start(integer6 days_since_y2k) := FUNCTION
	integer6 year := 2000+(days_since_y2k-hack_offset(2000 + days_since_y2k div 365)) div 365;
	RETURN calculate_year(days_since_y2k, year);
//	RETURN(calculate_year(days_since_y2k, year));
END;

integer1 calculate_month(integer6 days_since_y2k, year) := FUNCTION
	integer1 month := 1 + ((days_since_y2k-DaysSinceY2K(year, 1, 1)) div 30 );
	RETURN(if( days_since_y2k >= DaysSinceY2K(year, month, 1), 
			if( days_since_y2k < DaysSinceY2K(year, month+1, 1), month, month+1 ),
		month-1 ));
END;

STRING map_month_to_string(INTEGER month) := FUNCTION
	return MAP(
		month = 1  => 'JAN',
		month = 2  => 'FEB',
		month = 3  => 'MAR',
		month = 4  => 'APR',
		month = 5  => 'MAY',
		month = 6  => 'JUN',
		month = 7  => 'JUL',
		month = 8  => 'AUG',
		month = 9  => 'SEP',
		month = 10 => 'OCT',
		month = 11 => 'NOV',
		month = 12 => 'DEC',
		'UNK'
	);
END;
		

export QSTRING format_date_ms_since_y2k(integer6 ms) := FUNCTION
	integer2 milliseconds := ms % 1000;
	integer6 seconds_since_y2k := ms div 1000;
	integer1 seconds := seconds_since_y2k % 60;
	integer6 minutes_since_y2k := seconds_since_y2k div 60;
	integer1 minutes := minutes_since_y2k % 60;
	integer6 hours_since_y2k := minutes_since_y2k div 60;
	integer1 hours := hours_since_y2k % 24;
	integer6 days_since_y2k := hours_since_y2k div 24;	//so far, so good
	integer6 year := calculate_year_start(days_since_y2k);
	integer1 month := calculate_month(days_since_y2k, year);
	integer1 day := days_since_y2k - DaysSinceY2k(year, month, 0);
	
	QSTRING formatted := 
//		if( day >= 1 and day <= 31 and month >= 1 and month <= 12 and ms_since_y2k(year, month, day, hours, minutes, seconds, milliseconds) = ms,
			(QSTRING)(
					((STRING)year)+' '+
					//((STRING)month)+' '+
					map_month_to_string(month)+' '+
					((STRING)IF(hours>=0,day,day-1))+' '+	//HACK: fix this above 		TODO:
					((STRING)IF(hours>=0,hours,23+hours))+':'+
					((STRING)IF(minutes>=0,minutes,59+minutes))+':'+
					((STRING)IF(seconds>=0,seconds,59+seconds))+'.'+
					((STRING)IF(milliseconds>=0,milliseconds,1000+milliseconds)))
//			,'failed')
		;
	RETURN(formatted);
END;

