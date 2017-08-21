import ut;

EXPORT DurationApart(STRING8 FromDate , STRING8 ToDate) := FUNCTION

	rDuration := record
		boolean 	failed;
		unsigned2 yrs;
		unsigned1 mons;
		unsigned1 days;
	end;
	
	failed := if( (unsigned)FromDate > (unsigned)ToDate, true, false);				

	FromDate_y := (unsigned)FromDate[1..4];
	ToDate_y := (unsigned)ToDate[1..4];

	ydiff := ToDate_y - FromDate_y;
	yadd:=(string4)(FromDate_y + ydiff) + FromDate[5..8];
	years := ydiff - if( (unsigned)yadd > (unsigned)ToDate, 1, 0);

	tmpFromDate := (string4)(FromDate_y + years) + FromDate[5..8];
	mdiff := ut.MonthsApart(ToDate, tmpFromDate);
	tmpFromDate_y := (unsigned)tmpFromDate[1..4];
	madd := (unsigned)tmpFromDate[5..6] + mdiff;
	adj_tmpFromDate := if(madd > 12, (string4)(tmpFromDate_y + 1) + (string2)(INTFORMAT(madd - 12,2,1)) , (string4)tmpFromDate_y + (string2)(INTFORMAT(madd,2,1))) + (string2)tmpFromDate[7..8];
	mons := mdiff - if( (unsigned)adj_tmpFromDate > (unsigned)ToDate, 1, 0);

	adj_mon := (unsigned)adj_tmpFromDate[5..6] - if( (unsigned)adj_tmpFromDate > (unsigned)ToDate, 1, 0);
	adj_yr:= (unsigned)adj_tmpFromDate[1..4] - 1;	
	tmpFromDate_d :=  if(adj_mon = 0, (string4)adj_yr, (string4)adj_tmpFromDate[1..4]) + if(adj_mon = 0, '12', (string2)(INTFORMAT(adj_mon,2,1))) + (string2)adj_tmpFromDate[7..8];
	days := ut.DaysApart(ToDate, tmpFromDate_d);
	
	duration := if(failed, dataset([{true, 0, 0, 0}], rDuration), dataset([{false, years, mons, days}], rDuration));
	
	return duration;

END;