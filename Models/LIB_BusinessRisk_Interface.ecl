IMPORT Business_Risk_BIP;

EXPORT LIB_BusinessRisk_Interface (
											GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell,
											Models.BR_LIBIN arguments
																						) := INTERFACE
																						
	EXPORT DATASET(Models.Layout_ModelOut) Results;
END;