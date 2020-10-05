IMPORT NAC, Std;
/*
string ToMonth(string8 StartDate, integer n) := (string6)((integer)(StartDate[1..6]) + n - 1);

nac.Layouts.Collisions x2To1(NAC_V2.Layout_Collisions2.Layout_Collisions c2, integer n) := TRANSFORM
					self.SearchBenefitMonth := ToMonth(c2.StartDate, n);
					self.CaseBenefitMonth := self.SearchBenefitMonth;
					self.ClientEligibleStatusIndicator := c2.ClientEligibilityStatus;
					self := c2;
					self := [];
END;

integer dmonth(string8 StartDate, string8 enddate) := FUNCTION
	raw := (integer)(enddate[1..6]) - (integer)(StartDate[1..6]) + 1;
	RETURN CHOOSE(raw, 1, 2, 1);
END;
*/

day := (string8)Std.Date.Today() : INDEPENDENT;
month := day[1..6];

string6 GetMonth(string6 monStart, string6 monEnd) := 
				IF(monEnd <= month, monEnd,
					IF(monStart >= month, monStart,
						month));


nac.Layouts.Collisions x2To1(NAC_V2.Layout_Collisions2.Layout_Collisions c2, integer n) := TRANSFORM
					self.SearchBenefitMonth := GetMonth(c2.StartDate[1..6], c2.EndDate[1..6]);
					self.CaseBenefitMonth := self.SearchBenefitMonth;
					self.ClientEligibleStatusIndicator := c2.ClientEligibilityStatus;
					self := c2;
					self := [];
END;


EXPORT fn_Collisions2To1(dataset(NAC_V2.Layout_Collisions2.Layout_Collisions) c2) := FUNCTION

		//c1 := NORMALIZE(c2, dmonth(left.StartDate, left.EndDate), x2To1(left, COUNTER));
		c1 := PROJECT(c2, x2To1(left, 1));
		
		return c1;

END;