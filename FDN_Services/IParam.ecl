IMPORT iesp, AutoKeyI, AutoStandardI;

export IParam := module
	
	export autokey_search := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard   := true;
		export boolean noFail     := false;
		export boolean isdeepDive := false;
    export boolean mask_dl    := false;
	end;
	
	export search := interface(autokey_search,AutoStandardI.InterfaceTranslator.application_type_val.params)
	end;
	
	export searchrecords := interface(
		search)
	end;

END;