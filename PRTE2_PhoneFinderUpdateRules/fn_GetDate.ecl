IMPORT std;

EXPORT fn_GetDate := MODULE
	
		//IMPORTANT:  This is used for an error message.  Please update the dataset if the list of valid override rules is modified
		rec := {STRING override_rule};
		EXPORT valid_override_rules := DATASET([
																																										{'current_date_monthly'},
																																										{'current_date_minus_10_monthly'},
																																										{'current_date_minus_45_monthly'},
																																										{'current_date_minus_75_monthly'},
																																										{'current_date'},
																																										{'static_date_20050101'},
																																										{'static_date_20140101'},
																																										{''}
																																										], rec);

			EXPORT current_date := std.date.currentdate(false);  //UTC
			EXPORT current_time 	:= STD.Date.CurrentTime(false); //UTC

			EXPORT current_day 	:= std.date.day(current_date);
			
			EXPORT current_date_string := (string8) current_date;
			EXPORT current_date_minus_10_days := (string8) std.Date.AdjustDate(current_date, 0, 0 ,-10);
			EXPORT current_date_minus_45_days := (string8) std.Date.AdjustDate(current_date, 0, 0 ,-45);
			EXPORT current_date_minus_75_days := (string8) std.Date.AdjustDate(current_date, 0, 0 ,-75);
			
			EXPORT static_date_20050101 := '20050101';
			EXPORT static_date_20140101 := '20140101';
	
			EXPORT OverrideDate (string override_rule, string8 default_date, UNSIGNED1 monthly_update_day = 1) := FUNCTION
						return_date := 
									//IMPORTANT:  Update the valid_override_rules definition above if the list of valid override rules is modified
								CASE (trim(override_rule),
													//override date once a month
													'current_date_monthly' => if(current_day = monthly_update_day, current_date_string, default_date), 
													'current_date_minus_10_monthly' => if(current_day = monthly_update_day, current_date_minus_10_days, default_date),
													'current_date_minus_45_monthly' => if(current_day = monthly_update_day, current_date_minus_45_days, default_date), 
													'current_date_minus_75_monthly' => if(current_day = monthly_update_day, current_date_minus_75_days, default_date), 													
													//override date every build
													'current_date' => current_date_string, 
													'static_date_20050101' => static_date_20050101,
													'static_date_20140101' => static_date_20140101,
													'' => default_date,
													'RULE NOT FOUND'); //otherwise don't override the date, just pass back what was passed into the function
									
									IF(return_date='RULE NOT FOUND',
											FAIL('Date override rule: "' + override_rule + '" was not found in PRTE2_PhoneFinderUpdate.fn_GetDate.OverrideDate.  Please check the data or modify the function to account for the new value. '));
													
						RETURN return_date;
			END;						
			
END;

