Import Healthcare_Shared,mprd,std;
	
export Functions_AddrMeta := module

	// calculate the DEA renewal date based upon the expiration date (minus three years)
	export string10 createDEARenewDate(string8 date) := function
		myDate := STD.Date.FromStringToDate(date, '%Y%m%d');
		myYear := STD.Date.Year(myDate);
		myMonth := STD.Date.Month(myDate);
		myDay := STD.Date.Day(myDate);
		myAdjustedYear := myYear - 3;
		myAdjustedDate := STD.Date.DateFromParts(myAdjustedYear, myMonth, myDay);
		newDate := STD.Date.DateToString(myAdjustedDate, '%Y%m%d');
		return newDate;
	end;

	// calculate the date difference in days
	export integer dateDiffInDays(string8 first_date, string8 last_date) := function
		myFirstDate := STD.Date.FromString(first_date, '%Y%m%d');
		myLastDate := STD.Date.FromString(last_date, '%Y%m%d');
		myFirstDays := STD.Date.DaysSince1900(STD.Date.Year(myFirstDate), STD.Date.Month(myFirstDate), STD.Date.Day(myFirstDate));
		myLastDays := STD.Date.DaysSince1900(STD.Date.Year(myLastDate), STD.Date.Month(myLastDate), STD.Date.Day(myLastDate));
		return myLastDays - myFirstDays;
	end;
end;
