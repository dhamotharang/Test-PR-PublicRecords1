/*--LIBRARY--*/

IMPORT BIPV2, Business_Risk_BIP;

EXPORT LIB_Business_Shell (
							DATASET(Business_Risk_BIP.Layouts.Input) Input,
							Business_Risk_BIP.LIB_Business_Shell_LIBIN options
							) := MODULE

	ShellResults := Business_Risk_BIP.Business_Shell_Function(Input, options);
	
	EXPORT Results := ShellResults;
END;