integer find_year(integer days1) := ((INTEGER)(days1 / 365.25)) + 1900;
integer MonthsDays(integer days2) := ROUNDUP(days2 - ((find_year(days2) - 1901) * 365.25 + 365));

integer months(integer days3) := if(~leapYear(find_year(days3)),
which(MonthsDays(days3)<32,MonthsDays(days3)<60,MonthsDays(days3)<91,MonthsDays(days3)<121,
		MonthsDays(days3)<152,MonthsDays(days3)<182,MonthsDays(days3)<213,MonthsDays(days3)<244,
		MonthsDays(days3)<274,MonthsDays(days3)<305,MonthsDays(days3)<335 ,true),
which(MonthsDays(days3)<32,MonthsDays(days3)<61,MonthsDays(days3)<92,MonthsDays(days3)<122,
		MonthsDays(days3)<153,MonthsDays(days3)<183,MonthsDays(days3)<214,MonthsDays(days3)<245,
		MonthsDays(days3)<275,MonthsDays(days3)<306,MonthsDays(days3)<336 ,true));


integer days_in(integer days4) := monthsDays(days4) - if(leapYear(find_year(days4)) and months(days4)>2,1,0) -
 map(months(days4)=1=>0,
	 months(days4)=2=>31,
	 months(days4)=3=>59,
     months(days4)=4=>90,
     months(days4)=5=>120,
     months(days4)=6=>151,
     months(days4)=7=>181,
     months(days4)=8=>212,
     months(days4)=9=>243,
     months(days4)=10=>273,
     months(days4)=11=>304,334);
			

export DateFrom_DaysSince1900(integer days) := intformat(find_year(days),4,1) +
		intformat(months(days),2,1) +
		intformat(days_in(days),2,1);