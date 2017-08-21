// This function calculates the minimum number of whole months by which two dates differ
EXPORT UNSIGNED MonthsApart(STRING8 date1, STRING8 date2) := FUNCTION

	DAYS := [0,31,29,31,30,31,30,31,31,30,31,30,31];
	
	year1  := (INTEGER3)date1[1..4];
	month1 := IF((INTEGER2)date1[5..6] NOT BETWEEN 1 AND 12,0,(INTEGER2)date1[5..6]);
	day1   := IF((INTEGER2)date1[7..8] NOT BETWEEN 1 AND DAYS[month1+1],0,(INTEGER2)date1[7..8]);
	
	year2  := (INTEGER3)date2[1..4];
	month2 := IF((INTEGER2)date2[5..6] NOT BETWEEN 1 AND 12,0,(INTEGER2)date2[5..6]);
	day2   := IF((INTEGER2)date2[7..8] NOT BETWEEN 1 AND DAYS[month2+1],0,(INTEGER2)date2[7..8]);
	
	higherdate1 :=
		(year1 > year2) OR
		(year1 = year2 AND month1 > month2) OR
		(year1 = year2 AND month1 = month2 AND day1 > day2);
	
	yeara0 := IF(higherdate1,year1,year2);
	montha0 := IF(higherdate1,month1,month2);
	daya0 := IF(higherdate1,day1,day2);
	
	yeara := yeara0;
	montha := IF(montha0 = 0,1,montha0);
	daya := IF(montha0 = 0 OR daya0 = 0,1,daya0);
	
	yearb0 := IF(higherdate1,year2,year1);
	monthb0 := IF(higherdate1,month2,month1);
	dayb0 := IF(higherdate1,day2,day1);
	
	yearb := yearb0;
	monthb := IF(monthb0 = 0,12,monthb0);
	dayb := IF(monthb0 = 0 OR dayb0 = 0,DAYS[monthb + 1],dayb0);
	
	diff_months :=
		((yeara - yearb) * 12) +
		(montha - monthb) +
		IF(daya >= dayb,0,-1);
	
	return diff_months;

END;
