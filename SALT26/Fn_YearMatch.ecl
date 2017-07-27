// In the non-tens case - simply the distance between the two years
// In the tens case we allow for a decade difference OR a year-difference
EXPORT Fn_YearMatch(UNSIGNED2 l,UNSIGNED2 r, UNSIGNED2 ym) := MAP( ym < 10 => ABS(l-r) <= ym,
																																	 ABS(l-r) <= ym % 10 => true,
																																	 r%10=l%10 AND ABS(l DIV 10 - r DIV 10) <= ym DIV 10 );
