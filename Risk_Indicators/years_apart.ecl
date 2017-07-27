import ut;

// accepts a full 8 byte system date, and will calculate the years for a 4, 6, or 8 byte date2cmpr
export years_apart(unsigned system_date, unsigned date2cmpr) := function
	dt := (string)date2cmpr;
	default_month := '01';
	default_day := '01';
	dt8_adjusted := if(dt[5..8]='0000', dt[1..4]+ default_month + default_day, dt);
	dt6_adjusted := if(dt[5..6]='00', dt[1..4]+default_month, dt);
	date_adjusted := if(length(dt)=6, dt6_adjusted + default_day, dt8_adjusted);
	str_systemdate := (string)system_date;
	days := ut.DaysApart(str_systemdate, date_adjusted);
	days_in_a_year:= 365.25;
	calculated_years_from_days:= days/days_in_a_year;

	just_year := (unsigned)str_systemdate[1..4] - (unsigned)dt[1..4];

	years := map(date2cmpr=0	=> 0,
								length(dt)=4 => just_year,
								calculated_years_from_days);
								
	return (integer)years;  // truncate the years
end;