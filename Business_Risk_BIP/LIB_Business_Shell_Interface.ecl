IMPORT BIPV2, Business_Risk_BIP;

EXPORT LIB_Business_Shell_Interface (
									DATASET(Business_Risk_BIP.Layouts.Input) Input,
									Business_Risk_BIP.LIB_Business_Shell_LIBIN options
									) := INTERFACE
																						
	EXPORT DATASET(Business_Risk_BIP.Layouts.Shell) Results;
END;