IMPORT NAC, Std;

nac.Layouts.Collisions x2To1(NAC_V2.Layout_Collisions2.Layout_Collisions c2, integer n) := TRANSFORM
					self.SearchBenefitMonth := c2.StartDate[1..6];
					self := c2;
END;

EXPORT fn_Collisions2To1(NAC_V2.Layout_Collisions2.Layout_Collisions c2) := FUNCTION

		c1 := PROJECT(c2, x2To1(left, 1));

		return c1;

END;