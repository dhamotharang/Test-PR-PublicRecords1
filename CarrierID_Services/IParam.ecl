import AutoKeyI, AutoStandardI;

export IParam := module
	
	export autokey_search := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard   			:= true;
		//export boolean noFail     			:= true;
		export boolean isdeepDive 			:= false;
	end;

	export search := interface(autokey_search)
		export unsigned2 MAX_DEEP_DIDS       := 100;
		export unsigned2 MAX_DEEP_BDIDS      := 100;
		export string    AccidentNumber      := '';
		export string    DateOfLoss 		     := '';
		export string30  VIN                 := '';
		export string24  DriverLicenseNumber := '';
		export string2   DriverLicenseState  := '';
	end;
	
	export searchrecords := interface(
		search,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.dl_mask_value.params)
	end;
	
end;