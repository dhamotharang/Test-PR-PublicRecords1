export Mod_Data_Util := MODULE

	/* IMPORTANT: use log base 10 below so we can filter in the log space */
	
	EXPORT log_min_mean := min(Mod_Data.DS_StdDev, log_mean);
	EXPORT log_max_stdev := max(Mod_Data.DS_StdDev, log_stdev);

	EXPORT UNSIGNED2 translate_mean_to_x(REAL8 mean) := 
			truncate((log(mean)-log_min_mean)*1024);
			
	EXPORT REAL8 translate_x_to_log_mean(UNSIGNED2 x) :=
			((REAL8)x/1024)+log_min_mean;
					
	EXPORT REAL8 translate_x_to_mean(UNSIGNED2 x) :=
			power(10, translate_x_to_log_mean(x));
			
	EXPORT INTEGER2 translate_to_y(REAL8 mean, REAL8 stdev) :=
			truncate((log(mean)-log(stdev))*100);
			
	EXPORT UNSIGNED2 translate_stdev_to_y(REAL8 stdev) :=
			truncate((log_max_stdev-log(stdev))*1024);

	EXPORT REAL8 translate_y_to_log_stdev(UNSIGNED2 y) :=
			log_max_stdev+((REAL8)y/1024);

	EXPORT REAL8 translate_y_to_stdev(UNSIGNED2 y) :=
			power(10, translate_y_to_log_stdev(y));
			
	EXPORT INTEGER4 ms_per_day := Mod_Y2K.ms_per_day; // := 1000*60*60*24;
	export INTEGER4 f_tod(INTEGER6 ms) := 
		(INTEGER4)(IF( ms < 0, ms_per_day-ms, ms)) % ms_per_day;		
		
	SHARED STRING year := '([0-9]{4})';
	SHARED STRING mm := '([0-9]{1,2})';
	SHARED STRING dd := '([0-9]{1,2})';
	SHARED STRING yyyy_mm_dd := year+'_'+mm+'_'+dd;
			
//	output(stop_month+'/'+stop_day+'/'+stop_year);
	
	EXPORT INTEGER6 translate_date(String date, INTEGER6 fallback) := FUNCTION
		start_year := REGEXFIND(yyyy_mm_dd, date, 1);
		start_month := REGEXFIND(yyyy_mm_dd, date, 2);
		start_day := REGEXFIND(yyyy_mm_dd, date, 3);
		valid_start := start_year <> '' AND start_month <> '' AND start_day <> '' AND 
				(UNSIGNED)start_month BETWEEN 1 AND 12 AND (UNSIGNED)start_day BETWEEN 1 AND 31;
	
		RETURN IF(valid_start, 
			MOD_Y2K.ms_since_y2k((INTEGER2)start_year,(INTEGER1)start_month,(INTEGER1)start_day,0,0,0,0),
			fallback);
	END;
/*		
	EXPORT INTEGER6 stop(String date, INTEGER6 fallback) := FUNCTION
		stop_year := REGEXFIND(yyyy_mm_dd, date, 1);
		stop_month := REGEXFIND(yyyy_mm_dd, date, 2);
		stop_day := REGEXFIND(yyyy_mm_dd, date, 3);
		valid_stop := stop_year <> '' AND stop_month <> '' AND stop_day <> '' AND 
				(UNSIGNED)stop_month BETWEEN 1 AND 12 AND (UNSIGNED)stop_day BETWEEN 1 AND 31;
	
		RETURN IF(valid_stop, 
			Mod_Y2K.ms_since_y2k((INTEGER2)stop_year, (INTEGER1)stop_month, (INTEGER1)stop_day, 23, 59, 59, 999),
			fallback);
	END;
*/		

END;