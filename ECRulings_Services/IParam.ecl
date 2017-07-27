import AutoKeyI, AutoStandardI;

EXPORT IParam := MODULE
	
	EXPORT autokey_search := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT boolean workHard := true;
		EXPORT boolean noFail := false;
		EXPORT boolean isdeepDive := false;
	END;
	
	EXPORT searchIds := INTERFACE(autokey_search)
	END;
	
	EXPORT searchrecords := INTERFACE(
			searchIds,
			AutoStandardI.LIBIN.PenaltyI_Indv.base,
			AutoStandardI.LIBIN.PenaltyI_Biz.base,
			AutoStandardI.InterfaceTranslator.glb_purpose.params,
			AutoStandardI.InterfaceTranslator.dppa_purpose.params,
			AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)
		EXPORT STRING8 DecisionStartDate        := '';
		EXPORT STRING8 DecisionEndDate          := '';
	END;
	
END;