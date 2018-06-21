IMPORT AutoStandardI, FCRA, Gateway;

EXPORT IParam := MODULE
	EXPORT common_params := INTERFACE(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		AutoStandardI.InterfaceTranslator.dob_mask_value.params,
		FCRA.iRules)
		EXPORT DATASET(Gateway.Layouts.Config) gateways;
		EXPORT BOOLEAN ReturnMatchedUniqueIDsOnly := FALSE;
	END;
END;