EXPORT REAL YYYYMMDDtoJulian(STRING8 IncomingDate) := 
   FUNCTION
      //  adapted from an algorithm described here:
      //  http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
      Year    := (INTEGER)IncomingDate[1..4];
			Month   := (INTEGER)IncomingDate[5..6]; 
			Day     := (INTEGER)IncomingDate[7..8];
			
			A       := TRUNCATE(Year/100);
			B       := TRUNCATE(A/4);
			C       := TRUNCATE(2-A+B);

      E       := TRUNCATE(365.25 * (Year+4716));
      F       := TRUNCATE(30.6001 * (Month+1));
 
      // I found two issues (one needing two solutions) with the algorighm at the website above
			// First: when the Month/Day is 2/29 (a leap year) the result from the algorithm 
			// is off by two.  
			// Second: When the Month/Day is 1/1 -- There are two condition fixes needed  
			//         1) If the year is evenly divisible by four - the julian date is off by 1 
			//         2) If the year is not evenly divisible by four - the julian date is off by 2
			// The following corrects both of these.
			JulianDate := C + Day + E + F - MAP(
			    Month = 2 AND Day = 29    => 1522.5,   // leap year
			    Month > 1 OR Day > 1      => 1524.5,   // not Jan 1 of any year
					Year % 4 = 0              => 1523.5,   // Jan 1 divisible by 4
					/* default */                1522.5 );
     
      RETURN IF(IncomingDate = '', 0, JulianDate);
END;

