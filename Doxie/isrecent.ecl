import ut, header;

// This function will check if the specified date is considered 'recent' based on the number of months allowed.
export boolean isrecent(
												string8 	date, 											// the date to be checked
												integer2 	monthsallowed, 							// number of months allowed (max 12 allowed)
												boolean 	checkheaderlastseen = true, // uses max header date last seen as the baseline instead of today's date
												boolean 	isFCRA = false
											 ) :=
function
	
	integer nMonths(string8 dt) := ((unsigned2)(dt[1..4])*12) + ((unsigned2)(dt[5..6]));	
	nmonths_maxseen := nMonths(header.MaxHeaderDateLastSeen(isFCRA));
	nmonths_today 	:= nMonths(ut.GetDate);	
	// use either today's date or header build date.
	nmonths_base_dt := if(checkheaderlastseen, nmonths_maxseen-min(monthsallowed,12), nmonths_today-min(monthsallowed,12));	// allowing a max of 12 months which is what the previous code was allowing. 
	nmonths_dt 			:= nMonths(date);
	return nmonths_dt >= nmonths_base_dt;
	
end;
