divide(INTEGER	dividend ,INTEGER	divisor) := FUNCTION
	decimal8_2 x := (dividend*1000)/divisor;
	x1 := ROUND(x);
	decimal6_1 v := x1/10;	
	return (string)v;	
END;
// idx > true means allow values > 100
EXPORT get_pct(INTEGER	dividend ,INTEGER	divisor, boolean idx = false)
  :=		
			MAP(
				divisor=0 => '-1',
				~idx AND (dividend >= divisor) => '100',
				divide(dividend, divisor)
			);
