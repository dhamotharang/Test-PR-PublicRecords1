import ut;

//function that filters out records older than 7 years
export fn_date_is_ok(STRING8 today, STRING8 date_filed, unsigned1 year_limit=7) := function
	
	keepDate := ut.DaysApart(today,date_filed) < ut.DaysInNYears(year_limit);

	return keepDate; //true or false
end;