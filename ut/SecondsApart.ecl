/* ***************************************************************************************************
 Given two DateTimes in YYYYMMDDHHMMSS format this function will calculate the total number of seconds 
 that the two DateTimes are apart.  It does so using the number of ut.DaysApart since the Epoch.
 *****************************************************************************************************/
/********************************* Brenton Pahl - 10/30/2013 *****************************************/

EXPORT UNSIGNED6 SecondsApart (STRING14 DateTime1, STRING14 DateTime2) := FUNCTION
	secondsPerMinute := 60;
	secondsPerHour := 3600;
	secondsPerDay := 86400;
	Epoch := '19000101';
	
	daysApart1 := ut.DaysApart(DateTime1[1..8], Epoch);
	daysApart2 := ut.DaysApart(DateTime2[1..8], Epoch);
	
	seconds1 := ((UNSIGNED)daysApart1 * secondsPerDay) + // Seconds in the days apart since Epoch (YYYYMMDD)
							((UNSIGNED)DateTime1[9..10] * secondsPerHour) + // Seconds in the hours
							((UNSIGNED)DateTime1[11..12] * secondsPerMinute) + // Seconds in the minutes
							((UNSIGNED)DateTime1[13..14]); // Seconds in the seconds

	seconds2 := ((UNSIGNED)daysApart2 * secondsPerDay) + // Seconds in the days apart since Epoch (YYYYMMDD)
							((UNSIGNED)DateTime2[9..10] * secondsPerHour) + // Seconds in the hours
							((UNSIGNED)DateTime2[11..12] * secondsPerMinute) + // Seconds in the minutes
							((UNSIGNED)DateTime2[13..14]); // Seconds in the seconds
	
	// Don't run the calculation if the same datetimes were passed in...
	difference := IF(DateTime1 = DateTime2, 0, ABS(seconds2 - seconds1));
	
	RETURN(difference);
END;

/* *****************************************
Test Calculations:

// Here is how to get the runtime DateTime in YYYYMMDDHHMMSS format
RealtimeTemp := ut.GetTimeDate();
Realtime := RealtimeTemp[1..4] + RealtimeTemp [6..7] + RealtimeTemp [9..16];

// Test DateTimes
myTime1 := '20131030142955'; // 0 seconds between this and myTime1
myTime2 := '20131030142954'; // 1 second between this and myTime1
myTime3 := '20131030142855'; // 60 seconds between this and myTime1
myTime4 := '20131029142955'; // 86400 seconds between this and myTime1
myTime5 := '20130930142955'; // 2592000 seconds between this and myTime1
myTime6 := '20121030142955'; // 31536000 seconds between this and myTime1
myTime7 := '20090108015540'; // 151763655 seconds between this and myTime1


secondsApart1 := ut.SecondsApart(myTime1, myTime1);
secondsApart2 := ut.SecondsApart(myTime1, myTime2);
secondsApart3 := ut.SecondsApart(myTime1, myTime3);
secondsApart4 := ut.SecondsApart(myTime1, myTime4);
secondsApart5 := ut.SecondsApart(myTime1, myTime5);
secondsApart6 := ut.SecondsApart(myTime1, myTime6);
secondsApart7 := ut.SecondsApart(myTime1, myTime7);

OUTPUT(secondsApart1, NAMED('a0'));
OUTPUT(secondsApart2, NAMED('a1'));
OUTPUT(secondsApart3, NAMED('a60'));
OUTPUT(secondsApart4, NAMED('a86400'));
OUTPUT(secondsApart5, NAMED('a2592000'));
OUTPUT(secondsApart6, NAMED('a31536000'));
OUTPUT(secondsApart7, NAMED('a151763655'));
********************************************/