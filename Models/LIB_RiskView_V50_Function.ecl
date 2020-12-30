IMPORT _Control, Models, Risk_Indicators, RiskView;

Use_RiskView_V50_Library := NOT _Control.LibraryUse.ForceOff_Models__LIB_RiskView_V50;

EXPORT LIB_RiskView_V50_Function (
											GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) BocaShell,
											STRING30 modelName_in = '',
											STRING50 IntendedPurpose_in = '',
											BOOLEAN LexIDOnlyOnInput_in = FALSE,
											BOOLEAN isCalifornia_in = FALSE,
											BOOLEAN preScreenOptOut_in = FALSE,
											STRING65 returnCode_in = '',
											STRING65 payFrequency_in = '',
											DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs_in = DATASET([], RiskView.Layouts.Layout_Custom_Inputs),
											GROUPED DATASET(RiskView.Layouts.attributes_internal_layout_noscore) Attr_in = GROUP(DATASET([], RiskView.Layouts.attributes_internal_layout_noscore), seq),
											DATASET(Risk_Indicators.layouts.layout_IDA_out) IDA_Attr_in = DATASET([], Risk_Indicators.layouts.layout_IDA_out)
                      ) := FUNCTION

arguments := MODULE(Models.RV_LIBIN)
	EXPORT STRING30 modelName := modelName_in;
	EXPORT STRING50 IntendedPurpose := IntendedPurpose_in;
	EXPORT BOOLEAN LexIDOnlyOnInput := LexIDOnlyOnInput_in;
	EXPORT BOOLEAN isCalifornia := isCalifornia_in;
	EXPORT BOOLEAN preScreenOptOut := preScreenOptOut_in;
	EXPORT STRING65 returnCode := returnCode_in;
	EXPORT STRING65 payFrequency := payFrequency_in;
	EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := Custom_Inputs_in;
	EXPORT GROUPED DATASET(RiskView.Layouts.attributes_internal_layout_noscore) v5_Attrs := Attr_in;
	EXPORT DATASET(Risk_Indicators.layouts.layout_IDA_out) IDA_Attrs := IDA_Attr_in;
END;

#if(Use_RiskView_V50_Library)
	model_results := LIBRARY('Models.LIB_RiskView_V50', Models.LIB_RiskView_Interface(BocaShell, arguments)).Results;
#else
	model_results := Models.LIB_RiskView_Models(BocaShell, arguments).V50Models;
#end
	RETURN(model_results);
END;