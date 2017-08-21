// Whilst this is a general purpose date matching routine it is tied to 'reasonably' distributed dates in that it presumes
// Days and Months are both distributed evenly across their range and that the year span is less that 365 years
// Outside of those contraints the LT0 or GT6 values might be a point or two out
// Obviously they are encoded HERE so you can change if you wish
EXPORT MOD_DateMatch(UNSIGNED2 left_year, UNSIGNED1 left_month, UNSIGNED1 left_day,
                     UNSIGNED2 right_year, UNSIGNED1 right_month, UNSIGNED1 right_day,
										 BOOLEAN nulls_ok = false, BOOLEAN soft1 = false, BOOLEAN year_shift = false, BOOLEAN mddm = false) := MODULE
	SHARED year_eq := left_year = right_year OR year_shift AND ABS(left_year-right_year) < 2;
	SHARED year_nneq := year_eq OR nulls_ok AND ( left_year = 0 OR right_year = 0 );
	SHARED day_eq := left_day = right_day OR mddm AND left_day = right_month AND right_day = left_month;
	SHARED month_eq := left_month = right_month OR mddm AND left_day = right_month AND right_day = left_month;
	SHARED month_nneq := month_eq OR nulls_ok AND ( left_month = 0 or right_month = 0 ) OR soft1 AND ( left_month = 1 AND left_day = 1 OR right_month = 1 AND right_day = 1 );
	SHARED day_nneq := day_eq OR nulls_ok AND ( left_day = 0 OR right_day = 0 ) OR soft1 AND ( left_day = 1 OR right_day = 1 );
	
	// Are equal within fuzzy definitions
EXPORT Eq := year_eq AND month_eq AND day_eq;
  // Are not-not equal within fuzzy definitions
EXPORT NNEq := year_nneq AND month_nneq AND day_nneq;
 // BELOW this point the 'safe' thing to do is say 'YES' too often ....
 
  // This is designed to trap the FORCE(--) and gives a measure of having a 'good chance' of being >= 0
	// Basically requires NNEq OR at least one match and one nneq
EXPORT NLT0 := NNEq OR year_eq AND ( month_nneq OR day_nneq ) OR month_eq AND ( year_nneq OR day_nneq ) OR day_eq AND ( year_nneq OR month_nneq );
  // Traps the FORCE(+6) case
	// Requires two fields to match
EXPORT GT6 := year_eq AND month_eq OR month_eq AND day_eq OR day_eq AND year_eq;
  // This is designed to trap the FORCE(--6) and is designed to show nullity or a strongish match
EXPORT NLT6 := NNEq OR GT6;
  END;
