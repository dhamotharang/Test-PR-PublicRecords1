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

import lib_date;

/*Basically this has to deal with positive and negative numbers differently.  It may
	make more sense to have this be 0AD/1BC based rather than 2000AD, but I didn't feel
	like deciding what to call year 0, etc. and since Y2K was such a "big" event, why
	not base the calendar around "the end of civilization" or whatever they called it.
	
	The 2004 in the 2000 & before half makes the calendar zero-based instead of 2000
	being one year after Y2K.  This also works to make 2000 a leap year.
 */
hack_offset(integer2 year) := 
	IF( year > 2000, 
		(year-2001) div 4 - (year-2001) div 100 + (year-2001) div 400,
		(year-2004) div 4 - (year-2000) div 100 + (year-2000) div 400)
	;

DaysSinceY2K(integer2 year, integer1 month, integer1 day) :=
	(year-2000)*365 + hack_offset(year) + lib_date.DayOfYear(year,month,day);

export INTEGER6 ms_since_y2k(integer2 year, integer1 month, integer1 day, 
		integer1 hours, integer1 minutes, integer1 seconds, integer2 milliseconds) :=
  DaysSinceY2K(year, month, day) * 86400000 
			+ hours * 3600000 + minutes * 60000 + seconds * 1000 + milliseconds;