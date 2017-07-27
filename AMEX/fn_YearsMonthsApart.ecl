import ut;
export fn_YearsMonthsApart(unsigned3 date1yyyymm,unsigned3 date2yyyymm) := FUNCTION
	// unsigned2 days := (ut.DaysApart((string)date1yyyymm+'01',(string)date2yyyymm+'01')) ;
	// unsigned2 years1 := days / 365 ;
  // string8 yearsStr1 := if (years1 > 0,((string)years1) + 'Y','');
	// unsigned2 months1 := ((days /365) - (integer)(days /365)) / .083 ;
	// string8 monthsStr1 := if (months1 > 0, ((string)months1) + 'M','');
	// time :=  trim(trim(yearsStr1) + ' ' + monthsStr1, LEFT);
	
	// RETURN time;
	
	length_of_residence := if(date1yyyymm=0 or date2yyyymm=0, '', 
									(string)(round((ut.DaysApart((string)date1yyyymm, (string)date2yyyymm)) / 30)) 
									);
																												
	return length_of_residence;																											

END;