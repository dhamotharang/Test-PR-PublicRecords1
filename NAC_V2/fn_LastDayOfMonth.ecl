import STD;
EXPORT fn_LastDayOfMonth(string dt) := 
				(Std.Date.Date_t)IF(LENGTH(TRIM(dt))=6, TRIM(dt) + nac_v2.DaysInMonth(dt), dt);