// Code taken from TX_Drivers.Fn
import lib_date;

export string8 julToYYYYMMDD(string7 julian_date):= FUNCTION
year:=julian_date[1..4];
integer3 doy:=(integer3)julian_date[5..7];
integer2 febdays:=IF(lib_date.LeapYear((integer)year),60,59);
integer2 month:= MAP(doy > 334 =>12,
                       doy > 304 =>11,
											 doy > 273 =>10,
											 doy > 243 =>9,
											 doy > 212 =>8,
											 doy > 181 =>7,
											 doy > 151 => 6,
											 doy > 120 =>5,
											 doy >  90 =>4,
											 doy > febdays => 3 ,
											 doy > 31 =>2,
											 doy > 0 =>1,
											 -1);
integer2 calc_days:=(integer)doy -
		CHOOSE( month,0,31,59,90,120,151,181,212,243,273,304,334 );
integer2 days:= calc_days- IF(lib_date.LeapYear((integer)year) and month > 2, 1, 0);
return if(month < 0,'**ERROR',year+INTFORMAT(month,2,1)+INTFORMAT(days,2,1));
END;