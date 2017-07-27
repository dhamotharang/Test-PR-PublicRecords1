IMPORT AutoStandardI,BatchServices, lib_stringlib;

EXPORT GetDLParams := MODULE;
	EXPORT batch_params := INTERFACE(BatchServices.Interfaces.i_AK_Config)
		EXPORT UNSIGNED8 MaxResultsPerAcct := 2000;
		EXPORT BOOLEAN return_current_only := FALSE;
	END;
	
	EXPORT params := INTERFACE(AutoStandardI.LIBIN.PenaltyI.base,
														 AutoStandardI.DataPermissionI.params)
		EXPORT STRING dlState := '';
		EXPORT BOOLEAN skipSSNMasking := FALSE;
		EXPORT BOOLEAN skipDLMasking := FALSE;
		EXPORT BOOLEAN IncludeInsuranceDrivers := FALSE;
	END;
	shared input_params := AutoStandardI.GlobalModule();
	EXPORT getDefault() := MODULE(PROJECT(input_params, params, OPT))
		 STRING tmpDlSt := '' : STORED('DLState');
		 EXPORT STRING dlState := StringLib.StringToUpperCase(tmpDLSt);
		 export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		 EXPORT BOOLEAN IncludeInsuranceDrivers := FALSE : STORED('IncludeInsuranceDrivers');
	 END;
END;