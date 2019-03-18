IMPORT AutokeyI, AutoStandardI, BatchShare, FCRA;

EXPORT IParam := MODULE
	
	export ids_params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface,
																AutoStandardI.InterfaceTranslator.location_value.params,
																AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params)
		export boolean workHard   := true;
		export boolean noFail     := false;
		export boolean isdeepDive := false;
		export boolean noDeepDive       := false;
		export unsigned2 MAX_DEEP_DIDS  := 100;
    export boolean zip_only_search := false;
	end;
	
	//should we keep this separated or merge it into search_params...?
	export functions_params := interface
		(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.location_value.params,
		AutoStandardI.InterfaceTranslator.application_type_val.params		
		)
		export boolean include_regaddrs   := false;
	  export boolean include_unregaddrs := false;
	  export boolean include_histaddrs  := false;
	  export boolean include_assocaddrs := false;
	  export boolean include_offenses := false;
	  export boolean include_bestaddress := false;
	  export boolean include_wealsofound := false;
		export string offenseCategory := '' ;
	  export boolean filterRecsByAltAddr := false;
	end;
	
	export search := interface(
		ids_params,
		functions_params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params,
		FCRA.iRules) // FFD FCRA
		export unsigned2 penalty_Threshold;
		export boolean	Include_BestAddress	:= false;
		export STRING offenseCategory := '';
		export STRING SmtWords := '';
	end;
			
	export report := interface(
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
		FCRA.iRules) // FFD FCRA
		export string60	Primary_Key	:= '';
		export string14 did;
		export boolean AllowGraphicDescription := false;
		export boolean Include_BestAddress := false;
		export string32 ApplicationType := '';
	end;

	export batch_params := INTERFACE (BatchShare.IParam.BatchParamsV2,FCRA.iRules)
	end;
	
END;