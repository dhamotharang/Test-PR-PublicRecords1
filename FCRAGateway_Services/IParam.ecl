IMPORT AutoStandardI, FCRA, Gateway;

EXPORT IParam := MODULE
	EXPORT common_params := INTERFACE(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		AutoStandardI.InterfaceTranslator.dob_mask_value.params,
		AutoStandardI.InterfaceTranslator.dl_mask_val.params,
		AutoStandardI.InterfaceTranslator.application_type_val.params,
		AutoStandardI.DataRestrictionI.params,
		AutoStandardI.PermissionI_Tools.params,
		FCRA.iRules)
		EXPORT DATASET(Gateway.Layouts.Config) gateways;
		EXPORT BOOLEAN ReturnMatchedUniqueIDsOnly := FALSE;
	END;
END;