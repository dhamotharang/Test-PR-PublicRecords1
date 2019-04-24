/*2016-01-25T19:35:35Z (laura Weiner_prod)
Pass in boca shell for SBBM model
*/
IMPORT _Control, Business_Risk_BIP, Models, RiskView, Risk_Indicators;

Use_BusinessRisk_Library := FALSE; // TODO: add _Control.LibraryUse.ForceOff_Models__BusinessRisk;

EXPORT LIB_BusinessRisk_Function (
											GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell,
											STRING30 modelName_in = '',
											GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) bocaShell = GROUP(DATASET([], Risk_Indicators.Layout_Boca_Shell), seq),
											DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs_in = DATASET([], RiskView.Layouts.Layout_Custom_Inputs)
																							) := FUNCTION

	arguments := MODULE(Models.BR_LIBIN)
		EXPORT STRING30 modelName := modelName_in;
		EXPORT DATASET(RiskView.Layouts.Layout_Custom_Inputs) Custom_Inputs := Custom_Inputs_in;
	END;

	#if(Use_BusinessRisk_Library)
		model_results := LIBRARY('Models.LIB_BusinessRisk_Models', Models.LIB_BusinessRisk_Interface(busShell, arguments, bocaShell)).Results;
	#else
		model_results := Models.LIB_BusinessRisk_Models(busShell, arguments, bocaShell).SmallBusinessModels;
	#end
		RETURN(model_results);
END;