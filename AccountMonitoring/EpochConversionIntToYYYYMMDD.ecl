IMPORT ut;

EXPORT STRING8 EpochConversionIntToYYYYMMDD( UNSIGNED IncomingDateToConvert ) := 
   FUNCTION
      // This function uses January 1, 1901 as the Epoch date for all calculations
			// As the code is written now -- this will break in the year: 2100.  
			// The general algorithm (there are comments where the code compensates for oddities):  
			// dividing the integer coming in by 365.25 gives the number of years the 
			// incoming date is from the epoch, in this attribute it's Jan 1, 1901. The .25 accounts for the 
			// additional day in leap years.  Adding the calculated years from the epoch to the epoch, give 
			// the year for the date. Taking the number of years and multiplying by 365.25 gives the number of 
			// days contained in that many years. MonthCounter is the incoming integer date less the number of 
			// days calculated for the number of years from the epoch date.  There are two checks that need to be 
			// done for this: first to find out what month the remaining number of days falls in.  That check is 
			// done in ReturnMonth (which simply maps the number of remaining days to the min/max number of days 
			// from Jan 1 to that particular month. The second is to subtract the number of days calculated 
			// from Jan 1 to the month PRIOR to the calculated month. The reason for that: the difference becomes 
			// number of days for the returned date.
			// See full example below function.
			// Exceptions: 
			//   1) Every 100 years is a non-leap year, except when divisible by 400. See comment below function.
			//   2) Dec 31 of a leap year -- code adjustment fixes this issue. See comments by Dec31LeapYrCk 
			
			UNSIGNED YearsSince1901      := TRUNCATE( IncomingDateToConvert/365.25 );
			UNSIGNED DaysInYrsSince1901  := TRUNCATE( (YearsSince1901 * 365.25));
		  UNSIGNED ReturnYear          := YearsSince1901 + 1901;
			UNSIGNED FebDaysForInputYear := IF( ut.LeapYear(ReturnYear), 29, 28 );

			// The next 2 lines are used to determine if 365.25 evenly divides into the input integer. 
			// Since there is no mod for an integer div real, if you truncate the division and then multiply
			// again by the 365.25, then subtract -- if the result is 0, 365.25 is an even divisor.
 			// If the result is 0, then the input integer date is December 31st of a leap year. When 365.25 evenly
			// divides into the input number, the year as would be calculated is one year ahead of what it
			// should be (which is why Dec31LeapYr adds: incomingDateToConvert / 365.25  + 1900 instead of 1901.  
			// For example: 40908 / 365.25 = 2013 -- the correct date is: 20121231 
			UNSIGNED Dec31LeapYrCk := TRUNCATE (YearsSince1901 * 365.25);
			Dec31LeapYear          := IncomingDateToConvert - Dec31LeapYrCk;
      UNSIGNED Dec31LeapYr   := IncomingDateToConvert / 365.25 + 1900;

			UNSIGNED MonthCounter := IncomingDateToConvert - DaysInYrsSince1901;
																				
			// Once the number of days in the Number of years since the Epoch has been removed from the 
			// incoming Epoch date, the ReturnMonth is the month in which the remaining days falls.  For
			// example:  If the remaining days is 5, then the month would be January (1).  If the number of 
			// days remaining is 360, then the month would be December (12).
			ReturnMonth := MAP ( MonthCounter BETWEEN   0  AND  31   => 1,
													 MonthCounter BETWEEN  32  AND (31 + FebDaysForInputYear) => 2,
													 MonthCounter BETWEEN (32 + FebDaysForInputYear)  AND (62 + FebDaysForInputYear)  =>  3, 
													 MonthCounter BETWEEN (63 + FebDaysForInputYear)  AND (92 + FebDaysForInputYear)  =>  4, 
													 MonthCounter BETWEEN (93 + FebDaysForInputYear)  AND (123 + FebDaysForInputYear) =>  5,
													 MonthCounter BETWEEN (124 + FebDaysForInputYear) AND (153 + FebDaysForInputYear) =>  6,
													 MonthCounter BETWEEN (154 + FebDaysForInputYear) AND (184 + FebDaysForInputYear) =>  7,
													 MonthCounter BETWEEN (185 + FebDaysForInputYear) AND (215 + FebDaysForInputYear) =>  8,
													 MonthCounter BETWEEN (216 + FebDaysForInputYear) AND (245 + FebDaysForInputYear) =>  9,
													 MonthCounter BETWEEN (246 + FebDaysForInputYear) AND (276 + FebDaysForInputYear) => 10,
													 MonthCounter BETWEEN (276 + FebDaysForInputYear) AND (306 + FebDaysForInputYear) => 11,
													                    /*(307 + FebDaysForInputYear) AND (337 + FebDaysForInputYear)*/  12
												 );		

			// DaysInMonths determines the number of days from Jan 1 through the month prior to the 
			// entered month.  If the entered month is 1, 0 days is returned because the date
			// will only have to account for the number of days in Jan which is handled separately.
			DaysToPrevMonth := CASE( ReturnMonth,
			                         1  => 0,
													     2  => 31,
													     3  => 31 + FebDaysForInputYear, 
													     4  => 62 + FebDaysForInputYear, 
													     5  => 92 + FebDaysForInputYear,
													     6  => 123 + FebDaysForInputYear,
													     7  => 153 + FebDaysForInputYear,
													     8  => 184 + FebDaysForInputYear,
													     9  => 215 + FebDaysForInputYear,
													     10 => 245 + FebDaysForInputYear,
													     11 => 276 + FebDaysForInputYear,
													           306 + FebDaysForInputYear
												     );	
													
      // The Day to return (ReturnDay) simply becomes: 
			// InputEpoch date - DaysInYrsSince1901 - DaysInMonth (or MonthCounter - DaysToPrevMonth)
			// (The number of days since the Epoch date minus the number of days in the number of years 
			//  calculated from the Epoch minus the days from Jan 1 to the month prior to the month returned
			ReturnDay := MonthCounter - DaysToPrevMonth;			
      
      
			// Format Date into string. The first part of this IF checks to see if the date is Dec 31 of a leap year
			// explaination is above.
			RetDate   := IF( Dec31LeapYear = 0,
			                 INTFORMAT((Dec31LeapYr),4,1) + 
			                 INTFORMAT(12,2,1) + 
						           INTFORMAT(31,2,1),
									     INTFORMAT(ReturnYear,4,1) + 
			                 INTFORMAT(ReturnMonth,2,1) + 
						           INTFORMAT(ReturnDay,2,1)
										 );													 
			
			RETURN IF( IncomingDateToConvert < 0, '', RetDate);
