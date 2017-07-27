IMPORT ut;
EXPORT INTEGER EpochConversionYYYYMMDDToInt ( STRING8 IncomingDate ) := 
   FUNCTION 
      // This function uses January 1, 1901 as the Epoch date
			// As the code is written now -- this will break in the year: 2100.  See comments below 
			// function to help adjust for the infrequent "non-leap" years.
			// Basic algorithm:
			// Glean the Year/Month/Day from the string and put set to integer variables
			// Determine if year is leap year
			// Multiply the # of years from Epoch date * 365.25 (the .25 accounts for leap years),
			// Add the that total, the number of days to the month prior to the incoming month and the 
			// number of days in the incoming month.
			// See comment under function for example.
      Year    := (INTEGER)IncomingDate[1..4];
			Month   := (INTEGER)IncomingDate[5..6]; 
			Day     := (INTEGER)IncomingDate[7..8];

			FebDaysForInputYear := IF( ut.LeapYear(Year), 29, 28);
			// DaysInMonths calculates the number of days from Jan 1 to the month prior to the 
			// entered month.  If the entered month is 1, 0 days is returned because the date
			// will only have to account for the number of days in Jan which is handled separately.
			DaysInMonths := CASE( Month,
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
													 
			YearsSince1901 := Year-1901;
		  INTEGER DaysInYearsSince1901  := TRUNCATE(YearsSince1901*365.25);
			INTEGER TotalDaysSince1901    := DaysInYearsSince1901 + DaysInMonths + Day;
			
      RETURN IF(IncomingDate = '', 0, TotalDaysSince1901);
END;
/*
EXAMPLE: String date input: 20080412
Yr := 2008  Month := 04  Day := 12  FebDays := 29
DaysSince1901 :=  39081 =>  Truncate((2008 - 1901)*365.25) ((39081.75))
TotalDays := 39184  => (DaysSince1901 + DaysInMonth + Day)
                           39081      +   62 + 29   + 12
*/

// Compensating for leap year:  
// In the Gregorian calendar, the current standard calendar in most of the world, 
// most years that are evenly divisible by 4 are leap years. In each leap year, the 
// month of February has 29 days instead of 28. Adding an extra day to the calendar 
// every four years compensates for the fact that a period of 365 days is shorter 
// than a solar year by almost 6 hours.  However, some exceptions to this rule are 
// required since the duration of a solar year is slightly less than 365.25 days. 
// Years that are evenly divisible by 100 are not leap years, unless they are also 
// evenly divisible by 400, in which case they are leap years.
// For more details on how to compensate for this, see comments at the end of:
// EpochConversionIntToYYYYMMDD 
