IMPORT lib_date;

EXPORT Mod_Y2K := MODULE

	EXPORT SET OF QSTRING3 months := 
			['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
			
	EXPORT UNSIGNED1 num_month(QSTRING3 month) := MAP(
		month = months[1] => 1,
		month = months[2] => 2,
		month = months[3] => 3,
		month = months[4] => 4,
		month = months[5] => 5,
		month = months[6] => 6,
		month = months[7] => 7,
		month = months[8] => 8,
		month = months[9] => 9,
		month = months[10] => 10,
		month = months[11] => 11,
		month = months[12] => 12,
		0);
		
//	EXPORT ms_per_year   := ;
	EXPORT ms_per_day    := 86400000;
	EXPORT ms_per_hour   := 3600000;
	EXPORT ms_per_minute := 60000;
	EXPORT ms_per_second := 1000;


	/*This function returns the number of milliseconds since Y2K.  This function should
	 *store up to +-4500 years (2500 B.C to 6500 A.D.) so that should not be a limiting 
	 *factor in the forseeable future.
	 *
	 *INPUTS:
	 *Year A.D. (B.C. can be included if correctly calibrated to A.D.)
	 *Month 1-12
	 *Day 1-last_day_of_month
	 *Hour 0-23
	 *Minutes 0-59
	 *Seconds 0-59
	 *Milliseconds 0-999
	 *
	 *OUTPUT:
	 *INTEGER6 representing milliseconds since 1 Jan 2000 00:00:00.000
	 *
	 *CAVEATS:
	 *no bounds checking
	 */

	/*Basically this has to deal with positive and negative numbers differently.  It may
		make more sense to have this be 0AD/1BC based rather than 2000AD, but I didn't feel
		like deciding what to call year 0, etc. and since Y2K was such a "big" event, why
		not base the calendar around "the end of civilization" or whatever they called it.
		
		The 2004 in the 2000 & before half makes the calendar zero-based instead of 2000
		being one year after Y2K.  This also works to make 2000 a leap year.
	 */
	SHARED INTEGER2 hack_offset(INTEGER2 year) := 
		IF( year > 2000, 
			(year-2001) div 4 - (year-2001) div 100 + (year-2001) div 400,
			(year-2004) div 4 - (year-2000) div 100 + (year-2000) div 400)
		;

	EXPORT INTEGER2 DaysSinceY2K(INTEGER2 year, UNSIGNED1 month, UNSIGNED1 day) :=
		(year-2000)*365 + hack_offset(year) + lib_date.DayOfYear(year,month,day);

	EXPORT INTEGER6 ms_since_y2k(INTEGER2 year, UNSIGNED1 month, UNSIGNED1 day, 
			UNSIGNED1 hours, UNSIGNED1 minutes, UNSIGNED1 seconds, UNSIGNED2 milliseconds) :=
		DaysSinceY2K(year, month, day) * ms_per_day 
			+ hours * ms_per_hour + minutes * ms_per_minute + seconds * ms_per_second + milliseconds;
	
	SHARED INTEGER2 calculate_year(INTEGER2 days_since_y2k, year_estimate) :=
		IF( days_since_y2k >= DaysSinceY2K(year_estimate, 1, 1),
			IF( days_since_y2k < DaysSinceY2K(year_estimate+1, 1, 1), 
				year_estimate, year_estimate+1),
			year_estimate-1);
	
	SHARED INTEGER2 calculate_year_start(integer6 days_since_y2k) := FUNCTION
		INTEGER6 year := 2000+(days_since_y2k-hack_offset(2000 + days_since_y2k div 365)) div 365;
		RETURN calculate_year(days_since_y2k, year);
	END;

	SHARED UNSIGNED1 calculate_month(INTEGER2 days_since_y2k, year) := FUNCTION
		UNSIGNED1 month := 1 + ((days_since_y2k-DaysSinceY2K(year, 1, 1)) div 30 );
		RETURN(if( days_since_y2k >= DaysSinceY2K(year, month, 1), 
				if( days_since_y2k < DaysSinceY2K(year, month+1, 1), month, month+1 ),
			month-1 ));
	END;
/*
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
*/		

SHARED STRING padded(INTEGER num, UNSIGNED pad, String char='0') := FUNCTION
	STRING temp0 := (STRING)num;
	STRING temp1 := IF(length(temp0) < pad, char+temp0, temp0);
	STRING temp2 := IF(length(temp1) < pad, char+temp1, temp1);
	STRING temp3 := IF(length(temp2) < pad, char+temp2, temp2);
	STRING temp4 := IF(length(temp3) < pad, char+temp3, temp3);
	STRING temp5 := IF(length(temp4) < pad, char+temp4, temp4);
	STRING temp6 := IF(length(temp5) < pad, char+temp5, temp5);
	RETURN temp6;
END;

/*	This function returns a string date (kind of the inverse of ms_since_y2k).
	This function IS NOT THOROUGHLY IMPLEMENTED, use at your own ris.
	It seems to give good results for the range I have looked at (2006-2007).
*/

export QSTRING format_date(integer6 ms) := FUNCTION
	UNSIGNED2 milliseconds := ms % 1000;
	integer6 seconds_since_y2k := ms div 1000;
	UNSIGNED1 seconds := seconds_since_y2k % 60;
	integer6 minutes_since_y2k := seconds_since_y2k div 60;
	UNSIGNED1 minutes := minutes_since_y2k % 60;
	integer6 hours_since_y2k := minutes_since_y2k div 60;
	UNSIGNED1 hours := hours_since_y2k % 24;
	integer6 days_since_y2k := hours_since_y2k div 24;	//so far, so good
	INTEGER2 year := calculate_year_start(days_since_y2k);
	UNSIGNED1 month := calculate_month(days_since_y2k, year);
	UNSIGNED1 day := days_since_y2k - DaysSinceY2k(year, month, 0);
	
	QSTRING formatted := 
//		if( day >= 1 and day <= 31 and month >= 1 and month <= 12 and ms_since_y2k(year, month, day, hours, minutes, seconds, milliseconds) = ms,
			(QSTRING)(
					((STRING)year)+'-'+
					months[month]+'-'+
					padded(IF(hours>=0,day,day-1), 2)+' '+	//HACK: fix this above 		TODO:
					padded(IF(hours>=0,hours,23+hours), 2)+':'+
					padded(IF(minutes>=0,minutes,59+minutes), 2)+':'+
					padded(IF(seconds>=0,seconds,59+seconds), 2)+'.'+
					padded(IF(milliseconds>=0,milliseconds,1000+milliseconds), 3))
//			,'failed')
			;
		RETURN(formatted);
	END;
				
/*	This function returns a string date (kind of the inverse of ms_since_y2k).
	This function IS NOT THOROUGHLY IMPLEMENTED, use at your own ris.
	It seems to give good results for the range I have looked at (2006-2007).
*/

export QSTRING format_date_original(integer6 ms) := FUNCTION
	UNSIGNED2 milliseconds := ms % 1000;
	integer6 seconds_since_y2k := ms div 1000;
	UNSIGNED1 seconds := seconds_since_y2k % 60;
	integer6 minutes_since_y2k := seconds_since_y2k div 60;
	UNSIGNED1 minutes := minutes_since_y2k % 60;
	integer6 hours_since_y2k := minutes_since_y2k div 60;
	UNSIGNED1 hours := hours_since_y2k % 24;
	integer6 days_since_y2k := hours_since_y2k div 24;	//so far, so good
	INTEGER2 year := calculate_year_start(days_since_y2k);
	UNSIGNED1 month := calculate_month(days_since_y2k, year);
	UNSIGNED1 day := days_since_y2k - DaysSinceY2k(year, month, 0);
	
	QSTRING formatted := 
//		if( day >= 1 and day <= 31 and month >= 1 and month <= 12 and ms_since_y2k(year, month, day, hours, minutes, seconds, milliseconds) = ms,
			(QSTRING)(
					months[month]+' '+
					padded(IF(hours>=0,day,day-1), 2, ' ')+' '+	//HACK: fix this above 		TODO:
					padded(IF(hours>=0,hours,23+hours), 2)+':'+
					padded(IF(minutes>=0,minutes,59+minutes), 2)+':'+
					padded(IF(seconds>=0,seconds,59+seconds), 2)+'.'+
					padded(IF(milliseconds>=0,milliseconds,1000+milliseconds), 3))
//			,'failed')
			;
		RETURN(formatted);
	END;

END;