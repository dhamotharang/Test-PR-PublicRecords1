EXPORT InputRequirements_ClaimsCleanse := Module
	Export Rules(Healthcare_Shared.Layouts.userInputValidation inRec) := Function
		retValue := row({false,0},Healthcare_Shared.Layouts.userInputValidationResults);
		return retValue;
	end;
	Export Validation(dataset(Healthcare_Shared.Layouts.userInputCleanMatch) rawInput) := Function
		recs := Project(rawInput, transform(Healthcare_Shared.Layouts.userInputCleanMatch,
																				myRules:=Rules(left.ValidInputs);
																				self.ValidInputs.hasValidationError := myRules.hasValidationError;
																				self.ValidInputs.ErrorID := myRules.ErrorID;
																				self:= left;));
		return recs;
	end;
End;