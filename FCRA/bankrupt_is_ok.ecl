import ut;

export bankrupt_is_ok(STRING8 today, STRING8 date_filed, boolean insurance_AZ_filter=false, boolean insurance_fcra_filter=false) := function
	// make an exception for insurance queries for the state of Arizona, only 7 years
	// make an exception for other insurance queries to use 7 years for chapters 7 and 13 
	year_limit := if(insurance_az_filter or insurance_fcra_filter, 7, 10);
	
	filter := ut.DaysApart(today,date_filed) < ut.DaysInNYears(year_limit);

	return filter;
end;