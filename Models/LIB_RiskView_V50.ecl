/*--LIBRARY--*/

IMPORT Models, Risk_Indicators;

EXPORT LIB_RiskView_V50 (
											GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) BocaShell,
											Models.RV_LIBIN arguments
																	) := MODULE

	modelResults := Models.LIB_RiskView_Models(BocaShell, arguments).V50Models;
	
	EXPORT Results := modelResults;
END;