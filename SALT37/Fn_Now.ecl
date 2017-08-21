IMPORT STD;
EXPORT Fn_Now(STRING dt_resolution) := FUNCTION
	nowDate := (STRING)STD.Date.Today();
	nowTime := (STRING)STD.Date.CurrentTime(TRUE);
	nowDateTime := nowDate + nowTime;
	
	nowUse := MAP(dt_resolution = 'YYYYMMDDHHMMSS' => nowDateTime,
								dt_resolution = 'YYYYMM' => nowDate[1..6],
								nowDate);							
  RETURN nowUse;								
END;