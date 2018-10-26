// Whilst this is a general purpose date matching routine it is tied to 'reasonably' distributed dates in that it presumes
// Days and Months are both distributed evenly across their range and that the year span is less that 365 years
// Outside of those contraints the LT0 or GT6 values might be a point or two out
// Obviously they are encoded HERE so you can change if you wish
// NNEQ will allow one side to be completely null
// EQ insists on some amount of non-nullity
IMPORT Std;
EXPORT MOD_DateMatch(UNSIGNED2 left_year, UNSIGNED1 left_month, UNSIGNED1 left_day,
                     UNSIGNED2 right_year, UNSIGNED1 right_month, UNSIGNED1 right_day,
										 BOOLEAN nulls_ok = false, BOOLEAN soft1 = false, UNSIGNED1 year_shift = 0, BOOLEAN mddm = false,
										 UNSIGNED2 day_distance = 0, UNSIGNED1 edit_distance = 0) := MODULE
	SHARED year_eq := left_year = right_year OR year_shift>0 AND FN_YearMatch(left_year,right_year,year_shift);
	SHARED year_nneq := year_eq OR nulls_ok AND ( left_year = 0 OR right_year = 0 );
	SHARED day_eq := left_day = right_day OR mddm AND left_day = right_month AND right_day = left_month;
	SHARED month_eq := left_month = right_month OR mddm AND left_day = right_month AND right_day = left_month;
	SHARED month_nneq := month_eq OR nulls_ok AND ( left_month = 0 or right_month = 0 ) OR soft1 AND ( left_month = 1 AND left_day = 1 OR right_month = 1 AND right_day = 1 );
	SHARED day_nneq := day_eq OR nulls_ok AND ( left_day = 0 OR right_day = 0 ) OR soft1 AND ( left_day = 1 OR right_day = 1 );
  SHARED within_days := WithinDays(left_year, left_month,left_day, right_year,right_month,right_day, day_distance );	
	SHARED within_edit := WithinEditN((StrType)Std.Date.DateFromParts(left_year, left_month,left_day), (StrType)Std.Date.DateFromParts(right_year,right_month,right_day), edit_distance);
  // Are not-not equal within fuzzy definitions
  SHARED NNEq0 := year_nneq AND month_nneq AND day_nneq;
	EXPORT NNEq := MAP(day_distance>0 AND edit_distance>0 => NNEq0 OR within_days OR within_edit,
		                 day_distance>0 => NNEq0 OR within_days,
										 edit_distance>0 => NNEq0 OR within_edit,
										 NNEq0);
	// Are equal within fuzzy definitions
  SHARED Eq0 := NNEQ AND ( year_eq AND left_year <> 0 OR month_eq AND left_month <> 0 OR day_eq AND left_day <> 0);
	EXPORT Eq := MAP(day_distance>0 AND edit_distance>0 => Eq0 OR within_days OR within_edit,
	                 day_distance>0 => Eq0 OR within_days,
									 edit_distance>0 => Eq0 OR within_edit,
									 Eq0);
 // BELOW this point the 'safe' thing to do is say 'YES' too often ....
 
  // This is designed to trap the FORCE(--) and gives a measure of having a 'good chance' of being >= 0
	// Basically requires NNEq OR at least one match and one nneq
  SHARED NLT0_0 := NNEq OR year_eq AND ( month_nneq OR day_nneq ) OR month_eq AND ( year_nneq OR day_nneq ) OR day_eq AND ( year_nneq OR month_nneq );
	EXPORT NLT0 := MAP(day_distance>0 AND edit_distance>0 => NLT0_0 OR within_days OR within_edit,
	                 day_distance>0 => NLT0_0 OR within_days,
									 edit_distance>0 => NLT0_0 OR within_edit,
									 NLT0_0);
	
  // Traps the FORCE(+6) case
	// Requires two fields to match
  SHARED GT6_0 := year_eq AND month_eq OR month_eq AND day_eq OR day_eq AND year_eq;
	EXPORT GT6 := MAP(day_distance>0 AND edit_distance>0 => GT6_0 OR within_days OR within_edit,
	                 day_distance>0 => GT6_0 OR within_days,
									 edit_distance>0 => GT6_0 OR within_edit,
									 GT6_0);
	
  // This is designed to trap the FORCE(--6) and is designed to show nullity or a strongish match
  SHARED NLT6_0 := NNEq OR GT6;
	EXPORT NLT6 := MAP(day_distance>0 AND edit_distance>0 => NLT6_0 OR within_days OR within_edit,
	                 day_distance>0 => NLT6_0 OR within_days,
									 edit_distance>0 => NLT6_0 OR within_edit,
									 NLT6_0);
  END;