END;
/* 
Example:  Input integer date: 39184  (20080412) 
YearsSince1901 = 107 (truncate(39184 / 365.25) = 107.27994524...
ReturnYear = 2008 (1901 + 107) 
MonthCounter = 103 (39184 - 39081) =>(truncate(39081 = 107 * 365.25))
ReturnMonth = 4 (monthCounter (103) is between 92 & 120)
ReturnDay = 12 (103 - 91) (( 91 = number of days from Jan 1 to April 30 (62+29))) 
*/

// This function still needs to account for the following starting Feb 28th, 2100:

// Compensating for leap year:  
// In the Gregorian calendar, the current standard calendar in most of the world, 
// most years that are evenly divisible by 4 are leap years. In each leap year, the 
// month of February has 29 days instead of 28. Adding an extra day to the calendar 
// every four years compensates for the fact that a period of 365 days is shorter 
// than a solar year by almost 6 hours.  However, some exceptions to this rule are 
// required since the duration of a solar year is slightly less than 365.25 days. 
// Years that are evenly divisible by 100 are not leap years, unless they are also 
// evenly divisible by 400, in which case they are leap years.

/*  I discovered you can code a fix to the leap year issue (post 2099) by implementing the following:
   YrMod400 := Yr % 400;
	 YrDiv400 := TRUNCATE (Yr / 400);
	 
	 NumNonLeapsToRemove := Case (YrMod400,
	                                0  => 0,
																 .25 => 1,
																 .5  => 2,
																 .75 => 3);
																
	 Calculated days becomes := Days - (( ( YrDiv400 - 5) * 3) + NumNonLeapsToRemove );
	  
	 Data:
	                                             |  Additional  | ((YrDiv400 - 5)* 3) +  
																							 | numNonleaps  |   NumNonLeapsToRemove
	 Year    |  Yr/400 | Yr % 400 | YrDiv400 - 5 | ToRemove     |Total To remove 
	 2100    |  5.25   |  .25     |   0          |   1          |  1
   2200    |  5.5    |  .5      |   0          |   2          |  2
   2300    |  5.75   |  .75     |   0          |   3          |  3
	 2400    |  6      |  0       |   1          |   0          |  3 -- Leap year
	 2500    |  6.25   |  .25     |   1          |   1          |  4
	 2600    |  6.5    |  .5      |   1          |   2          |  5
	 2700    |  6.75   |  .75     |   1          |   3          |  6
	 2800    |  7      |  0       |   2          |   0          |  6 -- Leap year
	 2900    |  7.25   |  .25     |   2          |   1          |  7
	 3000    |  7.5    |  .5      |   2          |   2          |  8
	 3100    |  7.75   |  .75     |   2          |   3          |  9
	 3200    |  8      |  0       |   3          |   0          |  9 -- Leap year
	 3300    |  8.25   |  .25     |   3          |   1          |  10
	 3400    |  8.5    |  .5      |   3          |   2          |  11
	 3500    |  8.75   |  .75     |   3          |   3          |  12
	 3600    |  9      |  0       |   4          |   0          |  12 -- Leap year
	 5200    |  13     |  0       |   8          |   0          |  24 -- Leap year
*/