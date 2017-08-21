import STD;
EXPORT Layout_Eligibility := RECORD
		string1			eligibility_status_indicator;
		string8			eligibility_status_date;
		string8			eligibility_period_start_raw;
		string8			eligibility_period_end_raw;
		Std.Date.Date_t		eligibility_period_start;
		Std.Date.Date_t		eligibility_period_end;
		integer4		eligible_period_count_days;
		integer4		eligible_period_count_months;
END;