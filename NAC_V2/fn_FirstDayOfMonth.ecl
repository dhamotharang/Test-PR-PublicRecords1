import STD;
EXPORT fn_FirstDayOfMonth(string dt) := 
						(Std.Date.Date_t)IF(LENGTH(TRIM(dt))=6, TRIM(dt)+'01', dt);
