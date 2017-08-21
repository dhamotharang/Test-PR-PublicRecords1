import ut,std;

export Constants := module
	export todayStr   := (STRING8)Std.Date.Today();
	export today1900  := ut.DaysSince1900( todayStr[1..4], todayStr[5..6], todayStr[7..8] );
	export today      := (unsigned4)todayStr;
	export todayMinus( integer days ) := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - days );
	export oneYrAgo   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(1));
	export twoYrAgo   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(2));
	export threeYrAgo := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(3));
	export fourYrAgo  := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(4));
	export fiveYrAgo  := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(5));
	export sixYrAgo   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(6));
	export YearsAgo(integer1 y)   := (unsigned4)ut.DateFrom_DaysSince1900(today1900 - ut.DaysInNYears(y));


end;