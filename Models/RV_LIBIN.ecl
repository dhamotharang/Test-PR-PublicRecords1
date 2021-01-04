IMPORT RiskView, Risk_Indicators;

EXPORT RV_LIBIN := INTERFACE
	EXPORT STRING30 modelName := '';
	EXPORT STRING50 IntendedPurpose := '';
	EXPORT BOOLEAN LexIDOnlyOnInput := FALSE;
	EXPORT BOOLEAN isCalifornia := FALSE;
	EXPORT BOOLEAN preScreenOptOut := FALSE;
	EXPORT STRING65 returnCode := '';
	EXPORT STRING65 payFrequency := '';
	EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := DATASET([], RiskView.Layouts.Layout_Custom_Inputs);
  EXPORT GROUPED DATASET(RiskView.Layouts.attributes_internal_layout_noscore) v5_Attrs := GROUP(DATASET([], RiskView.Layouts.attributes_internal_layout_noscore), seq);
  EXPORT DATASET(Risk_Indicators.layouts.layout_IDA_out) IDA_Attrs := DATASET([], Risk_Indicators.layouts.layout_IDA_out);
END;