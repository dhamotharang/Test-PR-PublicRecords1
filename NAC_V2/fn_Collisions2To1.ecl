IMPORT NAC, Std;

nac.Layouts.Collisions x2To1(NAC_V2.Layout_Collisions2.Layout_Collisions c2, integer n) := TRANSFORM
					self.SearchBenefitMonth := c2.EndDate[1..6];
					self.CaseBenefitMonth := c2.CaseEndDate[1..6];
					self.ClientEligibleStatusIndicator := c2.ClientEligibilityStatus;
					self := c2;
					self := [];
END;

EXPORT fn_Collisions2To1(dataset(NAC_V2.Layout_Collisions2.Layout_Collisions) c2) := FUNCTION

		c1 := PROJECT(c2, x2To1(left, 1));

		return c1;

END;