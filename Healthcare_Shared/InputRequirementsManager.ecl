EXPORT InputRequirementsManager := Module
	Export CheckMinimumInput(dataset(Healthcare_Shared.Layouts.userInputCleanMatch) cleanInput, 
													 dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := Function
		runRules := map (Cfg[1].ProductRules = Healthcare_Shared.Constants.ProductRules_ProviderPoint => InputRequirements_ProviderPoint.Validation(cleanInput), 
										 Cfg[1].ProductRules = Healthcare_Shared.Constants.ProductRules_ClaimsCleanse => InputRequirements_ClaimsCleanse.Validation(cleanInput), 
										 InputRequirements_Default.Validation(cleanInput));
		return runRules;
	End;
End;