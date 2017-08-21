IMPORT STD; 
EXPORT GetTimeStamp () := FUNCTION 
 
     TimeSecs        := Std.Date.CurrentTimestamp(true) DIV 1000000 ;
     TimeSecsStr     := Std.Date.SecondsToString(TimeSecs, '%H%M%S');
     TimeFraction    := TimeSecs % 1000000;

RETURN  TimeSecsStr + TimeFraction; 
 
END;
