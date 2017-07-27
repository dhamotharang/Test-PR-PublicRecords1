IMPORT RiskView;

EXPORT RV_LIBIN := INTERFACE
	EXPORT STRING30 modelName := '';
	EXPORT STRING50 IntendedPurpose := '';
	EXPORT BOOLEAN LexIDOnlyOnInput := FALSE;
	EXPORT BOOLEAN isCalifornia := FALSE;
	EXPORT BOOLEAN preScreenOptOut := FALSE;
	EXPORT STRING65 returnCode := '';
	EXPORT STRING65 payFrequency := '';
	EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := DATASET([], RiskView.Layouts.Layout_Custom_Inputs);
END;