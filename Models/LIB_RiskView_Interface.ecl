IMPORT Models, Risk_Indicators;

EXPORT LIB_RiskView_Interface (
											GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) BocaShell,
											Models.RV_LIBIN arguments
																						) := INTERFACE
																						
	EXPORT DATASET(Models.Layout_ModelOut) Results;
END;