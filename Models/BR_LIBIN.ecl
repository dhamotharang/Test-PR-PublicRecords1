IMPORT RiskView;

EXPORT BR_LIBIN := INTERFACE
	EXPORT STRING30 modelName := '';
	EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := DATASET([], RiskView.Layouts.Layout_Custom_Inputs);
END;