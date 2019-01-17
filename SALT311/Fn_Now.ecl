IMPORT STD;
EXPORT Fn_Now(STRING dt_resolution) := FUNCTION
	nowDate := INTFORMAT(STD.Date.Today(),8,1);
	nowTime := INTFORMAT(STD.Date.CurrentTime(TRUE),6,1);
	nowDateTime := nowDate + nowTime;
	
	nowUse := MAP(dt_resolution = 'YYYYMMDDHHMMSS' => nowDateTime,
								dt_resolution = 'YYYYMM' => nowDate[1..6],
								nowDate);							
  RETURN nowUse;								
END;
