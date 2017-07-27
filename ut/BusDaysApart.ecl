//Function to calculate number of business days (Monday - Friday) between 2 dates.  d1 and d2 are included ... meaning number of business days between 02/01/2016 and 02/02/2016 = 2 day.
//This function doesn't account for Holidays
IMPORT Std;

EXPORT BusDaysApart(Std.Date.Date_t d1, Std.Date.Date_t d2) := FUNCTION

dateAdjust (Std.Date.Date_t dt):= Std.Date.AdjustDate(dt, day_delta := -Std.Date.DayOfWeek(dt)+1);  	
fullWeeksDays := (integer)(ABS(Std.Date.DaysBetween(dateAdjust(d2),dateAdjust(d1)))/7 ) * 5;
additionalDays := Std.Date.DayOfWeek(d2) - Std.Date.DayOfWeek(d1) + 1 +   if (Std.Date.DayOfWeek(d1) = 1, -1, 0)  +   if (Std.Date.DayOfWeek(d2) = 7, -1, 0);  
busdays := fullWeeksDays  + additionalDays;
		
RETURN busdays; 
END;