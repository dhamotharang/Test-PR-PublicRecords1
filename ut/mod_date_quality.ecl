// Assess the quality of the input date value (inspired by and useful for replacing ut.date_quality)
//
// Full-quality dates are represented as YYYYMMDD.  When month or day are unknown, we generally like
// to see that represented with MM=00 or DD=00.  However, vendors will sometimes use 01 to represent
// unknowns -- this is very unfortunate, because those values are also used to represent January or
// the first day of a month.  Because of this ambiguity, we refer to 01 values as "weak", except when
// MM=01 and we have a non-weak DD.
//
// When the supplied MM or DD values are too large to describe an actual date on the calendar, we
// refer to them as "invalid".  We also consider YYYY to be invalid if it's outside the range 1850
// thru 100 years in the future.
//
// Quality is returned as an integer between 0 and 6 (inclusive), higher values indicating higher quality.
//
// When maskWeak=true is passed, we convert weak MM or DD values to 00, and consider them to be unknown
// values when determining quality.
//
// When maskInvalid is passed, we convert invalid MM or DD values to 00, treating the date as lower-quality
// rather than completely bogus.
// 
import ut;
export mod_date_quality(unsigned in_date, boolean maskWeak=false, boolean maskInvalid=false) := module
	shared in_yyyy	:= in_date DIV 10000;
	shared in_mm		:= (in_date % 10000) DIV 100;
	shared in_dd		:= in_date % 100;
	
	shared min_year	:= 1850;
	shared max_year	:= (unsigned)ut.GetDate[1..4] + 100;
	shared max_dd		:= map(
		in_mm=0							=> 1,
		in_mm=2							=> if(in_yyyy%4=0 and in_yyyy%100<>0 or in_yyyy%400=0, 29, 28),
		in_mm in [4,6,9,11]	=> 30,
		in_mm<=12						=> 31,
		1);
	
	shared yyyy := if(in_yyyy between min_year and max_year, in_yyyy, -1);
	
	shared mm := map(
		in_mm=1 and (in_dd<2 or in_dd>max_dd) => if(maskWeak,0,1),
		in_mm<=12 => in_mm,
		if(maskInvalid,0,-1));
	
	shared dd := map(
		in_dd=1				=> if(maskWeak,0,1),
		in_dd<=max_dd	=> in_dd,
		if(maskInvalid,0,-1));
	
	shared invalid := yyyy=-1 or mm=-1 or dd=-1;
	
	export unsigned quality := map(
		invalid				=> 0,	// invalid
		mm=0					=> 2, // YYYY
		mm=1 and dd<2	=> 3, // YYYY + weak MM
		dd=0					=> 4, // YYYY + MM
		dd=1					=> 5, // YYYY + MM + weak DD
		6);									// YYYY + MM + DD
	
	export normDate := if(invalid, 0, yyyy*10000 + mm*100 + dd);
end;