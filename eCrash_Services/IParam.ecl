import AutoKeyI, AutoStandardI;

export IParam := module
	
	export autokey_search := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard   			:= true;
		export boolean noFail     			:= true;
		export boolean isdeepDive 			:= false;
	end;

	
	export search := interface(autokey_search)
		export unsigned2 MAX_DEEP_DIDS  := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
		
		export string ReportNumber  		:= '';
	  export string Jurisdiction      := '';
	  export string JurisdictionState      := '';
		export string AccidentLocationStreet 	:= '';
		export string AccidentLocationCrossStreet 	:= '';
		export string DateOfLoss 				:= '';
		export string DolStartDate 				:= '';
		export string DolEndDate 				:= '';
		export boolean GroupRecords     := false;
		export boolean SubscriptionReports     := false;
		export integer MaxLimit       := 750;
		export string SortOrder 				:= '';
		export string SortField 				:= '';
		export string UserType 				:= '';
		export boolean RequestHashKey := false;
		export string AgencyORI :='';
		export string200 SqlSearchEspURL := '';
		export string SqlSearchEspNAME := '';
	end;
	
	export searchrecords := interface(
		search,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		// AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,
		// AutoStandardI.LIBIN.PenaltyI_Biz.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)
	end;
	
end;