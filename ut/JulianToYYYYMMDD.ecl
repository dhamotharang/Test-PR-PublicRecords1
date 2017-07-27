EXPORT STRING8 JulianToYYYYMMDD(REAL JulianDate) :=  
   FUNCTION
      // adapted from an algorithm described here:
      // http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
	    Z := JulianDate + 0.5;
	    W := TRUNCATE((Z - 1867216.25) / 36524.25);
	    X := TRUNCATE(W / 4);
	    A := Z + 1 + W - X;
	    B := A + 1524;
	    C := TRUNCATE((B - 122.1) / 365.25);
	    D := TRUNCATE(365.25 * C);
	    E := TRUNCATE((B - D) / 30.6001);
	    F := TRUNCATE(30.6001 * E);
	    
			DayOfMonth := (INTEGER)B - D - F;
	    Month      := (INTEGER)IF(E<=13,E-1, E-13); 
	    Year       := (INTEGER)IF(Month<3,C-4715,C-4716);

      RetVal := INTFORMAT(Year,4,1) + 
			          INTFORMAT(Month,2,1) + 
						    INTFORMAT(DayOfMonth,2,1);
	RETURN if(JulianDate = 0,'',RetVal); 
END;