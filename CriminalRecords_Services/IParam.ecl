IMPORT AutokeyI, AutoStandardI, SexOffender_Services, FCRA, Gateway;

EXPORT IParam := MODULE
	
	export ak_params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	
	export ids_params := interface
		export string14 did;
		export string25 doc_number := '';
		export string35 case_number := '';
		export string60 offender_key := '';
	end;
	
	export search := interface(
		ak_params,
		ids_params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.application_type_val.params,
		AutoStandardI.InterfaceTranslator.noDeepDive.params,
		FCRA.iRules)
		export unsigned2	MAX_DEEP_DIDS := 100;
	  export string30		county_in := '';
		export string2 		FilingJurisdictionState 	 :='';
		export string8    CaseFilingStartDate        := '';
		export string8    CaseFilingEndDate          := '';
		
	end;
		
	export report := interface(
		ids_params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		// AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		SexOffender_Services.IParam.report,
		FCRA.iRules)
		export boolean IncludeSexualOffenses;
		export boolean IncludeAllCriminalRecords;
		export dataset(Gateway.Layouts.Config) gateways := dataset([], Gateway.Layouts.Config);
		export boolean SkipPersonContextCall := true;
	end;
	
END;