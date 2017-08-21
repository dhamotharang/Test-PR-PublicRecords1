// temporary
import NAC;
EXPORT NAC_V2.Layout_Collisions2.Layout_Collisions  xCollisions1To2(nac.Layouts.Collisions c) := TRANSFORM

			self.StartDate := c.SearchBenefitMonth + '01';
			self.EndDate := c.SearchBenefitMonth + fn_LastDayOfMonth(c.SearchBenefitMonth);

			self.SearchCleanSSN := c.SearchSSN;
			self.ClientCleanSSN := c.ClientSSN;
			self.SearchCleanDOB := c.SearchDOB;
			self.ClientCleanDOB := c.ClientDOB;
			
			SELF := c;
			self := [];

END;