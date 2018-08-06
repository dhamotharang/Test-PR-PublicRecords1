import FCRA, AutoStandardI;

export IParam := module

	export report_params := interface(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		FCRA.iRules)
		export boolean IncludeIncome  := false;
		export boolean IsRhodeIslandResident := false;
	end;

end;