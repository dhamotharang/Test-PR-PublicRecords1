divide(INTEGER	dividend ,INTEGER	divisor) := FUNCTION
	decimal8_2 x := (dividend*1000)/divisor;
	x1 := ROUND(x);
	decimal6_1 v := x1/10;	
	return v;	
END;
// 
EXPORT decimal6_1 get_pct(INTEGER	dividend ,INTEGER	divisor)
  :=		
			MAP(
				divisor=0 => -1,
				divide(dividend, divisor)
			);
