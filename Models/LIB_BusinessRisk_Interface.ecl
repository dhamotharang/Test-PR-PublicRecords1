IMPORT Business_Risk_BIP, Models, Risk_Indicators, RiskView,UT,RiskWise ;

EXPORT LIB_BusinessRisk_Interface (
											GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell,
											Models.BR_LIBIN arguments,
                      GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) bocaShell,
											GROUPED DATASET(Risk_Indicators.Layout_Output) iid,
											DATASET(riskwise.Layout_IP2O) ips,
                      unsigned1 DPPA=0,
                      unsigned1 GLB=0,
                      string DataRestriction,
                      string DataPermission
                      ) := INTERFACE
																						
	EXPORT DATASET(Models.Layout_ModelOut) Results;
END;