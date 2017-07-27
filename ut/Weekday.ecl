/**
 * Returns the weekday indicated by the given date in the format YYYYMMDD.
 * The date must be in the Gregorian calendar after the year 1600.
 */
IMPORT STD; 

EXPORT string Weekday(unsigned DateIn) := FUNCTION 

  WeekdayNum := STD.Date.dayofweek (DateIn);

  // primitive date validation: should be after 1900, days from [1..31], months from [1..12]
  boolean IsValidDate (unsigned dt) := 
    ((dt div 10000) between 1900 and 9999) AND
    ((dt div 100 % 100) between 1 and 12) AND            
    ((dt % 100) between 1 and 31);
          
	RESULT := IF (IsValidDate (DateIn),
                CASE( WeekdayNum,
								         1 => 'SUNDAY',
                         2 => 'MONDAY',
                         3 => 'TUESDAY',
                         4 => 'WEDNESDAY',
								         5 => 'THURSDAY',
								         6 => 'FRIDAY',
								         'SATURDAY'),
                'INVALID DATE');
  RETURN  RESULT;
END;
