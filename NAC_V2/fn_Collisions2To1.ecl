IMPORT NAC, Std;

day := (string8)Std.Date.Today() : INDEPENDENT;
month := day[1..6];

string6 GetMonth(string6 monStart, string6 monEnd) := 
				IF(monEnd <= month, monEnd,
					IF(monStart >= month, monStart,
						month));


nac.Layouts.Collisions x2To1(NAC_V2.Layout_Collisions2.Layout_Collisions c2) := TRANSFORM
					self.SearchBenefitMonth := GetMonth(c2.StartDate[1..6], c2.EndDate[1..6]);
					self.CaseBenefitMonth := self.SearchBenefitMonth;
					self.ClientEligibleStatusIndicator := c2.ClientEligibilityStatus;
					// append name suffix to last name
					self.SearchLastName := IF(c2.SearchSuffixName='',c2.SearchLastName,
																	TRIM(c2.SearchLastName) + ',' + TRIM(c2.SearchSuffixName));
					self.CaseLastName := IF(c2.CaseSuffixName='',c2.CaseLastName,
																	TRIM(c2.CaseLastName) + ',' + TRIM(c2.CaseSuffixName));
					self.ClientLastName := IF(c2.ClientSuffixName='',c2.ClientLastName,
																	TRIM(c2.ClientLastName) + ',' + TRIM(c2.ClientSuffixName));
					self := c2;
					self := [];
END;


EXPORT fn_Collisions2To1(dataset(NAC_V2.Layout_Collisions2.Layout_Collisions) c2) := FUNCTION

		c1 := PROJECT(c2, x2To1(left));
		
		return c1;

END;